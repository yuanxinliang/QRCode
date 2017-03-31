//
//  QRCodeBackgrondView.m
//  QRCode
//
//  Created by 袁鑫亮 on 2017/1/18.
//  Copyright © 2017年 yxl. All rights reserved.
//

#import "QRCodeBackgrondView.h"



@implementation QRCodeBackgrondView

- (void)drawRect:(CGRect)rect {
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    //设置白色框的Frame
    CGRect frame = CGRectMake((width - 250)/2, (height - 250)/2, 250, 250);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //填充区域颜色
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] set];
    CGRect topScanRect = CGRectMake(0, 0, self.frame.size.width, frame.origin.y);
    CGContextFillRect(context, topScanRect);

    CGRect leftScanRect = CGRectMake(0, frame.origin.y, frame.origin.x, frame.size.height);
    CGContextFillRect(context, leftScanRect);
    
    CGRect rightScanRect = CGRectMake(CGRectGetMaxX(frame), frame.origin.y, frame.origin.x, frame.size.height);
    CGContextFillRect(context, rightScanRect);
    
    CGRect bottomScanRect = CGRectMake(0, CGRectGetMaxY(frame), self.frame.size.width, self.frame.size.height);
    CGContextFillRect(context, bottomScanRect);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
