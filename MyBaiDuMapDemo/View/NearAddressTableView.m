//
//  NearAddressTableView.m
//  WNShangCheng
//
//  Created by liu on 16/5/22.
//
//

#import "NearAddressTableView.h"
#import "NearAdressTableViewCell.h"
#import "MapPlace.h"

@interface NearAddressTableView()<UITableViewDataSource>

@end

@implementation NearAddressTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = kBackColor;
        self.rowHeight = Address_MapSelectNearAddressCellHeight + kLineWidth;
        [self registerClass:[NearAdressTableViewCell class]
     forCellReuseIdentifier:kNearAdressTableViewCell];
    }
    return self;
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.nearAddressArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearAdressTableViewCell *cell = [tableView
                                     dequeueReusableCellWithIdentifier:kNearAdressTableViewCell];
    MapPlace * placeModel=self.nearAddressArray[indexPath.row];
    if (indexPath.row == 0) {
        placeModel.isCurrentLocation = YES;
    }
    cell.place = placeModel;
    
    return cell;
    
}

@end
