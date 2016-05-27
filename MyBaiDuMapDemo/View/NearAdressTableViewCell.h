//
//  NearAdressTableViewCell.h
//  MapTest
//
//  Created by liu on 16/5/18.
//  Copyright © 2016年 WN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MapPlace;
extern NSString *const kNearAdressTableViewCell;
@interface NearAdressTableViewCell : UITableViewCell

@property(nonatomic,strong)MapPlace *place;

@end
