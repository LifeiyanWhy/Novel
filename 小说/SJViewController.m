//
//  SJViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/3/29.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "SJViewController.h"
#import "SJView.h"
#import "NOVView.h"
#import "SJBottomView.h"
#import "NOVBookTableViewCell.h"
#import "NOVReadNovelViewController.h"
#import "NOVMystartViewController.h"
#import "NOVObtainBookshelfModel.h"
#import "NOVbookMessage.h"

#define tabBarHeight self.navigationController.tabBarController.tabBar.frame.size.height //控制器高度

@interface SJViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,NOVViewDelegate>

@property(nonatomic,strong) SJView *sjview;

@end

@implementation SJViewController{
    BOOL touchTopButton;
    NSMutableArray *followModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    _sjview = [[SJView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tabBarHeight)];
    [self.view addSubview:_sjview];
    _sjview.scrollView.delegate = self;
    [_sjview.startButton addTarget:self action:@selector(fqStart) forControlEvents:UIControlEventTouchUpInside];
    _sjview.headView.delegate = self;
    
    _sjview.collectionView.tableView.delegate = self;
    _sjview.collectionView.tableView.dataSource = self;
    [_sjview.collectionView.tableView registerClass:[NOVBookTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _sjview.followView.tableView.delegate = self;
    _sjview.followView.tableView.dataSource = self;
    [_sjview.followView.tableView registerClass:[NOVBookTableViewCell class] forCellReuseIdentifier:@"cell"];
    followModelArray = [NSMutableArray array];
    
    _sjview.joinView.tableView.delegate = self;
    _sjview.joinView.tableView.dataSource = self;
    [_sjview.joinView.tableView registerClass:[NOVBookTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NOVObtainBookshelfModel *model = [[NOVObtainBookshelfModel alloc] init];
    [model obtainFollowBookListSucceed:^(id  _Nullable responseObject) {
        NOVAllBookMesssage *allFindModel = [[NOVAllBookMesssage alloc] initWithDictionary:responseObject error:nil];
        NSMutableArray *array = [NSMutableArray arrayWithArray:allFindModel.data];
        for (int i = 0; i < array.count; i++) {
            NOVbookMessage *model = [[NOVbookMessage alloc] initWithDictionary:array[i] error:nil];
            [followModelArray addObject:model];
            NSLog(@"name:%@ bookID:%ld",model.bookName,(long)model.bookId);
        }
        [_sjview.followView.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        if (error.code == -1009) {
        }
    }];
}

-(void)touchRespone:(UIButton *)touchButton{
    touchTopButton = YES;
    [_sjview viewResponseWhenTouchButton:touchButton];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    touchTopButton = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //如果是点击button导致的scrollView移动则不触发该方法
    if (touchTopButton || scrollView != _sjview.scrollView) {
        return;
    }
    [_sjview.headView setButtonPostion:scrollView.contentOffset width:scrollView.contentSize.width];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    NOVBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell updateCellModel:followModelArray[indexPath.section]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return followModelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height*0.2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NOVReadNovelViewController *readNovelViewController = [[NOVReadNovelViewController alloc] init];
    readNovelViewController.hidesBottomBarWhenPushed = YES;
    readNovelViewController.bookMessage = followModelArray[indexPath.section];
    [self.navigationController pushViewController:readNovelViewController animated:NO];
}

- (void)fqStart{
    NOVMystartViewController *mystartViewcontroller = [[NOVMystartViewController alloc] init];
    mystartViewcontroller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mystartViewcontroller animated:NO];
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
