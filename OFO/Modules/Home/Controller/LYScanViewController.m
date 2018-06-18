//
//  LYScanViewController.m
//  OFO
//
//  Created by LiuYong on 2017/10/28.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYScanViewController.h"
#import <AVFoundation/AVFoundation.h>

#define QR_Width 0.7 * Screenwidth
#define QR_Hight 0.7 * Screenwidth


@interface LYScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
//关闭按钮
@property(nonatomic,strong)UIButton*closeBtn;
//导航栏
@property(nonatomic,strong)UIView*navView;
//扫描框
@property (nonatomic, strong) UIView * view_bg;
//扫描线
@property (nonatomic, strong) CALayer * layer_scanLine;
//提示语
@property (nonatomic, strong) UILabel * lab_word;
//定时器
@property (nonatomic, strong) NSTimer * timer;
//采集的设备
@property (strong,nonatomic) AVCaptureDevice * device;
//设备的输入
@property (strong,nonatomic) AVCaptureDeviceInput * input;
//输出
@property (strong,nonatomic) AVCaptureMetadataOutput * output;
//采集流
@property (strong,nonatomic) AVCaptureSession * session;
//窗口
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * previewLayer;

@property (assign,nonatomic) BOOL  torchIsOn;

@end

@implementation LYScanViewController

-(UIButton *)closeBtn{
    if(!_closeBtn){
        _closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame=CGRectMake(Screenwidth-40, 30, 25 , 25);
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setImage:[UIImage imageNamed:@"Nav_close"] forState:UIControlStateNormal];
        [_closeBtn setImage:[UIImage imageNamed:@"Nav_close"] forState:UIControlStateSelected];
        [_closeBtn setImage:[UIImage imageNamed:@"Nav_close"] forState:UIControlStateHighlighted];
    }
    return _closeBtn;
}

-(UIView *)navView{
    if(!_navView){
        _navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 64)];
        _navView.backgroundColor=[UIColor blackColor];
        _navView.alpha=0.6;
    }
    return _navView;
}

#pragma mark Life-Cycle
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]){
        [device lockForConfiguration:nil];
        if (self.torchIsOn) {
            [device setTorchMode:AVCaptureTorchModeOff];
            [device setFlashMode:AVCaptureFlashModeOff];
        }
        [device unlockForConfiguration];
}
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.closeBtn];
    UIColor *color = [UIColor blackColor];
    self.view.backgroundColor = [color colorWithAlphaComponent:0.5];
    [self startScan];
    self.torchIsOn=NO;
    
}
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addSubviews {
    
    [self.view addSubview:self.view_bg];
    [self.view addSubview:self.lab_word];
    [_view_bg.layer addSublayer:self.layer_scanLine];
  
}

#pragma mark - make constraints

- (void)makeConstraintsForUI {
    
    [_view_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.7 * Screenwidth,  0.7 * Screenwidth));
        make.left.mas_equalTo(@(0.15 * Screenwidth));
        make.top.mas_equalTo(@( (self.view.frame.size.height-QR_Hight)/2));
    }];
    
    [_lab_word mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Screenwidth, 20));
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(self.view.mas_top).with.offset((self.view.frame.size.height-QR_Hight)/2-40);
    }];
    
    UIView *leftBG = [[UIView alloc] initWithFrame:CGRectMake(0, 64, (self.view.frame.size.width - QR_Width)/2, self.view.frame.size.height)];
    [self setAlphaView:leftBG];
    [self.view addSubview:leftBG];
    
    UIView *rightBG = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - QR_Width)/2 + QR_Width, 64, (self.view.frame.size.width - QR_Width)/2, self.view.frame.size.height)];
    [self setAlphaView:rightBG];
    [self.view  addSubview:rightBG];
    
    UIView *topBG = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - QR_Width)/2, 64, QR_Width, (self.view.frame.size.height-QR_Hight)/2-64)];
    [self setAlphaView:topBG];
    [self.view  addSubview:topBG];
    
    UIView *bottomBG = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - QR_Width)/2, (self.view.frame.size.height-QR_Hight)/2+QR_Hight, QR_Width, (self.view.frame.size.height-QR_Hight)/2)];
    [self setAlphaView:bottomBG];
    [self.view  addSubview:bottomBG];
    UIImageView*topLeftV=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - QR_Width)/2, (self.view.frame.size.height-QR_Hight)/2, 40, 40)];
    topLeftV.image=[UIImage imageNamed:@"Top_left"];
    [self.view addSubview:topLeftV];
    
    UIImageView*topRightV=[[UIImageView alloc]initWithFrame:CGRectMake(Screenwidth-(self.view.frame.size.width - QR_Width)/2-40, (self.view.frame.size.height-QR_Hight)/2, 40, 40)];
    topRightV.image=[UIImage imageNamed:@"Top_right"];
    [self.view addSubview:topRightV];
    
    
    UIImageView*bottomLeftV=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - QR_Width)/2, (self.view.frame.size.height-QR_Hight)/2+QR_Hight-40, 40, 40)];
    bottomLeftV.image=[UIImage imageNamed:@"Bottom_left"];
    [self.view addSubview:bottomLeftV];
    
    UIImageView*BottomRight=[[UIImageView alloc]initWithFrame:CGRectMake(Screenwidth-(self.view.frame.size.width - QR_Width)/2-40, (self.view.frame.size.height-QR_Hight)/2+QR_Hight-40, 40, 40)];
    BottomRight.image=[UIImage imageNamed:@"Bottom_right"];
    [self.view addSubview:BottomRight];
    
    
    UIButton*fingerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    fingerBtn.frame=CGRectMake(0.2*Screenwidth, ScreenHeight-85, 50 , 50);
    [fingerBtn setImage:[UIImage imageNamed:@"scan_touch_finger"] forState:UIControlStateNormal];
    [fingerBtn setImage:[UIImage imageNamed:@"scan_touch_finger"] forState:UIControlStateHighlighted];
    [fingerBtn addTarget:self action:@selector(autoInput) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:fingerBtn];
    
    UIButton*scanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame=CGRectMake(Screenwidth-0.2*Screenwidth-50, ScreenHeight-85, 50 , 50);
    [scanBtn setImage:[UIImage imageNamed:@"scan_touch_off"] forState:UIControlStateNormal];
    [scanBtn setImage:[UIImage imageNamed:@"scan_touch_on"] forState:UIControlStateSelected];
    [scanBtn setImage:[UIImage imageNamed:@"scan_touch_off"] forState:UIControlStateHighlighted];
    [scanBtn addTarget:self action:@selector(torch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    
    NSArray*arr=@[@"手动输入车牌",@"打开手电筒"];
    for(int i=0;i<arr.count;i++){
        UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(i==1?0.15*Screenwidth:Screenwidth-0.15*Screenwidth-80, ScreenHeight-30, 80, 20)];
        lab.textAlignment=1;
        lab.font=DefalutFont(13);
        lab.textColor=[UIColor whiteColor];
        lab.text=arr[i];
        [self.view addSubview:lab];
    }
}
-(void)torch:(UIButton*)sender{
    sender.selected=!sender.selected;
    [self turnTorchOn:sender.selected];
}
-(void)turnTorchOn: (bool) on{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass !=nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                self.torchIsOn=YES;

            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                self.torchIsOn=NO;

            }
            [device unlockForConfiguration];
        }else{
            NSLog(@"初始化失败");
        }
    }else{
        NSLog(@"没有闪光设备");
    }
}
-(void)autoInput{
   [self dismissViewControllerAnimated:NO completion:nil];
    self.returnBlock();
}


- (void)startScan {
    
    // Device 实例化设备   //获取摄像设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input 设备输入     //创建输入流
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    // Output 设备的输出  //创建输出流
    _output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理   在主线程里刷新
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // Session         //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    // 二维码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
    
    // Preview 扫描窗口设置
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = CGRectMake(0, 0, Screenwidth, ScreenHeight+34);
    _output.rectOfInterest = CGRectMake(0.15, 0.25, 0.7, 0.5);
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    //添加框和线
    [self addSubviews];
    [self makeConstraintsForUI];
    // Start 开始扫描   //开始捕获
    [_session startRunning];
    
    self.timer.fireDate = [NSDate distantPast];
    
}

#pragma mark - timer action

- (void)scanLineMove {
    CABasicAnimation * animation = [[CABasicAnimation alloc] init];
    //告诉系统要执行什么样的动画
    animation.keyPath = @"position";
    //设置通过动画  layer从哪到哪
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0.7 * Screenwidth)];
    //动画时间
    animation.duration = 3.0;
    //设置动画执行完毕之后不删除动画
    animation.removedOnCompletion = NO;
    //设置保存动画的最新动态
    animation.fillMode = kCAFillModeForwards;
    //添加动画到layer
    [self.layer_scanLine addAnimation:animation forKey:nil];
    
}
#pragma mark - 实现output的回调方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0&&metadataObjects!=nil) {
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
        NSString * base64Str = obj.stringValue;
        NSString * str = [base64Str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSArray*array=[str componentsSeparatedByString:@"/"];
        LYLog(@"***************%@",array);
        if([str containsString:@"http://ofo.so/"]){
            NSString *num1=[NSString stringWithFormat:@"%d",[self getRandomNumber:1 to:4]];
            NSString *num2=[NSString stringWithFormat:@"%d",[self getRandomNumber:1 to:4]];
            NSString *num3=[NSString stringWithFormat:@"%d",[self getRandomNumber:1 to:4]];
            NSString *num4=[NSString stringWithFormat:@"%d",[self getRandomNumber:1 to:4]];
            NSMutableArray*codes=[NSMutableArray new];
            [codes addObject:num1];
            [codes addObject:num2];
            [codes addObject:num3];
            [codes addObject:num4];
            if(self.codeBlock){
                [self dismissViewControllerAnimated:YES completion:^{
                    NSArray * nums =[NSArray arrayWithArray:codes];
                    self.codeBlock(nums,array.lastObject);
                }];
            }
        }else{
            
        }
    }
}


#pragma mark - setter and getter
- (UIView *)view_bg {
    if (!_view_bg) {
        _view_bg = [[UIView alloc] init];
        _view_bg.layer.borderColor = ColorWithRGB(243, 209, 54).CGColor;
        _view_bg.layer.borderWidth = 2.0;
    }
    return _view_bg;
}

- (CALayer *)layer_scanLine {
    
    if (!_layer_scanLine) {
        CALayer * layer = [[CALayer alloc] init];
        layer.bounds = CGRectMake(0, 0, 0.7 * Screenwidth, 1);
        layer.backgroundColor =ColorWithRGB(243, 209, 54).CGColor;
        //起点
        layer.position = CGPointMake(0, 0);
        //定位点
        layer.anchorPoint = CGPointMake(0, 0);
        _layer_scanLine = layer;
    }
    return _layer_scanLine;
}

- (UILabel *)lab_word {
    
    if (!_lab_word) {
        _lab_word = [[UILabel alloc] init];
        _lab_word.textAlignment = NSTextAlignmentCenter;
        _lab_word.textColor = [UIColor whiteColor];
        _lab_word.font = [UIFont systemFontOfSize:17];
        _lab_word.text = @"对准车牌上的二维码,即可自动扫描";

    }
    
    return _lab_word;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(scanLineMove) userInfo:nil repeats:YES];
        [_timer fire];
    }
    return _timer;
}

-(void)setAlphaView:(UIView*)view{
    UIColor *color = [UIColor blackColor];
    view.backgroundColor = [color colorWithAlphaComponent:0.6];
}

-(int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
