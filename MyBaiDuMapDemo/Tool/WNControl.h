//
//  WNControl.h
//  MineDemo
//
//  Created by liu on 16/5/22.
//  Copyright (c) 2016年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WNControl : NSObject
+(UITextField*)createTextFieldFrame:(CGRect)frame andPlaceholder:(NSString*)placeholder andBgImageName:(NSString*)imageName andLeftView:(UIView*)leftView andRightView:(UIView*)rightView andIsPassWord:(BOOL)isPassWord;
//快捷生成直线 以imageView的形式显示
+(UIImageView *)initBorderLineWithFrame:(CGRect)frame;
@end
