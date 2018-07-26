//
//  NOVEditSignViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/7/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVEditSignViewController.h"
#import "NOVEditSignView.h"
@interface NOVEditSignViewController ()<UITextViewDelegate>
@property(nonatomic,strong) NOVEditSignView *editSignView;
@end

@implementation NOVEditSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = SystemColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回-编辑资料.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.00];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.title = @"编辑简介";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.view addSubview:self.editSignView];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:_editSignView.placeholder] && textView.textColor == [UIColor grayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text  isEqual:@""]) {
        textView.text = _editSignView.placeholder;
        textView.textColor = [UIColor grayColor];
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    _editSignView.wordNumberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)textView.text.length];
    if (![_editSignView.textView.text  isEqual: @""]) {
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.00];
    }
    if (textView.text.length > 100) {
        _editSignView.wordNumberLabel.textColor = [UIColor orangeColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.00];
    }else if(textView.text.length == 0){
        _editSignView.wordNumberLabel.textColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.00];
    }else{
        _editSignView.wordNumberLabel.textColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

    }
}

-(NOVEditSignView *)editSignView{
    if (!_editSignView) {
        _editSignView = [[NOVEditSignView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
        _editSignView.textView.delegate = self;
    }
    return _editSignView;
}

-(void)back{
    [self.navigationController  popViewControllerAnimated:NO];
}

-(void)save{
    if (CGColorEqualToColor(self.navigationItem.rightBarButtonItem.tintColor.CGColor,[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.00].CGColor)) {
        return;
    }
    self.textsign(_editSignView.textView.text);
    [self.navigationController popViewControllerAnimated:NO];
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
