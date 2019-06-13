//
//  JKRSearchBar.m
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/5.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRSearchBar.h"
#import "JKRSearchTextField.h"
#import "NSString+DCFontSize.h"

UIKIT_EXTERN NSString *SEARCH_CANCEL_NOTIFICATION_KEY;

@interface JKRSearchBar ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) JKRSearchTextField *searchTextField;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, assign) CGFloat placeholderW;

@end

@implementation JKRSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, kScreenWidth, 44);
    self = [super initWithFrame:frame];
    self.backgroundColor = JKRColor(243, 243, 243, 1.0);
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.searchTextField];
    [self addSubview:self.rightButton];
    [self addSubview:self.cancelButton];
    return self;
}

- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    if (_isEditing) {
        [UIView animateWithDuration:0.2 animations:^{
            self.searchTextField.x = 10;
            self.rightButton.x = kScreenWidth - 38 - 40;
            self.backgroundImageView.width = kScreenWidth - 20 - 40;
            self.cancelButton.x = kScreenWidth - 40;
        } completion:nil];
        self.searchTextField.canTouch = YES;
        [self.searchTextField becomeFirstResponder];
    } else {
        self.searchTextField.text = @"";
        self.text = @"";
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:0.2 animations:^{
            self.searchTextField.x = (kScreenWidth - self.placeholderW) * 0.5;
            self.rightButton.x = kScreenWidth - 38;
            self.backgroundImageView.width = kScreenWidth - 20;
            self.cancelButton.x = kScreenWidth;
        } completion:nil];
        self.searchTextField.canTouch = NO;
        [self.searchTextField resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (self.searchTextField.text.length == 0) return YES;
    [self setUpdatePlaceholderSize]; // 因为要居中得重写计算size
    [UIView animateWithDuration:0.3 animations:^{
        self.searchTextField.x = (kScreenWidth - self.placeholderW) * 0.5;
    } completion:nil];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        self.searchTextField.x = 10;
    } completion:nil];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

- (void)textFieldDidChange {
    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:self textDidChange:self.searchTextField.text];
    }
    self.text = self.searchTextField.text;
    if (self.searchTextField.text.length) {
        [_rightButton setImage:[UIImage imageNamed:@"card_delete"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"card_delete"] forState:UIControlStateHighlighted];
    } else {
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
    }
}

- (void)cancelButtonClick {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SEARCH_CANCEL_NOTIFICATION_KEY object:nil];
}

- (void)rightButtonClick {
    
    if (self.searchTextField.text) {
        self.searchTextField.text = @"";
        self.text = nil;
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
        if (_isEditing) {
            self.searchTextField.x = 10;
        }
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.searchTextField.placeholder = self.placeholder;
    
    [self setUpdatePlaceholderSize];
    _searchTextField.frame = CGRectMake((kScreenWidth - self.placeholderW) * 0.5, 0, (!_isEditing) ? self.placeholderW : kScreenWidth - 20 - 38 - 40, 44);
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"widget_searchbar_textfield"]];
        _backgroundImageView.frame = CGRectMake(10, 8, kScreenWidth - 20, 44 - 16);
    }
    return _backgroundImageView;
}

- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[JKRSearchTextField alloc] initWithFrame:CGRectZero];
        _searchTextField.canTouch = NO;
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchContactsBarIcon"]];
        searchIcon.contentMode = UIViewContentModeScaleAspectFit;
        searchIcon.frame = CGRectMake(0, 0, 30, 14);
        _searchTextField.leftView = searchIcon;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.font = [UIFont systemFontOfSize:16.0f];
        [_searchTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.frame = CGRectMake(kScreenWidth - 38, 8, 28, 28);
    }
    return _rightButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(kScreenWidth, 0, 40, 44);
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelButton setTitle:@"取消  " forState:UIControlStateNormal];
        [_cancelButton setTitleColor:JKRColor(85, 183, 55, 1.0) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}


#pragma mark - 更新输入框尺寸
- (void)setUpdatePlaceholderSize
{
    NSString *content = (self.searchTextField.text.length == 0) ? self.searchTextField.placeholder : self.searchTextField.text;
    CGSize placeholderSize = [NSString dcSizeWithString:content Font:_searchTextField.font MaxSize:CGSizeMake(MAXFLOAT, 44)];
    self.placeholderW = placeholderSize.width + 30;
}

- (void)dealloc {
    NSLog(@"JKRSearchBar dealloc");
}

@end
