//
//  ViewController.m
//  PasswordTextField
//
//  Created by 汪涛 on 16/4/3.
//  Copyright © 2016年 汪涛. All rights reserved.
//

#import "ViewController.h"
#import "PassWordTextField.h"

@interface ViewController ()<UIAlertViewDelegate>

@property(strong,nonatomic)PassWordTextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPassWordTextField];
    
}

- (void)initPassWordTextField
{
    CGFloat width = self.view.bounds.size.width - 80;
    PassWordTextField *textField = [[PassWordTextField alloc] initWithFrame:CGRectMake( 40, 100,width , width/6)];
    [self.view addSubview:textField];
    self.textField = textField;
    
    __weak typeof(self) weakself = self;
    textField.completeHandle = ^(NSString *passWord){
    
        if (![passWord isEqualToString:@"123456"]) {
            weakself.textField.passWordFailed = YES;
        }else{
            [weakself showPassWordWithTitle:@"输入的密码" andMessage:passWord];

        }
    };
}

- (void)showPassWordWithTitle:(NSString *)title andMessage:(NSString *)message
{
    NSString *cancelButtonTitle = @"取消";
    NSString *otherButtonTitle = @"确定";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        

    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
