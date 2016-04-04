//
//  PassWordTextField.h
//  支付宝微信密码输入框
//
//  Created by 汪涛 on 16/3/15.
//  Copyright © 2016年 汪涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassWordTextField : UIView

@property(copy,nonatomic) void(^completeHandle)(NSString *passWord);

//密码验证失败
@property(assign,nonatomic)BOOL passWordFailed;

@end
