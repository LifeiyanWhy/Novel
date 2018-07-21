//
//  NOVChatroomViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/5/2.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVChatroomViewController.h"
#import "NOVChatroomView.h"
#import "NOVChatroomTableViewCell.h"
#import "NOVChatroomReceiveTableViewCell.h"
#import "NOVChatroomModel.h"

@interface NOVChatroomViewController ()<UITableViewDataSource,UITableViewDelegate,NOVChatroomTableViewCellDelegate>

@property(nonatomic,strong) NOVChatroomView *chatroomView;

@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation NOVChatroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    
    _chatroomView = [[NOVChatroomView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_chatroomView];
    _chatroomView.tableView.delegate = self;
    _chatroomView.tableView.dataSource = self;
    [_chatroomView.tableView registerClass:[NOVChatroomTableViewCell class] forCellReuseIdentifier:@"chatRoomCell"];
    [_chatroomView.tableView registerClass:[NOVChatroomReceiveTableViewCell class] forCellReuseIdentifier:@"chatRoomReceiveCell"];
    [_chatroomView.sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    _dataArray = [NSMutableArray array];
    
    //监听键盘的显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

//键盘出现时执行
- (void)keyBoardShow:(NSNotification *)notification{
    [_chatroomView textViewShow:[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]];
}

//键盘回收时执行
- (void)keyBoardHide:(NSNotification *)notification{
    [_chatroomView textViewHide:[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]];
}

//发送
- (void)sendMessage{
    //生成一条消息记录
    if (![_chatroomView.textView.text isEqualToString:@""]){
        NOVChatroomModel *model = [[NOVChatroomModel alloc] initWithMessage:_chatroomView.textView.text];
        [_dataArray addObject:model];
        [_chatroomView.tableView reloadData];
    }
    //view响应
    if (self.dataArray.count != 0) {
        [_chatroomView sendmessageWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:_dataArray.count - 1]];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"chatRoomCell";
    static NSString *identifier1 = @"chatRoomReceiveCell";
    NOVChatroomModel *model = _dataArray[indexPath.section];
    if (model.messSenderType == 1) {
        NOVChatroomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell makeCellWithImageUrl:model.imageurl message:model.massage];
        return cell;
    }else{
        NOVChatroomReceiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NOVChatroomModel *model = _dataArray[indexPath.section];
    if (model.cellHeight < self.view.frame.size.width*0.11) {
        return self.view.frame.size.width*0.11;
    }
    return model.cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
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
