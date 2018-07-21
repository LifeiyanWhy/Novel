//
//  NOVChatroomTableViewCell.m
//  小说
//
//  Created by 李飞艳 on 2018/5/2.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVChatroomTableViewCell.h"
#import "Masonry.h"

@implementation NOVChatroomTableViewCell{
    CGRect rect;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _myImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_myImage];
        
        _chatBackgroundImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_chatBackgroundImage];
        
        _label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)layoutSubviews{
    self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    
    [_myImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.mas_equalTo(self.frame.size.width*0.11);
        make.right.equalTo(self).offset(-10);
        make.width.mas_equalTo(self.frame.size.width*0.11);
    }];
    _myImage.layer.cornerRadius = 20;
    _myImage.layer.masksToBounds = YES;
    
    CGFloat width;
    if (rect.size.width + 20 > self.frame.size.width*0.7) {
        width = self.frame.size.width*0.7;
    }else{
        width = rect.size.width + 20;
    }
    [_chatBackgroundImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myImage);
        make.right.equalTo(_myImage.mas_left).offset(-3);
        make.width.mas_equalTo(width);
        make.bottom.equalTo(_label).offset(15);
    }];
    
    UIImage *image = [UIImage imageNamed:@"对话框-气泡右.png"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height-5];
    _chatBackgroundImage.image = image;
    
    [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chatBackgroundImage).offset(10);
        make.right.equalTo(_chatBackgroundImage).offset(-10);
        make.left.equalTo(_chatBackgroundImage).offset(10);
    }];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textColor = [UIColor blackColor];
    _label.numberOfLines = 0;
}

- (void)makeCellWithImageUrl:(NSString *)imageUrl message:(NSString *)message{
    [_myImage setImage:[UIImage imageNamed:imageUrl]];
    _label.text = message;
    rect = [message boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    
//    CGPoint location = [gestureRecognizer locationInView:self.contentView];
//    NSLog(@"%@ %@",NSStringFromCGRect(_chatBackgroundImage.frame),NSStringFromCGPoint(location));
//    if (CGRectContainsPoint(_chatBackgroundImage.frame, location)) {
//        NSLog(@"imageivew");
//        [self.delegate touchMessageLabel];
//    }else if([touch.view isKindOfClass:[self.contentView class]]){
//        [self.delegate touchBlankView];
//    }
//    return YES;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
