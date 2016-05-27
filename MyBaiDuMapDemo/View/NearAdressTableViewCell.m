//
//  NearAdressTableViewCell.m
//  MapTest
//
//  Created by liu on 16/5/18.
//  Copyright © 2016年 WN. All rights reserved.
//

#import "NearAdressTableViewCell.h"
#import "MapPlace.h"

@interface NearAdressTableViewCell()
//定位图片
@property(nonatomic,strong)UIImageView *locationImageView;
//地址名
@property(nonatomic,strong)UILabel *nameLabel;
//详细地址
@property(nonatomic,strong)UILabel *addressLabel;
@end

NSString *const kNearAdressTableViewCell = @"kNearAdressTableViewCell";

@implementation NearAdressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.locationImageView];
        
        [self.contentView addSubview:self.nameLabel];
    
        [self.contentView addSubview:self.addressLabel];
        
        UIImageView *lineView = [WNControl initBorderLineWithFrame:CGRectMake(self.addressLabel.originX, CGRectGetMaxY(self.addressLabel.frame) + kYellowWidth + 2, kWindowWidth - self.addressLabel.originX, kLineWidth)];
        [self.contentView addSubview:lineView];
    }
    
    return self;
}

- (void)setPlace:(MapPlace *)place{
    
    _place = place;
    if (place.isCurrentLocation) {
        
        self.locationImageView.image = [UIImage imageNamed:@"location_r"];
        self.nameLabel.textColor = kRedColor;
        self.nameLabel.text = [NSString stringWithFormat:@"[当前位置]%@",place.name];
    }else{
        
        self.locationImageView.image = [UIImage imageNamed:@"location_g"];
        self.nameLabel.textColor = kBlackColor;
        self.nameLabel.text = place.name;
    }
    self.addressLabel.text = place.address;
}
//懒加载
- (UIImageView *)locationImageView{

    if (!_locationImageView) {
        UIImage *locationG = [UIImage imageNamed:@"location_g"];
        _locationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, Address_MapSelectNearAddressCellHeight/2 - locationG.size.height/2, 44, locationG.size.height)];
        _locationImageView.image = locationG;
        _locationImageView.contentMode = UIViewContentModeCenter;
    }
    return _locationImageView;
}

- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.locationImageView.frame), kYellowWidth + 2,kWindowWidth - CGRectGetMaxX(self.locationImageView.frame) - kBlueWidth ,18)];
        _nameLabel.textColor = kBlackColor;
        _nameLabel.font = kFontSize_3;
    }
    return _nameLabel;
}

- (UILabel *)addressLabel{
    
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.originX, CGRectGetMaxY(self.nameLabel.frame) + kYellowWidth, self.nameLabel.width, 14)];
        _addressLabel.font = kFontSize_4;
        _addressLabel.textColor = kG2Color;
    }
    return _addressLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
