//
//  AddressMapSelectViewController.m
//  WNShangCheng
//
//  Created by liu on 16/5/22.
//
//

#import "AddressMapSelectViewController.h"
#import "MapPlace.h"
#import "NearAddressTableView.h"
#import "SearchAddressTableView.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入搜索功能所有的头文件

@interface AddressMapSelectViewController()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)NSMutableArray *addressArray;
//附近地址tableView
@property(nonatomic,strong)NearAddressTableView *nearTableView;
//搜索数组
@property(nonatomic,strong)NSMutableArray *searchAddressArray;
////搜索searchTableView
@property(nonatomic,strong)SearchAddressTableView *searchTableView;
//大头针
@property(nonatomic,strong)UIImageView *locationImage;
//开始定位图
@property(nonatomic,strong)UIImageView *startLocation;
//地图view
@property(nonatomic,strong)BMKMapView *mapView;
//搜索周边功能
@property(nonatomic,strong)BMKGeoCodeSearch *geoCodeSearch;
//将经纬度转换为中文地址
@property(nonatomic,strong)BMKReverseGeoCodeOption *reverseGeoCodeOption;

@property(nonatomic,strong)BMKPoiSearch *cityPoiSearch;

@property(nonatomic,strong)BMKCitySearchOption *citySearchOption;
//定位服务
@property(nonatomic,strong)BMKLocationService *locService;
//搜索条
@property(nonatomic,strong)UITextField  *searchTextField;

@property(nonatomic,assign)BOOL isFirstLocation;//是否是第一次加载

@end

@implementation AddressMapSelectViewController

#pragma mark - 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor=kBackColor;
    self.isFirstLocation = YES;
    [self createMapUI];
}
- (void)createMapUI{
    
    [self.locService startUserLocationService];
    [self.view addSubview:self.mapView];
    [self.mapView addSubview:self.locationImage];
    [self.view addSubview:self.nearTableView];
    [self.view addSubview:self.searchTableView];
    [self.view addSubview:self.startLocation];
    [self.view addSubview:self.searchTextField];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.geoCodeSearch.delegate = nil;
    self.cityPoiSearch.delegate = nil;
    self.locService.delegate = nil;
    [super viewWillDisappear:animated];
}
#pragma mark BMKLocationServiceDelegate  处理地图位置更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    [self.mapView updateLocationData:userLocation];
    
    self.mapView.centerCoordinate = userLocation.location.coordinate;
}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
}
#pragma mark BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate=[_mapView convertPoint:_mapView.center toCoordinateFromView:_mapView];
    
    //需要逆地理编码的坐标位置
    self.reverseGeoCodeOption.reverseGeoPoint =  CLLocationCoordinate2DMake(MapCoordinate.latitude,MapCoordinate.longitude);
    
    [self.geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];
    
}
#pragma mark BMKGeoCodeSearchDelegate  定位周围结果

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //获取周边用户信息
    if (error==BMK_SEARCH_NO_ERROR) {
        
        [self.addressArray removeAllObjects];
        for(BMKPoiInfo *poiInfo in result.poiList)
        {
            MapPlace *place=[[MapPlace alloc]init];
            place.name=poiInfo.name;
            place.address=poiInfo.address;
            place.city = poiInfo.city;
            [self.locService stopUserLocationService];
            [self.addressArray addObject:place];
        }
        self.nearTableView.nearAddressArray = self.addressArray;
        [self.nearTableView reloadData];
    }
}

#pragma mark PoiSearchDeleage  搜索城市结果
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    if (errorCode==BMK_SEARCH_NO_ERROR) {
        [self.searchAddressArray removeAllObjects];
        for(BMKPoiInfo *poiInfo in poiResult.poiInfoList)
        {
            if (self.isFirstLocation) {
                self.citySearchOption.city = poiInfo.city?poiInfo.city:@"北京市";
            }
            self.isFirstLocation = NO;
            MapPlace *place=[[MapPlace alloc]init];
            place.name=poiInfo.name;
            place.address=poiInfo.address;
            place.pt = poiInfo.pt;
            place.city = poiInfo.city;
            [self.searchAddressArray addObject:place];
        }
        self.searchTableView.searchAddressArray = self.searchAddressArray;
        [self.searchTableView reloadData];
    }else{
        
    }
}
#pragma mark - UITextFieldDelegate
//开始编辑时
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
   [self.searchTextField becomeFirstResponder];
}
//TextField内容改变
- (void)textFieldValueChanged:(UITextField *)sender{
    
    if (sender.text.length > 0) {
        self.searchTableView.hidden = NO;
        self.startLocation.hidden = YES;
        self.mapView.hidden = YES;
        self.nearTableView.hidden = YES;
        self.citySearchOption.keyword = sender.text;
        [self.cityPoiSearch poiSearchInCity:self.citySearchOption];
    }else{
        
        self.searchTableView.hidden = YES;
        self.mapView.hidden = NO;
        self.startLocation.hidden = NO;
        self.nearTableView.hidden = NO;
    }
}
#pragma mark - tableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MapPlace *placeModel = (tableView == self.nearTableView)?self.addressArray[indexPath.row]:self.searchAddressArray[indexPath.row];

        if ([self.delegate respondsToSelector:@selector(AddressMapSelectViewControllerDelegateSeclectAddress:)]) {
            [self.delegate AddressMapSelectViewControllerDelegateSeclectAddress:placeModel.name];
            [self.navigationController popViewControllerAnimated:YES];
        }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [self.view endEditing:YES];

}
- (void)startLocationTap{
    
    [self.locService startUserLocationService];
}
#pragma mark 返回按钮的点击方法
-(void)backButtonClicked
{
    if ([self.delegate respondsToSelector:@selector(AddressMapSelectViewControllerDelegateSeclectAddress:)]) {
        [self.delegate AddressMapSelectViewControllerDelegateSeclectAddress:@""];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 懒加载
- (BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, kWindowWidth, Address_MapSelectAddressMapHeight)];
        [_mapView setMapType:BMKMapTypeStandard];// 地图类型 ->卫星／标准、
        _mapView.zoomLevel=17;
        _mapView.showsUserLocation = YES;
        _mapView.userInteractionEnabled = YES;
    }
    return _mapView;
}

- (UIImageView *)locationImage{
    if (!_locationImage) {
        
        UIImage *locationImage = [UIImage imageNamed:@"location"];
        _locationImage=[[UIImageView alloc]initWithFrame:CGRectMake(kWindowWidth/2-locationImage.size.width/2,self.mapView.height/2 - locationImage.size.height/2, locationImage.size.width, locationImage.size.height)];
        _locationImage.image = locationImage;
    }
    return _locationImage;
}

- (UIImageView *)startLocation{
    if (!_startLocation) {
        
        UIImage *startLocationImage = [UIImage imageNamed:@"shoot"];
        _startLocation = [[UIImageView alloc]initWithFrame:CGRectMake(kBlueWidth, CGRectGetMaxY(self.mapView.frame) - kBlueWidth - startLocationImage.size.height, startLocationImage.size.width, startLocationImage.size.height)];
        _startLocation.image = startLocationImage;
        _startLocation.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startLocationTap)];
        [_startLocation addGestureRecognizer:tap];
    }
    return _startLocation;
}
- (BMKLocationService *)locService{
    if (!_locService) {
        _locService = [[BMKLocationService alloc]init];
        [_locService setDesiredAccuracy:kCLLocationAccuracyBest];
        _locService.delegate = self;
    }
    return _locService;
}

- (NSMutableArray *)addressArray{
    
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

- (NSMutableArray *)searchAddressArray{
    if (!_searchAddressArray) {
        _searchAddressArray = [NSMutableArray array];
    }
    return _searchAddressArray;
}

- (BMKGeoCodeSearch *)geoCodeSearch{
    
    if (!_geoCodeSearch) {
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
    }
    return _geoCodeSearch;
}
- (BMKReverseGeoCodeOption *)reverseGeoCodeOption{
    if (!_reverseGeoCodeOption) {
        _reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    }
    return _reverseGeoCodeOption;
}

- (BMKPoiSearch *)cityPoiSearch{

    if (!_cityPoiSearch) {
        _cityPoiSearch = [[BMKPoiSearch alloc]init];
        _cityPoiSearch.delegate = self;
    }
    return _cityPoiSearch;
}

- (BMKCitySearchOption *)citySearchOption{

    if (!_citySearchOption) {
        _citySearchOption = [[BMKCitySearchOption alloc]init];
        _citySearchOption.city = @"北京";
    }
    return _citySearchOption;
}
- (NearAddressTableView *)nearTableView{
    if (!_nearTableView) {
        _nearTableView=[[NearAddressTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mapView.frame), kWindowWidth, kWindowHeight - CGRectGetMaxY(self.mapView.frame))];
        _nearTableView.delegate = self;
    }
    return _nearTableView;
}

- (SearchAddressTableView *)searchTableView{

    if (!_searchTableView) {
        _searchTableView = [[SearchAddressTableView alloc]initWithFrame:CGRectMake(0,60, kWindowWidth, kWindowHeight - kStatusHeight - kYellowWidth)];
        _searchTableView.delegate = self;
        _searchTableView.hidden = YES;
    }
    return _searchTableView;
}
- (UITextField *)searchTextField{
    
    if (!_searchTextField) {
        _searchTextField = [WNControl createTextFieldFrame:CGRectMake(kBlueWidth,kStatusHeight, kWindowWidth - 2*kBlueWidth , Search_SearchHeight) andPlaceholder:@"请输入您的收货地址" andBgImageName:nil andLeftView:nil andRightView:nil andIsPassWord:NO];
        _searchTextField.delegate = self;
        _searchTextField.layer.cornerRadius = 3;
        _searchTextField.clipsToBounds = YES;
        _searchTextField.backgroundColor = kRedColor;
        [_searchTextField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchTextField;
}
@end
