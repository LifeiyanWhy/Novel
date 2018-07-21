//
//  NOVMessageViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/4/19.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMessageViewController.h"
#import "NOVMessageView.h"
#import "NOVMessageCellModel.h"
#import "NOVMessageTableViewCell.h"
#import "NOVChatroomViewController.h"
#import "NOVLongpressCellView.h"

#define tabBarHeight self.navigationController.tabBarController.tabBar.frame.size.height

@interface NOVMessageViewController ()<NOVViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,NOVMessageTableViewCellDelegate>

@property(nonatomic,strong) UISearchController *noticeSearchController;

@property(nonatomic,strong) UISearchController *chatSearchController;

@end

@implementation NOVMessageViewController{
    NOVMessageCellModel *model;
    //标记最近一次点击的cell
    NSIndexPath *lastLongPressCellindexPath;
    NSInteger numberOfCell;
    NSInteger numberOfCellChat;
    BOOL touchTopButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.tabBarItem.badgeValue = @"4";

    self.view.backgroundColor = [UIColor whiteColor];
    
    _messageView = [[NOVMessageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tabBarHeight)];
    [self.view addSubview:_messageView];
    
    _messageView.headView.delegate = self;
    _messageView.scrollView.delegate = self;
    [_messageView.longPressView.deleteButton addTarget:self action:@selector(deleteCell) forControlEvents:UIControlEventTouchUpInside];
    [_messageView.longPressView.settopButton addTarget:self action:@selector(settopCell) forControlEvents:UIControlEventTouchUpInside];
    
    _messageView.noticeTableView.delegate = self;
    _messageView.noticeTableView.dataSource = self;
     [_messageView.noticeTableView registerClass:[NOVMessageTableViewCell class] forCellReuseIdentifier:@"messageCell"];
    
    _messageView.chatTableView.delegate = self;
    _messageView.chatTableView.dataSource = self;
    [_messageView.chatTableView registerClass:[NOVMessageTableViewCell class] forCellReuseIdentifier:@"messageCell"];
    
    //搜索框
    _noticeSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self setSearchController:_noticeSearchController];
    _chatSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self setSearchController:_chatSearchController];
    
    _messageView.noticeTableView.tableHeaderView = _noticeSearchController.searchBar;
    _messageView.chatTableView.tableHeaderView = _chatSearchController.searchBar;

    self.definesPresentationContext = YES;

    model = [[NOVMessageCellModel alloc] init];
    numberOfCell = 8;
    numberOfCellChat = 8;
}

-(void)setSearchController:(UISearchController *)searchController{
    searchController.delegate = self;
    searchController.searchResultsUpdater = self;
    searchController.hidesNavigationBarDuringPresentation = YES;
    searchController.searchBar.showsCancelButton = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;
}

-(void)touchRespone:(UIButton *)touchButton{
    touchTopButton = YES;
    [_messageView viewResponseWhenTouchButton:touchButton];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    touchTopButton = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //如果是点击button导致的scrollView移动则不触发该方法
    if (touchTopButton) {
        return;
    }
    if (_messageView.scrollView == scrollView) {    //判断是否为水平移动
        [_messageView.headView setButtonPostion:scrollView.contentOffset width:scrollView.contentSize.width];
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
}

- (void)didPresentSearchController:(UISearchController *)searchController{
}

-(void)willDismissSearchController:(UISearchController *)searchController{
}

- (void)didDismissSearchController:(UISearchController *)searchController{
    self.navigationController.navigationBar.hidden = YES;
}

//长按cell执行
-(void)longPressTableView:(UITableView *)tableView Cell:(NOVMessageTableViewCell *)messageTableViewCell touchPoint:(CGPoint)point{
    lastLongPressCellindexPath = [tableView indexPathForCell:messageTableViewCell];
    [self.messageView longPress:point];
}

//删除cell
-(void)deleteCell{
    //scrollview当前所在位置
    NSInteger i = _messageView.scrollView.contentOffset.x/self.view.frame.size.width;
    [_messageView longPressViewTakeUp];
    if (i == 0) {
        numberOfCell --;
        [_messageView.noticeTableView beginUpdates];
        [_messageView.noticeTableView deleteRowsAtIndexPaths:@[lastLongPressCellindexPath] withRowAnimation:UITableViewRowAnimationRight];
        [_messageView.noticeTableView endUpdates];
    }else{
        numberOfCellChat --;
        [_messageView.chatTableView beginUpdates];
        [_messageView.chatTableView deleteRowsAtIndexPaths:@[lastLongPressCellindexPath] withRowAnimation:UITableViewRowAnimationRight];
        [_messageView.chatTableView endUpdates];
    }
}
//置顶cell
-(void)settopCell{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"messageCell";
    NOVMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    cell.imageView.image = [UIImage imageNamed:@"cellimage.jpg"];
    cell.delegate = self;
    [cell upDateCellWithModel:model];
    cell.indexPath = indexPath;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _messageView.chatTableView) {
        return numberOfCellChat;
    }
    return numberOfCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return model.cellheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到聊天界面
    NOVChatroomViewController *chatroomViewController = [[NOVChatroomViewController alloc] init];
    chatroomViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatroomViewController animated:NO];
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
