//
//  QRViewController.m
//  QRCode
//
//  Created by 袁鑫亮 on 2017/1/18.
//  Copyright © 2017年 yxl. All rights reserved.
//

#import "QRViewController.h"
#import "QRCodeBackgrondView.h"
#import "QRCodeAreaView.h"
#import <AVFoundation/AVFoundation.h>
@interface QRViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) QRCodeAreaView *areaView;
@property (nonatomic, strong) AVCaptureSession *session;
@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;

    QRCodeBackgrondView *backgroundView = [[QRCodeBackgrondView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:backgroundView];
    
    QRCodeAreaView *areaView = [[QRCodeAreaView alloc] initWithFrame:CGRectMake(0, 0, 205, 205)];
    areaView.center = self.view.center;
    [self.view addSubview:areaView];
    self.areaView = areaView;
    
    //提示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(areaView.frame) + 10, self.view.frame.size.width, 50)];
    label.text = @"将条形码放入框内，即开始扫描";
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    [self.view addSubview:label];
    
    //返回键
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(12, 26, 42, 42);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"prev"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    output.rectOfInterest = CGRectMake(areaView.frame.origin.y / height, areaView.frame.origin.x / width, areaView.frame.size.height / height, areaView.frame.size.width / width);
    
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    [self.session addInput:input];
    [self.session addOutput:output];
    
    output.metadataObjectTypes = @[AVMetadataObjectTypeCode39Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];
    
    [self.session startRunning];
}

- (void)clickBackBtn:(UIButton *)sender {
    [self.areaView stopAnimaion];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if ([metadataObjects count] > 0) {
        [self.session stopRunning];
        [self.areaView stopAnimaion];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
        self.updateBlock(metadataObject.stringValue);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dealloc {
    NSLog(@"123");
}


@end
