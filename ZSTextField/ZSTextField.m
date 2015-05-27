//
//  SNMainTextField.m
//  SNCommunicate
//
//  Created by ZhuiYi on 15/4/17.
//  Copyright (c) 2015年 ZhuiYi. All rights reserved.
//

#import "ZSTextField.h"
#import "AppDelegate.h"
#define ZSScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ZSScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ZSWindow        [UIApplication sharedApplication].keyWindow

@interface ZSTextField ()<UITextFieldDelegate>

@end

@implementation ZSTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
    }
    return self;
}

/**
 *  键盘将要显示
 *
 *  @param notification 通知对象
 */
- (void)keyboardWillShow:(NSNotification*)notification
{
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat convertY = [self.superview convertPoint:self.frame.origin toView:ZSWindow].y + self.frame.size.height + 10;
    if (convertY >= keyboardRect.origin.y) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            ZSWindow.transform = CGAffineTransformMakeTranslation(0, -keyboardRect.size.height + ZSScreenHeight - convertY);
        } completion:nil];
    }
    else {
        return;
    }
}

/**
 *  键盘将要隐藏
 *
 *  @param notification 通知对象
 */
- (void)keyboardWillHide:(NSNotification*)notification
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        ZSWindow.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
}


/**
 *  superViewY -> windowY
 *
 *  @param Y superView的Y
 *
 *  @return window的Y
 */
- (CGFloat)convertYToWindow:(float)Y
{
    CGPoint point = [self convertPoint:CGPointMake(0, Y) toView:ZSWindow];
    return point.y * 0.5;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
