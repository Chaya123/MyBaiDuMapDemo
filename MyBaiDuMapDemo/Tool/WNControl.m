//
//  WNControl.h
//  MineDemo
//
//  Created by liu on 16/5/22.
//  Copyright (c) 2016年 liu. All rights reserved.
//

#import "WNControl.h"
@implementation WNControl

+(UITextField*)createTextFieldFrame:(CGRect)frame andPlaceholder:(NSString*)placeholder andBgImageName:(NSString*)imageName andLeftView:(UIView*)leftView andRightView:(UIView*)rightView andIsPassWord:(BOOL)isPassWord
{
    
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    if (placeholder) {
        textField.placeholder=placeholder;
    }
    if (imageName) {
        textField.background=[UIImage imageNamed:imageName];
    }
    if (leftView) {
        textField.leftView=leftView;
        textField.leftViewMode=UITextFieldViewModeAlways;
    }
    if (rightView) {
        textField.rightView=rightView;
        textField.rightViewMode=UITextFieldViewModeAlways;
    }
    if (isPassWord) {
        textField.secureTextEntry=YES;
    }
    return textField;
    
    
}
#pragma mark  快捷生成直线 以imageView的形式显示
+(UIImageView *)initBorderLineWithFrame:(CGRect)frame
{
    UIImageView *line=[[UIImageView alloc]initWithFrame:frame];
    [line setBackgroundColor:kBorderColor];
    return line;
}
@end
