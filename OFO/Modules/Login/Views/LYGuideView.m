//
//  LYGuideView.m
//  OFO
//
//  Created by tianqiuqiu on 2017/11/1.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYGuideView.h"

@interface LYGuideView ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation LYGuideView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

-(void)setupView{
    
    self.scrollView.contentOffset=CGPointMake(0, 0);
    self.scrollView.pagingEnabled=YES;
    self.scrollView.backgroundColor=[UIColor clearColor];
    self.scrollView.delegate=self;
    self.pageControl.numberOfPages=self.imagesArray.count;
    self.scrollView.contentSize=CGSizeMake(self.imagesArray.count*(self.scrollView.frame.size.width), self.scrollView.frame.size.height);
    
    for (int i=0; i<self.imagesArray.count; i++) {
        UIImageView*iv=[[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width*i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        iv.image=[UIImage imageNamed:self.imagesArray[i]];
        [self.scrollView addSubview:iv];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}

-(IBAction)close:(UIButton *)sender {
    LYLog(@"点击我");
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.block) {
        self.block();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
