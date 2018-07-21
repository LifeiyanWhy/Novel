//
//  NOVMystartViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/5/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMystartViewController.h"
#import "NOVMystartView.h"
#import "NOVSetView.h"
#import "NOVWriteViewController.h"
#import "NOVEditViewController.h"
#import "NOVStartManager.h"
#import "NOVMystartModel.h"

@interface NOVMystartViewController ()<NOVMystartViewDategate>

@property(nonatomic,strong) NOVMystartView *mystartView;

@property(nonatomic,strong) NSMutableArray *novelArray;

@end

@implementation NOVMystartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithDisplayP3Red:0.15 green:0.65 blue:0.6 alpha:1.00];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 130, 30)];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setImage:[UIImage imageNamed:@"返回white.png"] forState:UIControlStateNormal];
    [leftview addSubview:leftButton];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 100, 30)];
    label.text = @"我的发起";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    [leftview addSubview:label];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftview];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(creatStart)];
    
    _mystartView = [[NOVMystartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_mystartView];
    _mystartView.delegate = self;
    
    _novelArray = [NSMutableArray array];
    [_novelArray addObject:[[NOVMystartModel alloc] init]];
    //获取当前用户的所有作品
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithDisplayP3Red:0.15 green:0.65 blue:0.6 alpha:1.00];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)touchEditButtonInSetView:(NOVSetView *)setView{
    //已发布
    if (setView.novelState == 1) {
        return;
    }
    
    NOVMystartModel *model = _novelArray[setView.tag-1];
    NOVWriteViewController *writeViewController = [[NOVWriteViewController alloc] init];
    writeViewController.publishNovelBlock = ^(NSString *title, NSString *content) {
        //发布作品内容
        NOVStartManager *startManager = [[NOVStartManager alloc] init];
        [startManager startNovelWithModel:model success:^(id  _Nonnull responseObject) {
            
            //发布成功
            [startManager publishNovelWithBookId:1 chapterTitle:title content:content success:^(id  _Nonnull responseObject) {
                //发布成功
                //改变编辑button状态
                [setView.editButton setTitle:@"查看作品(已发布)" forState:UIControlStateNormal];
                //标记为已发布
                setView.novelState = NovelStatePublished;
            } fail:^(NSError * _Nonnull error) {
            }];
        
        } fail:^(NSError * _Nonnull error) {
        }];
    };
    [self.navigationController pushViewController:writeViewController animated:NO];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)creatStart{
    __block NOVMystartViewController *weakSelf = self;
    NOVEditViewController *editViewController = [[NOVEditViewController alloc] init];
    editViewController.novelTitleBlock = ^(NOVMystartModel *model) {
        //在我的发起界面根据回调的数据添加作品（未发布）
        [weakSelf.mystartView addViewWithModel:model];
        //更新数据源
        [weakSelf.novelArray addObject:model];
    };
    [self.navigationController pushViewController:editViewController animated:NO];
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
