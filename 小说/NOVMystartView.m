//
//  NOVMystartView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMystartView.h"
#import "NOVSetView.h"
#import "NOVMystartModel.h"
#import "NOVSetbackView.h"

@implementation NOVMystartView{
    NOVSetView *setView;
    NSInteger viewNumber;
    CGFloat scrollviewHeight;
    NSMutableArray *viewArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        _scrollView = [[UIScrollView alloc] init];
        [self addSubview:_scrollView];
        viewArray = [NSMutableArray array];
    }
    return self;
}

-(void)layoutSubviews{
    _scrollView.frame = self.frame;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height - 64);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    scrollviewHeight = self.frame.size.height - 64;
    _scrollView.pagingEnabled = YES;
    
    NOVMystartModel *model = [[NOVMystartModel alloc] init];
    model.name = @"这个反派不好当";
    setView = [[NOVSetView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.15, scrollviewHeight*0.07, self.frame.size.width*0.7, scrollviewHeight*0.83) model:model];
    setView.tag = 1;
    setView.detailButton.tag = 1;
    setView.backView.tableview.delegate = self;
    viewNumber = 1;
    [_scrollView addSubview:setView];
    [viewArray addObject:setView];
//    [setView.editButton addTarget:self action:@selector(touchEditButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addViewWithModel:(NOVMystartModel *)model{
    viewNumber++;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width*viewNumber, scrollviewHeight);
    NOVSetView *setview = [[NOVSetView alloc] initWithFrame:CGRectMake(self.frame.size.width*(viewNumber - 1 + 0.15), scrollviewHeight*0.07, self.frame.size.width*0.7, scrollviewHeight*0.83) model:model];
    //标记作品
    setview.tag = viewNumber;
    setview.detailButton.tag = viewNumber;
    [setview.editButton addTarget:self action:@selector(touchEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:setview];
    [viewArray addObject:setview];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height*0.07;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 0;
    }
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(void)touchEditButton:(UIButton *)button{
    //参数为所点击的setView(即小说)
    [self.delegate touchEditButtonInSetView:(NOVSetView *)[[button superview] superview]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
