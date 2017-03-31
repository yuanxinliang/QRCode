//
//  QRViewController.h
//  QRCode
//
//  Created by 袁鑫亮 on 2017/1/18.
//  Copyright © 2017年 yxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRViewController : UIViewController
@property (nonatomic, copy) void (^updateBlock)(NSString *result);
@end
