//
//  SegmentView.m
//  News
//
//  Created by Lilong on 2016/12/13.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "SegmentView.h"


static NSInteger const kPointViewTag = 2000;
@interface SegmentView ()

@property (nonatomic, strong) NSMutableArray *btnsArray;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation SegmentView


- (instancetype)initWithSegmentTitles:(NSArray *)titles {
    self = [super init];
    if (self) {
        for (NSInteger i = 0; i < titles.count; ++i) {
            NSString *title = titles[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor colorWithHexString:@"989898"] forState:UIControlStateNormal];
            button.tag = i;
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button addTarget:self action:@selector(clickSegmentBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            // 小红点
            UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 7)];
            [pointView setCornerRadius:3.5];
            pointView.backgroundColor = [UIColor redColor];
            pointView.tag = kPointViewTag;
            pointView.hidden = YES;
            [button addSubview:pointView];
            
            [self addSubview:button];
            [self.btnsArray addObject:button];
        }
        
        UIButton *button = [self.btnsArray firstObject];
        button.selected = YES;
        button.userInteractionEnabled = NO;
        _currentIndex = 0;
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)showRedPointAtIndex:(NSInteger)index {
    if (index < self.btnsArray.count) {
        UIButton *button = self.btnsArray[index];
        // 显示小红点
        UIView *pointView = [button viewWithTag:kPointViewTag];
        pointView.hidden = NO;
    }
}

- (void)hideRedPointAtIndex:(NSInteger)index {
    if (index < self.btnsArray.count) {
        UIButton *button = self.btnsArray[index];
        // 隐藏小红点
        UIView *pointView = [button viewWithTag:kPointViewTag];
        pointView.hidden = YES;
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnH = self.height;
    CGFloat btnW = self.width / self.btnsArray.count;
    
    for (NSInteger i = 0; i < self.btnsArray.count; ++i) {
        UIButton *button = self.btnsArray[i];
        button.frame = CGRectMake(btnW * i, 0, btnW, btnH);
        
        NSString *title = button.titleLabel.text;
        CGFloat titleW = [title widthForFont:[UIFont systemFontOfSize:16]];
        UIView *pointView = [button viewWithTag:kPointViewTag];
        pointView.center = CGPointMake((button.width + titleW)/2+2, 4);
    }
    
    UIButton *curButton = [self.btnsArray objectAtIndex:self.currentIndex];
    NSString *curTitle = curButton.titleLabel.text;
    CGFloat lineW = [curTitle widthForFont:[UIFont systemFontOfSize:16]];
    self.lineView.bounds = CGRectMake(0, 0, lineW, 1.5);
    CGPoint lineCenter = CGPointMake(curButton.centerX,curButton.centerY + 14);
    self.lineView.center = lineCenter;
}

#pragma mark - event response
- (void)clickSegmentBtn:(UIButton *)button {
    [self updateUIWithCurrentButton:button];
    
    if (self.handle) {
        self.handle(button,button.tag);
    }
}
#pragma mark - private methods
- (void)updateUIWithCurrentButton:(UIButton *)button {
    for (UIButton *button in self.btnsArray) {
        button.selected = NO;
        button.userInteractionEnabled = YES;
    }
    
    NSInteger tag = button.tag;
    _currentIndex = tag;
    button.selected = YES;
    button.userInteractionEnabled = NO;
    
    NSString *curTitle = button.titleLabel.text;
    CGFloat lineW = [curTitle widthForFont:[UIFont systemFontOfSize:16]];
    
    CGPoint lineCenter = CGPointMake(button.centerX, button.centerY + 14);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.center = lineCenter;
        self.lineView.bounds = CGRectMake(0, 0, lineW, 1.5);
    }];
    
    // 隐藏小红点
    UIView *pointView = [button viewWithTag:kPointViewTag];
    pointView.hidden = YES;
}

#pragma mark - getters & setters
-(NSMutableArray *)btnsArray {
    if (!_btnsArray) {
        _btnsArray = [[NSMutableArray alloc] init];
    }
    return _btnsArray;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

-(void)setCurrentIndex:(NSInteger)currentIndex {
    if (currentIndex < self.btnsArray.count) {
        UIButton *button = self.btnsArray[currentIndex];
        [self updateUIWithCurrentButton:button];
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
