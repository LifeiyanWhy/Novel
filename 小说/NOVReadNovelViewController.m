//
//  NOVReadNovelViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/4/20.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadNovelViewController.h"
#import "NOVReadPageViewController.h"
#import "NOVReadNovelView.h"
#import "NOVObatinBookContent.h"
#import "NOVReadEditVIew.h"
#import "NOVDataModel.h"
#import <AFNetworking.h>

@interface NOVReadNovelViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property(nonatomic,strong) UIPageViewController *pageViewController;

@property(nonatomic,strong) NSMutableArray *controllerArray;

@property(nonatomic,strong) NOVReadEditVIew *readEditView;

@end

@implementation NOVReadNovelViewController{
    NOVObatinBookContent *obatinBookContent; //用于获取作品信息的类
    NOVReadPageViewController *currentPageController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    _pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _pageViewController.doubleSided = NO;
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];

    _controllerArray = [NSMutableArray array];
    obatinBookContent = [[NOVObatinBookContent alloc] init];
    [obatinBookContent getBookFirstChapterIdWithBookID:_novelModel.bookId succeed:^(id responseObject) {
        NSNumber *number = responseObject[@"data"][0][@"branchId"];
        [obatinBookContent ObtainBookContenWithBranchId:[number integerValue] succeed:^(id responseObject) {
            //将获取到的文本显示到当前controller上
            currentPageController.readNovelView.contentLabel.text = responseObject[@"data"][@"content"];
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    } fail:^(NSError *error) {
        
    }];
    for (int i = 0; i < 3; i++) {
        NOVReadPageViewController *pageController = [[NOVReadPageViewController alloc] init];
        [_controllerArray addObject:pageController];
        [pageController.readNovelView.midButton addTarget:self action:@selector(setMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    //初始要显示的controller
    currentPageController = _controllerArray[0];
    [_pageViewController setViewControllers:@[_controllerArray[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

-(void)setMenu{
    NSLog(@"setMenu");
    if (!_readEditView) {
        _readEditView = [[NOVReadEditVIew alloc] init];
    }
    [currentPageController.readNovelView setMenu:_readEditView];
    [_readEditView.backButton addTarget:self action:@selector(touchBackButton) forControlEvents:UIControlEventTouchUpInside];
    [_readEditView.rightButton addTarget:self action:@selector(touchRightButton) forControlEvents:UIControlEventTouchUpInside];
    [_readEditView.collectionButton addTarget:self action:@selector(touchCollectionButton:) forControlEvents:UIControlEventTouchUpInside];
    [_readEditView.followButton addTarget:self action:@selector(touchFollowButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touchRightButton{
    BOOL collection = NO,follow = NO;
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSArray *array = [datamodel getFollowBookList];
    for (NSNumber *bookId in array) {
        if(self.novelModel.bookId == [bookId integerValue]){
            follow = YES;
        }
    }
    [_readEditView touchRightButtonCollection:collection follow:follow];
}

-(void)touchCollectionButton:(UIButton *)button{
    [_readEditView collectionButtonChange:button];
}

-(void)touchFollowButton:(UIButton *)button{
    NOVObatinBookContent *model = [[NOVObatinBookContent alloc] init];
    if (!button.selected) { //关注
        [model followBookWithBookId:self.novelModel.bookId succeed:^(id responseObject) {
            NSLog(@"%@",responseObject[@"message"]);
            //更新本地存储的关注列表
            NOVDataModel *datamodel = [NOVDataModel shareInstance];
            NSArray *followArray = [datamodel getFollowBookList];
            NSMutableArray *array = [NSMutableArray arrayWithArray:followArray];
            [array addObject:[NSNumber numberWithInteger:self.novelModel.bookId]];
            [datamodel updateFollowBookListWithArray:array];
            
            [_readEditView followButtonChange:button];
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{  //取消关注
        [model cancelFollowBookId:self.novelModel.bookId succeed:^(id responseObject) {
            NSLog(@"%@",responseObject[@"message"]);
            //更新本地存储的关注列表
            NOVDataModel *datamodel = [NOVDataModel shareInstance];
            NSArray *followArray = [datamodel getFollowBookList];
            NSMutableArray *array = [NSMutableArray arrayWithArray:followArray];
            [array removeObject:[NSNumber numberWithInteger:self.novelModel.bookId]];
            [datamodel updateFollowBookListWithArray:array];
            
            [_readEditView followButtonChange:button];
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_readEditView && currentPageController.readNovelView.midButton.selected) {
        [currentPageController.readNovelView setMenu:_readEditView];
        currentPageController.readNovelView.midButton.selected = NO;
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if (currentPageController.readNovelView.midButton.selected) {
        return currentPageController;
    }
    int index = (int)[_controllerArray indexOfObject:viewController];
    if (index == 2) {
        currentPageController = _controllerArray[0];
        return _controllerArray[0];
    }else{
        currentPageController = _controllerArray[index+1];
        return _controllerArray[index+1];
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if (currentPageController.readNovelView.midButton.selected) {
        return currentPageController;
    }
    int index = (int)[_controllerArray indexOfObject:viewController];
    if (index == 0) {
        currentPageController = _controllerArray[2];
        return _controllerArray[2];
    }else{
        currentPageController = _controllerArray[index-1];
        return _controllerArray[index-1];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)touchBackButton{
    [self.navigationController popViewControllerAnimated:NO];
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
