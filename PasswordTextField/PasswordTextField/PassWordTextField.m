//
//  PassWordTextField.m
//  支付宝微信密码输入框
//
//  Created by 汪涛 on 16/3/15.
//  Copyright © 2016年 汪涛. All rights reserved.
//

#import "PassWordTextField.h"

#define pwd_count 6 //密码长度
#define dot_width 10  //小黑点宽度

@interface PassWordTextField()<UITextFieldDelegate>

@property(strong,nonatomic)UITextField *textField;

@property(strong,nonatomic)NSMutableArray *pwdIndicatorArr;

@end
@implementation PassWordTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.cornerRadius = 5.0f;

        _textField = [[UITextField alloc] initWithFrame:self.bounds];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField becomeFirstResponder];
        _textField.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _textField.delegate = self;
        _textField.hidden = YES;
        [self addSubview:_textField];
        
        //添加分割线和小黑点
        self.pwdIndicatorArr = [NSMutableArray array];
        for (int i = 0; i < pwd_count; i++) {
            
            //单个格子的宽高
            CGFloat width = frame.size.width/6;
            CGFloat height = frame.size.height;
            
            //添加小黑点
            UILabel *dot = [[UILabel alloc] initWithFrame:CGRectMake(i *width + (width - dot_width) * 0.5, (height - dot_width) * 0.5, dot_width, dot_width)];
            dot.layer.cornerRadius = dot_width * 0.5;
            dot.backgroundColor = [UIColor blackColor];
            dot.hidden = YES;
            dot.clipsToBounds = YES;
            [self addSubview:dot];
            [self.pwdIndicatorArr addObject:dot];
            
            if (i == pwd_count - 1) {
                continue;
            }
            //分割线
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake((i+1) * width, 0, 0.5, height)];
            line.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
            [self addSubview:line];
        }
        
    }
    
    return self;
}

- (void)setPassWordFailed:(BOOL)passWordFailed
{
    _passWordFailed = passWordFailed;
    if (passWordFailed) {
        //1s动画
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position.x";
        animation.values = @[ @0, @15, @-15, @15, @0 ];
        animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
        animation.duration = 0.4;
        
        animation.additive = YES;
        [self.layer addAnimation:animation forKey:@"shake"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= pwd_count && string.length) {
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }
    
    NSString *totalString;
    if (string.length <= 0) { //这种情况是删除的时候if条件成立
        totalString = [textField.text substringToIndex:textField.text.length-1];
    }
    else {
        totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    
    //显示小圆点
    [self setDotWithCount:totalString.length];
    
    if (totalString.length == pwd_count) {
        
        if (self.completeHandle) {
            
            self.completeHandle(totalString);
        }
        
        //从父视图上移除
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.0f];
    }
    return YES;
}

- (void)setDotWithCount:(NSInteger) count
{
    
    for (UILabel *dot in self.pwdIndicatorArr) {
        dot.hidden = YES;
    }
    
    for (int i = 0; i< count; i++) {
        ((UILabel*)[self.pwdIndicatorArr objectAtIndex:i]).hidden = NO;
    }
}

- (void)dismiss
{
    [self.textField resignFirstResponder];
    [UIView animateWithDuration:0.1f animations:^{
        
        self.transform = CGAffineTransformMakeScale(0.66f, 0.66f);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
