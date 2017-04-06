//
//  EvaluationStar.m
//  PPAutoInsurance
//
//  Created by Lilong on 16/1/1.
//  Copyright © 2016年 PPChe. All rights reserved.
//

#import "LLEvaluationStar.h"
//#define imageW  self.bounds.size.width/10
@interface LLEvaluationStar()
@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;
//间距 倍数
@property (nonatomic, assign) float spacing;

// 星星图片大小
@property (nonatomic, assign) float starWH;
@end

@implementation LLEvaluationStar

//初始化 （用于选择）
- (id)initWithFrame:(CGRect)frame EmptyImage:(NSString *)Empty StarImage:(NSString *)Star andSpacing:(float)spacing{
    //计算 星星图片大小的高和宽
    self.starWH = frame.size.width/(5*spacing);
    self.spacing = spacing;
    self = [super initWithFrame:frame];
    if (self) {
        self.starBackgroundView = [self buidlStarViewWithImageName:Empty];
        self.starForegroundView = [self buidlStarViewWithImageName:Star];
        [self addSubview:self.starBackgroundView];
        
        self.userInteractionEnabled = YES;
        
        /**点击手势*/
        UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
        [self addGestureRecognizer:tapGR];
        
        /**滑动手势*/
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
        [self addGestureRecognizer:panGR];
    }
    return self;

}

//设置几星 和是否可编辑
- (void)setStarCount:(float)count editable:(BOOL)yesOrNo{
    if (yesOrNo == YES) {
        self.userInteractionEnabled = YES;
    }else{
       self.userInteractionEnabled = NO;
    }
    self.starForegroundView.frame = CGRectMake(0, 0, (count)*self.spacing*self.starWH , self.starWH );
    [self addSubview:self.starForegroundView];
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int j = 0; j < 5; j ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(self.spacing*j*self.starWH , 0, self.starWH , self.starWH );
        [view addSubview:imageView];
    }
    return view;
}

-(void)tapGR:(UITapGestureRecognizer *)tapGR{
    CGPoint point =[tapGR locationInView:self];
    if (point.x<0) {
        point.x = 0;
    }
    int X = (int) point.x/(self.spacing*self.starWH );
    self.starForegroundView.frame = CGRectMake(0, 0, (X+1)*self.spacing*self.starWH , self.starWH );
    [self addSubview:self.starForegroundView];
    
    if (X == 0) {
        //差
        _width = 1;
        _commentText=@"差";
    }
    else if(X == 2){
        //一般
        _width = 2;
        _commentText=@"一般";
    }
    else if(X == 3){
        //好
        _width = 3;
        _commentText=@"好";
    }
    else if(X == 4){
        //很好
        _width = 4;
        _commentText=@"很好";
    }
    else{
        //非常好
        _width = 5;
        _commentText=@"非常好";
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(theCurrentCommentText:)]) {
        [_delegate theCurrentCommentText:_commentText];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(starChanged:)]) {
        [_delegate starChanged:X+1];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
