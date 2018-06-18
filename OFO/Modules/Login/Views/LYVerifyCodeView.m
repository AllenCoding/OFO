//
//  LYVerifyCodeView.m
//  OFO
//
//  Created by tianqiuqiu on 2017/10/31.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "LYVerifyCodeView.h"

@interface LYVerifyCodeView()

//成员属性默认生成set和get 方法

@property (nonatomic, retain) NSArray *changeArray;
@property (nonatomic, retain) NSMutableString *changeString;

@end

@implementation LYVerifyCodeView
/*Xib或者SB 重写会加载这个方法  而不是-(instancetype)initWithFrame:(CGRect)frame
 其他非视图xib和SB加载的话 加载-(instancetype)initWithFrame:(CGRect)frame*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self getRandomCode];
        self.backgroundColor=ColorWithRGB(219, 219, 219);
    }
    return self;
}
-(void)changeVerifyCode{
    [self setNeedsDisplay];
    [self getRandomCode];
}
-(void)getRandomCode{
    NSMutableArray *nums=[NSMutableArray new];
    for (int i=0; i<10; i++) {
        [nums addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.changeArray=[NSArray arrayWithArray:nums];
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:5];
    self.changeString = [[NSMutableString alloc] initWithCapacity:6];
    for(NSInteger i = 0; i < 4; i++){
        NSInteger index = arc4random() % ([self.changeArray count] - 1);
        getStr = [self.changeArray objectAtIndex:index];
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:getStr];
    }
    _code=self.changeString;
}

- (void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.5];
    
    NSString *text = [NSString stringWithFormat:@"%@",self.changeString];
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    int width = rect.size.width / text.length - cSize.width;
    int height = rect.size.height - cSize.height;
    CGPoint point;
    
    float pX, pY;
    for (int i = 0; i < text.length; i++)
    {
        pX = arc4random() % width + rect.size.width / text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    for(int cout = 0; cout < 10; cout++){
        red = arc4random() % 100 / 100.0;
        green = arc4random() % 100 / 100.0;
        blue = arc4random() % 100 / 100.0;
        color = [UIColor colorWithRed:red green:green blue:blue alpha:0.2];
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }
}




@end
