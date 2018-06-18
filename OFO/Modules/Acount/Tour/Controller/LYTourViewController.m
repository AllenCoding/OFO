//
//  LYTourViewController.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/30.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYTourViewController.h"
#import "LYTourCell.h"


@interface LYTourViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*dataSource;

@end

@implementation LYTourViewController

#pragma mark Lazy Load
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    return _dataSource;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, ScreenHeight-NavgationBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.backgroundColor=[UIColor whiteColor];
    }
    return _tableView;
}


#pragma mark  Life-Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 17;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYTourCell*cell=[LYTourCell initCellWithTableview:tableView];
//    cell.tour=self.dataSource[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 80)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(30, 30, 150, 20)];
    lab.text=@"我的行程";
    lab.font=BoldFontWithSize(30);
    [view addSubview:lab];
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 80;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    LYLog(@"-------------%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y>55) {
        self.title=@"我的行程";
    }else{
        self.title=@"";
    }
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
