//
//  NOVDetailViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/5/14.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVDetailViewController.h"
#import "NOVDetailTableViewCell.h"

@interface NOVDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation NOVDetailViewController{
    NSArray *titleArray;
    NSArray *detailArray;
    NSInteger selectCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 130, 30)];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setImage:[UIImage imageNamed:@"返回white.png"] forState:UIControlStateNormal];
    [leftview addSubview:leftButton];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 100, 30)];
    label.text = self.viewtitle;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    [leftview addSubview:label];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftview];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    switch (self.viewtype) {
        case 0:
            titleArray = @[@"续写",@"背景扩展"];
            break;
        case 1:
            titleArray = @[@"玄幻言情",@"仙侠奇缘",@"古代言情",@"现代言情",@"浪漫青春",@"悬疑灵异",@"科幻空间",@"游戏竞技",@"耽美小说"];
            break;
        case 2:
            titleArray = @[@"公开",@"我的粉丝",@"我的好友",@"部分人员"];
            detailArray = @[@"所有人可参与续写",@"我的粉丝可参与续写",@"互相关注可参与续写",@"指定可续写人员"];
            break;
        case 3:
            titleArray = @[@"公开",@"我的粉丝",@"我的好友",@"部分人员"];
            detailArray = @[@"所有人可见",@"我的粉丝可见",@"互相关注的人可见",@"指定可观看人员"];
            break;
        default:
            break;
    }
    selectCell = -1;
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

-(void)back{
    if (selectCell != -1) {
        self.viewtitleBlock(titleArray[selectCell],selectCell);
        //selectCell所选择类型对应的数字（枚举）
    }
    [self.navigationController popViewControllerAnimated:NO];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    NOVDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[NOVDetailTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: identifier];
    }
    cell.textLabel.text = titleArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"圈.png"];
    if (detailArray.count) {
        cell.detailTextLabel.text = detailArray[indexPath.row];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.viewtype == 1) {
        return self.view.frame.size.height*0.06;
    } else {
        return self.view.frame.size.height*0.1;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectCell == -1) {
        NOVDetailTableViewCell *cell = (NOVDetailTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"圈-2.png"];
        selectCell = indexPath.row;
    } else if (indexPath.row != selectCell){
        NOVDetailTableViewCell *cell1 = (NOVDetailTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectCell inSection:0]];
        cell1.imageView.image = [UIImage imageNamed:@"圈.png"];
        NOVDetailTableViewCell *cell = (NOVDetailTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"圈-2.png"];
        selectCell = indexPath.row;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
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
