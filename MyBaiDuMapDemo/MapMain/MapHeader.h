//
//  MapHeader.h
//  MyBaiDuMapDemo
//
//  Created by liu on 16/5/27.
//  Copyright © 2016年 liu. All rights reserved.
//

#ifndef MapHeader_h
#define MapHeader_h

#import "WNView+Ext.h"
#import "WNControl.h"
#define UIColorRGBA(r, g, b, a)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kBackColor                (UIColorRGBA(238, 238, 238, 1.0))//底色
#define kRedColor                           (UIColorRGBA(247, 54, 49, 1.0))//红色
#define kBlackColor                         (UIColorRGBA(0, 0, 0, 1.0))
#define kG2Color                            (UIColorRGBA(144, 144, 144, 1.0))//2号灰
#define kBorderColor                        (UIColorRGBA(227, 227, 227, 1.0))//描边的颜色
#define kYellowWidth              8//切图中黄色条宽
#define kBlueWidth                16//切图中蓝色条宽
#define kFontSize_3               ([UIFont systemFontOfSize:14])
#define kFontSize_4               ([UIFont systemFontOfSize:12])//4号字体大
#define kScale                    ([UIScreen mainScreen].scale==3) ? (1.3) :(1)
#define kWindowWidth              ([[UIScreen mainScreen] bounds].size.width)//屛宽
#define kWindowHeight             ([[UIScreen mainScreen] bounds].size.height)//屛高
#define kStatusHeight             ([[UIApplication sharedApplication] statusBarFrame].size.height)//状态栏高
#define kLineWidth                0.5*(kScale) //描边的宽度
#define Address_MapSelectAddressMapHeight  460/2
#define Address_MapSelectNearAddressCellHeight  120/2
#define Search_SearchHeight  70/2



#endif /* MapHeader_h */
