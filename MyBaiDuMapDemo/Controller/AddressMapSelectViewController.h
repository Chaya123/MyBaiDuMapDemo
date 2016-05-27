//
//  AddressMapSelectViewController.h
//  WNShangCheng
//
//  Created by liu on 16/5/22.
//
//

#import <UIKit/UIKit.h>
//代理方法，将选择的地址传过去
@protocol AddressMapSelectViewControllerDelegate <NSObject>

-(void)AddressMapSelectViewControllerDelegateSeclectAddress:(NSString *)addressStr;

@end

@interface AddressMapSelectViewController : UIViewController

@property(nonatomic,weak)id<AddressMapSelectViewControllerDelegate> delegate;

@end
