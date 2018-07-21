//
//  NOVReadPageViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/4/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadPageViewController.h"
#import "NOVReadNovelView.h"


@interface NOVReadPageViewController ()

@end

@implementation NOVReadPageViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        _readNovelView = [[NOVReadNovelView alloc] init];
        _readNovelView.frame = self.view.frame;
        [self.view addSubview:_readNovelView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
