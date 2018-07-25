//
//  NOVReadNovelView.m
//  小说
//
//  Created by 李飞艳 on 2018/4/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadNovelView.h"
#import "Masonry.h"

@implementation NOVReadNovelView
-(void)setFrameRef:(CTFrameRef)frameRef{
    if (_frameRef != frameRef) {
        if (_frameRef) {
            CFRelease(_frameRef);
            _frameRef = nil;
        }
        _frameRef = frameRef;
    }
}
-(void)dealloc
{
    if (_frameRef) {
        CFRelease(_frameRef);
        _frameRef = nil;
    }
}
- (void)drawRect:(CGRect)rect{
    if (!_frameRef) {
        return;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CTFrameDraw(_frameRef, ctx);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
