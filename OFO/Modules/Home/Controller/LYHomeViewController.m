//
//  LYHomeViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/27.
//  Copyright © 2017年 OFO. All rights reserved.
//
#import "LYScanView.h"
#import "LYCodeView.h"
#import "LYLeftSideView.h"
#import <AVFoundation/AVFoundation.h>

#import "LYHomeViewController.h"
#import "LYMessageViewController.h"
#import "LYScanViewController.h"
#import "LYMyInfoViewController.h"
#import "LYCouponViewController.h"
#import "LYInviteViewController.h"
#import "LYWalletViewController.h"
#import "LYTourViewController.h"
#import "LYServiceViewController.h"
#import "LYInputView.h"

@interface LYHomeViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,ScanViewDelegate,AVAudioPlayerDelegate,LYCodeViewDelegate,LYLeftSideViewDelegate>

@property(nonatomic,strong)MAMapView*mapView;
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property(nonatomic,strong)UIButton*locationBtn;
@property(nonatomic,strong)UIButton*serviceBtn;
@property(nonatomic,strong)AVAudioPlayer*audioplayer;
@property (strong, nonatomic) NSMutableArray *arrayOfTracks; // 这个数组中保存音频的名称
@property (assign, nonatomic)NSInteger currentTrackNumber;
@property(nonatomic,strong)NSMutableArray*codesArray;
@property(nonatomic,strong)LYCodeView*codeView;
@property(nonatomic,strong)LYScanView*scanView;
@property(nonatomic,strong)LYLeftSideView*sideView;
@property(nonatomic,strong)LYInputView*inputNumberView;

@property(nonatomic,assign)NSTimer *timer;

@end

@implementation LYHomeViewController

#pragma mark Lazy Load

-(LYInputView *)inputNumberView{
    if (!_inputNumberView) {
        _inputNumberView=[[LYInputView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, ScreenHeight)];
        
    }
    return _inputNumberView;
}


-(NSMutableArray *)arrayOfTracks{
    if(!_arrayOfTracks){
        _arrayOfTracks=[NSMutableArray new];
    }
    return _arrayOfTracks;
}

-(NSMutableArray *)codesArray{
    if (!_codesArray) {
        _codesArray=[NSMutableArray new];
    }
    return _codesArray;
}

-(LYScanView *)scanView{
    if(!_scanView){
        _scanView=[[LYScanView alloc]initWithFrame:CGRectMake(0, ScreenHeight/3*2-65, Screenwidth, ScreenHeight/3+65)];
        _scanView.delegate=self;
    }
    return _scanView;
}

-(LYLeftSideView *)sideView{
    if (!_sideView) {
        _sideView=[[LYLeftSideView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, ScreenHeight)];
        _sideView.delegate=self;
    }
    return _sideView;
}

-(UIButton *)locationBtn{
    if(!_locationBtn){
        _locationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.frame=CGRectMake(Screenwidth-65, self.scanView.frame.origin.y-60,40, 40);
        [_locationBtn addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
        [_locationBtn setImage:[UIImage imageNamed:@"Home_refresh"] forState:UIControlStateNormal];
        [_locationBtn setImage:[UIImage imageNamed:@"Home_refresh"] forState:UIControlStateHighlighted];
        _locationBtn.backgroundColor=[UIColor whiteColor];
        _locationBtn.layer.masksToBounds=YES;
        _locationBtn.layer.cornerRadius=20;
    }
    return _locationBtn;
}

-(UIButton *)serviceBtn{
    if(!_serviceBtn){
        _serviceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _serviceBtn.frame=CGRectMake(Screenwidth-65, self.scanView.frame.origin.y-120,40, 40);
        [_serviceBtn addTarget:self action:@selector(service:) forControlEvents:UIControlEventTouchUpInside];
        [_serviceBtn setImage:[UIImage imageNamed:@"Home_service"] forState:UIControlStateNormal];
        [_serviceBtn setImage:[UIImage imageNamed:@"Home_service"] forState:UIControlStateHighlighted];
        _serviceBtn.backgroundColor=[UIColor whiteColor];
        _serviceBtn.layer.masksToBounds=YES;
        _serviceBtn.layer.cornerRadius=20;
    }
    return _serviceBtn;
}

/**在我的APP中从一个隐藏导航栏的A页面push到另一个有导航栏的B页面，然后从B页面pop回A页面导航栏就会出现一个黑块。
 注意 前一个控制器隐藏Nav时 push到第二个页面时  再返回当前页面时 会出现一个黑底的导航控制器闪过
 解决方法:1.设置导航控制器为透明
         代码：//[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
             //    self.navigationController.navigationBar.translucent = YES;

               2.给当前页页面隐藏导航控制器时添加动画 显示的时候也添加动画
                 [self.navigationController setNavigationBarHidden:YES animated:YES];//隐藏
                 [self.navigationController setNavigationBarHidden:NO animated:YES];//显示

 总结方法一:y会由原来的（0，0） 变成（0，64）
 
 @return <#return value description#>
 */
#pragma mark Life-Cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    LYLog(@"viewWillAppear");
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    LYLog(@"viewWillDisappear");

}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLocationManager];
    [self setUpMapView];
    [self.view addSubview:self.scanView];
    [self.view addSubview:self.locationBtn];
    [self.view addSubview:self.serviceBtn];
//    [self.view addSubview:self.inputNumberView];

    LYLog(@"viewDidLoad");

    
}

#pragma mark 地图定位
- (void)configLocationManager{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setPausesLocationUpdatesAutomatically:YES];
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    [self.locationManager startUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    LYLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    //定位结果
    LYLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    self.latitude=[NSString stringWithFormat:@"%f",location.coordinate.latitude];
    self.longitude=[NSString stringWithFormat:@"%f",location.coordinate.longitude];
}

#pragma mark 加载地图
-(void)setUpMapView{
    _mapView=[[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate=self;//代理
    _mapView.showsCompass=NO;//显示指南针
    _mapView.showsScale=NO;//显示比例尺
    _mapView.showsUserLocation = YES;//显示用户当前位置
    _mapView.mapType = MAMapTypeStandard;//地图类型
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    if ([self.latitude isEqualToString:@"0"]| [self.longitude isEqualToString:@"0"]){
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }else{
        self.destinationCoordinate = CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
        MACoordinateSpan span = MACoordinateSpanMake(0.007964, 0.007985);
        MACoordinateRegion region = MACoordinateRegionMake(self.destinationCoordinate, span);
        [_mapView setRegion:region animated:YES];
        [_mapView setCenterCoordinate:self.destinationCoordinate animated:YES];
        MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
        destinationAnnotation.coordinate = self.destinationCoordinate;
        [_mapView addAnnotation:destinationAnnotation];
        
    }
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:NO];
    [self.view addSubview:self.mapView];

    /*精度圈 3Dmap 5.0.0之后才支持*/
    MAUserLocationRepresentation *row = [[MAUserLocationRepresentation alloc] init];
    row.showsAccuracyRing=NO;
    row.showsHeadingIndicator=YES;
    row.enablePulseAnnimation = YES;///内部蓝色圆点是否使用律动效果, 默认YES
    [self.mapView updateUserLocationRepresentation:row];
}
#pragma mark ScanViewDelegate Method
-(void)didSelectAccountAction{
    LYLog(@"我的信息");
    [self.view addSubview:self.sideView];
    [self.sideView showToWindow];
}
-(void)didSelectMessageAction{
    LYMessageViewController*mvc=[[LYMessageViewController alloc]init];
    [self.navigationController pushViewController:mvc animated:YES];
}

-(void)didClickScanAction{
    
    LYScanViewController*svc=[[LYScanViewController alloc]init];
    [self.arrayOfTracks removeAllObjects];
    self.currentTrackNumber=0;
    svc.returnBlock = ^{
        LYLog(@"点击手动输入");
    
    };
    svc.codeBlock = ^(NSArray *codes,NSString*bikeCode) {
        NSMutableArray*arr=[NSMutableArray array];
        self.codesArray=[NSMutableArray arrayWithArray:codes];
        _codeView=[[LYCodeView alloc]initWithFrame:CGRectMake(0, ScreenHeight/3*2-65, Screenwidth, ScreenHeight/3+65) AndCodesArray:self.codesArray];
        _codeView.delegate=self;
        _codeView.bikeCode=bikeCode;
        [self.view addSubview:self.codeView];
        self.timer= [NSTimer scheduledTimerWithTimeInterval:120.0 target:self selector:@selector(hideCodeView) userInfo:nil repeats:NO];
        [arr addObject:@"上车前_LH"];
        [arr addObject:@"您的解锁码为_D"];
        for (NSString*res in codes) {
          NSString*result=  [res stringByAppendingString:@"_D"];
            [arr addObject:result];
        }
        self.arrayOfTracks=[NSMutableArray arrayWithArray:arr];
        if (_audioplayer) {
            [_audioplayer stop];
            _audioplayer = nil;
        } else {
            _audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[[NSString alloc] initWithString:[_arrayOfTracks objectAtIndex:_currentTrackNumber]] ofType:@"m4a"]] error:NULL];
            _audioplayer.delegate = self;
            [_audioplayer play];
        }
    };
    [self presentViewController:svc animated:YES completion:nil];
}
-(void)hideCodeView{
    [self.codeView hide];
}
#pragma mark LYLeftSideViewDelegate
-(void)LYLeftSideView:(LYLeftSideView*)sideView didFinishSelectAtIndex:(NSInteger)index{
    
    if (index==0) {
        LYTourViewController*tVc=[[LYTourViewController alloc]init];
        [self.navigationController pushViewController:tVc animated:YES];
    }else if (index==1){
        LYWalletViewController*wvc=[[LYWalletViewController alloc]init];
        [self.navigationController pushViewController:wvc animated:YES];

    }else if (index==2){
        LYInviteViewController*ivc=[[LYInviteViewController alloc]init];
        [self.navigationController pushViewController:ivc animated:YES];
    }else if (index==3){
        LYCouponViewController*cvc=[[LYCouponViewController alloc]init];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (index==4){
        LYServiceViewController*svc=[[LYServiceViewController alloc]init];
        [self.navigationController pushViewController:svc animated:YES];
    }
}

-(void)LYLeftSideView:(LYLeftSideView *)sideView didClickOnClose:(UIButton *)closeBtn{
    [self.sideView hideFromWindow];
}

-(void)LYLeftSideView:(LYLeftSideView *)sideView didClickOnHead:(UIButton *)headBtn{
    LYMyInfoViewController*infoVc=[[LYMyInfoViewController alloc]init];
    [self.navigationController pushViewController:infoVc animated:YES];
}

#pragma mark LYCodeViewDelegate
-(void)CodeView:(LYCodeView *)codeView didSelectAtIndex:(NSInteger)index{
    LYLog(@"%ld",(long)index);
    if (index==0) {
        LYLog(@"手电筒");

    }else if (index==1){
        LYLog(@"语音");

    }else if (index==2){
        LYLog(@"结束行程");
        [self hideCodeView];
        if (_audioplayer) {
            [_audioplayer stop];
            _audioplayer=nil;
        }

    }else{
        LYLog(@"保修");
    }
    
    
}
#pragma mark LYScanViewDelegate

-(void)scanViewIsHide:(BOOL)isHide{
    [self operateButtonAnimationUp:isHide];
}
-(void)scanViewAnimation:(BOOL)animated{
    [self  operateButtonAnimationUp:animated];
}
-(void)operateButtonAnimationUp:(BOOL)up{
    if(up){
        [UIView animateWithDuration:0.3 animations:^{
            self.locationBtn.frame= CGRectMake(Screenwidth-65, self.scanView.frame.origin.y-60,40, 40);
            self.serviceBtn.frame=CGRectMake(Screenwidth-65, self.scanView.frame.origin.y-120,40, 40);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.locationBtn.frame= CGRectMake(Screenwidth-65, self.scanView.frame.origin.y-60,40, 40);
            self.serviceBtn.frame=CGRectMake(Screenwidth-65, self.scanView.frame.origin.y-120,40, 40);
        }];
    }
}

#pragma mark AudioDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (flag) {
        if (_currentTrackNumber < [_arrayOfTracks count] - 1) {
            _currentTrackNumber ++;
            if (_audioplayer) {
                [_audioplayer stop];
                _audioplayer = nil;
            }
            _audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[[NSString alloc] initWithString:[_arrayOfTracks objectAtIndex:_currentTrackNumber]] ofType:@"m4a"]] error:NULL];
            _audioplayer.delegate = self;
            [_audioplayer play];
        }else{
            [_audioplayer stop];
            _audioplayer = nil;
        }
    }
}
#pragma mark 右侧按钮的点击方法
-(void)service:(UIButton*)sender{
    LYServiceViewController*svc=[[LYServiceViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
    
}
-(void)refresh:(UIButton*)sender{
    

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
