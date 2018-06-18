//
//  LYMainViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/31.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYMainViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "LYLoginVerifyViewController.h"

@interface LYMainViewController ()
/** url */
@property (nonatomic, strong) NSURL *url;

/** 视频播放器 */
@property (nonatomic, strong) MPMoviePlayerController *player;

@end

@implementation LYMainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVideoPlayer];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.player stop];
    self.player=nil;
    [self.player.view removeFromSuperview];
}

/**
 设置视频播放
 */
- (void)setupVideoPlayer{
    
    self.url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"ofo" ofType:@"mp4"]];
    // 创建播放器
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:self.url];
    // 添加到根视图
    [self.view addSubview:self.player.view];
    // 应该自动播放
    self.player.shouldAutoplay = YES;
    // 播放控制 : 不控制
    [self.player setControlStyle:(MPMovieControlStyleNone)];
    // 循环播放
    self.player.repeatMode = MPMovieRepeatModeOne;
    // 大小
    [self.player.view setFrame:self.view.bounds];
    // 缩放模式, 宽度或高度最小的那个等于屏幕宽或高
    self.player.scalingMode = MPMovieScalingModeAspectFill;
    // 透明
    self.player.view.alpha = 1;
    [UIView animateWithDuration:3 animations:^{
        self.player.view.alpha = 1;
        [self.player prepareToPlay];
    }];
    // 设置登录View
    [self setupLoginView];
}
/**
 设置登录View
 */
- (void)setupLoginView{
    //进入按钮
    UIButton *enterButton = [[UIButton alloc] init];
    enterButton.frame = CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 60 - 80, [UIScreen mainScreen].bounds.size.width - 100, 50);
    enterButton.backgroundColor=mainColor;
    [enterButton setTitle:@"注册/登录" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    enterButton.alpha = 0;
    enterButton.layer.cornerRadius=25;
    enterButton.layer.masksToBounds=YES;
    [self.player.view addSubview:enterButton];
    [enterButton addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:3.0 animations:^{
        enterButton.alpha = 1.0;
    }];
}
/**
 进入应用按钮点击事件
 */
- (void)enterButtonClick:(UIButton *)sender{
    LYLoginVerifyViewController*lvc=[[LYLoginVerifyViewController alloc]init];
    [self.navigationController pushViewController:lvc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
