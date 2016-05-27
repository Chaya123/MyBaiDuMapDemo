//
//  AppDelegate.h
//  MyBaiDuMapDemo
//
//  Created by liu on 16/5/27.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BMKMapManager *mapManager;//百度地图管理对象

@end

