//
//  NOVWriteViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/4/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVWriteViewController.h"
#import "NOVWriteView.h"
#import "NOVSetUpView.h"
#import "NOVKeyboardView.h"

@interface NOVWriteViewController ()<NOVWriteViewDelegate,UIScrollViewDelegate,NOVSetUpViewDelegate>

@property(nonatomic,strong) NOVWriteView *writeView;

@end

@implementation NOVWriteViewController{
    UIButton *leftButton;
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 90, 30)];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"返回-3.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftButton];
    label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 100, 30)];
    label.text = @"0字";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    [leftView addSubview:label];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    UIBarButtonItem *tempBar = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    tempBar.width = -10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:tempBar,leftBar,nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publish)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.8f;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(-2, 2);
    self.navigationController.navigationBar.layer.masksToBounds = NO;
    
    _writeView = [[NOVWriteView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.bounds.size.height)];
    [self.view addSubview:_writeView];
    [_writeView.setupButton addTarget:self action:@selector(setupView) forControlEvents:UIControlEventTouchUpInside];
    _writeView.scrollView.delegate = self;
    _writeView.delagate = self;
    _writeView.setUpView.delegate = self;
    [_writeView.keyboardView.hiddenKeyboard addTarget:self action:@selector(cancelKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardShow:(NSNotification *)notification{
    [_writeView keyboardShowWithFrame:[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]];
}

- (void)keyboardHidden:(NSNotification *)notification{
    [_writeView keyBoardHidden];
}

-(void)cancelKeyboard{
    [_writeView.titleTextView resignFirstResponder];
    [_writeView.contentTextView resignFirstResponder];
}

//点击setupButton时执行
- (void)setupView{
    //显示设置背景颜色及亮度的view
    [_writeView setupView];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_writeView responseWhenTouchView];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

//输入正文时执行
- (void)contentTextViewChange:(NSUInteger)numberOfWords withContent:(NSString *)content{
    NSString *number = [NSString stringWithFormat:@"%lu字",(unsigned long)numberOfWords];
    label.text = number;
}


//点击rightBarButtonItem（发布）button执行
- (void)publish{
    if (![_writeView.contentTextView.text  isEqual: @""] && ![_writeView.titleTextView.text  isEqual: @""]) {
        self.publishNovelBlock(_writeView.titleTextView.text, _writeView.contentTextView.text);
    }
    [self.navigationController popViewControllerAnimated:NO];
}

//点击颜色button（setupview的代理方法）
-(void)touchColorButton:(UIButton *)button color:(UIColor *)color{
    [_writeView setViewColorWithColor:color];
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
