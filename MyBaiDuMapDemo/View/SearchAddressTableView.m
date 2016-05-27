//
//  SearchAddressTableView.m
//  WNShangCheng
//
//  Created by liu on 16/5/25.
//
//

#import "SearchAddressTableView.h"
#import "NearAdressTableViewCell.h"

@interface SearchAddressTableView()<UITableViewDataSource>

@end

@implementation SearchAddressTableView

- (instancetype)initWithFrame:(CGRect)frame{
    
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
    
    return self.searchAddressArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearAdressTableViewCell *cell = [tableView
                                     dequeueReusableCellWithIdentifier:kNearAdressTableViewCell];
    MapPlace * placeModel=self.searchAddressArray[indexPath.row];
    cell.place = placeModel;
    
    return cell;
    
}
@end
