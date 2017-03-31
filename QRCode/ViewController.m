//
//  ViewController.m
//  QRCode
//
//  Created by 袁鑫亮 on 2017/1/18.
//  Copyright © 2017年 yxl. All rights reserved.
//

#import "ViewController.h"
#import "QRViewController.h"
@interface ViewController ()
@property (nonatomic, strong) UILabel *showLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button.center = self.view.center;
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
    self.showLabel.numberOfLines = 0;
    self.showLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.showLabel];
    
}

- (void)scan {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        QRViewController *vc = [QRViewController new];
        vc.updateBlock = ^(NSString *result) {
            self.showLabel.text = [NSString stringWithFormat:@"扫描结果：%@",result];
            [self.showLabel sizeToFit];
            self.showLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 80);
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"摄像头不可用" message:@"请用真机调试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
