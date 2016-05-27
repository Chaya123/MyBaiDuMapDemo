//
//  MapPlace.h
//  MyBaiDuMapDemo
//
//  Created by liu on 16/5/27.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MapPlace : NSObject
///POI名称
@property (nonatomic, strong) NSString* name;
///POIuid
@property (nonatomic, strong) NSString* uid;
///POI地址
@property (nonatomic, strong) NSString* address;
///POI所在城市
@property (nonatomic, strong) NSString* city;
///POI电话号码
@property (nonatomic, strong) NSString* phone;
///POI邮编
@property (nonatomic, strong) NSString* postcode;
///POI类型，0:普通点 1:公交站 2:公交线路 3:地铁站 4:地铁线路
@property (nonatomic) int epoitype;
///POI坐标
@property (nonatomic) CLLocationCoordinate2D pt;
//不参与接收数据
@property(nonatomic,assign)BOOL isCurrentLocation;

@end
