//
//  QRCodeAreView.m
//  QRCode
//
//  Created by 袁鑫亮 on 2017/1/18.
//  Copyright © 2017年 yxl. All rights reserved.
//

#import "QRCodeAreaView.h"

@interface QRCodeAreaView()
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, strong) NSTimer *myTimer;
@end

@implementation QRCodeAreaView

- (NSTimer *)myTimer {
    if (!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
    }
    return _myTimer;
}

- (void)drawRect:(CGRect)rect {
    CGPoint newPosition = self.position;
    newPosition.y += 1;
    if (newPosition.y > rect.size.height) {
        newPosition.y = 0;
    }
    self.position = newPosition;
    UIImage *image = [UIImage imageNamed:@"line"];
    [image drawAtPoint:self.position];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        iv.image = [UIImage imageNamed:@"frame_icon"];
        [self addSubview:iv];
        [self startAnimaion];
    }
    return self;
}

- (void)startAnimaion {
    [self.myTimer setFireDate:[NSDate date]];
}

- (void)stopAnimaion {
    [self.myTimer setFireDate:[NSDate distantFuture]];
    [self.myTimer invalidate];
    self.myTimer = nil;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
