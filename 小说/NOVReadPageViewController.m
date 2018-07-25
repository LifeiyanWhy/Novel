//
//  NOVReadPageViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/4/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadPageViewController.h"
#import "NOVReadNovelView.h"
#import "NOVReadConfig.h"
#import "NOVReadParser.h"

@interface NOVReadPageViewController ()

@end

@implementation NOVReadPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"novelBackground.png"]];
    [self.view addSubview:self.readNovelView];
}

-(NOVReadNovelView *)readNovelView{
    if (!_readNovelView) {
        _readNovelView = [[NOVReadNovelView alloc] initWithFrame:CGRectMake(20, 40, self.view.frame.size.width-40, self.view.frame.size.height - 80)];
        _readNovelView.backgroundColor = [UIColor clearColor];
        NOVReadConfig *config = [NOVReadConfig shareInstance];
        _readNovelView.frameRef = [NOVReadParser loadParserWithContent:_content config:config bounds:CGRectMake(0,0, _readNovelView.frame.size.width, _readNovelView.frame.size.height)];
        _readNovelView.content = _content;
    }
    return _readNovelView;
}

-(void)setBookContent:(NSString *)content{
    _content = content;
    [self readNovelView];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
