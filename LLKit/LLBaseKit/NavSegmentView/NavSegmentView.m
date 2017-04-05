//
//  NavSegmentView.m
//  News
//
//  Created by Lilong on 2016/12/13.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "NavSegmentView.h"



@interface NavSegmentView ()

/**
 按钮数组
 */
@property (strong, nonatomic) NSMutableArray <UIButton *> * buttons;

/**
 底部图片 （箭头）
 */
@property (strong, nonatomic) UIImageView * triangle;

@end


@implementation NavSegmentView


- (instancetype)initWithItems:(NSArray *) items
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, 210, 44);
        self.itemHeight = 44;
        self.itemWidth = 70;
        self.buttons = [NSMutableArray new];
        self.items = [items copy];
        if (items.count > 1) {
            [self addSubview:self.triangle];
        }
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *) items itemWidth:(float)itemWidth itemHeight:(float)itemHeight
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, itemWidth*items.count, itemHeight);
        self.itemHeight = itemHeight;
        self.itemWidth = itemWidth;
        self.buttons = [NSMutableArray new];
        self.items = [items copy];
        if (items.count > 1) {
            [self addSubview:self.triangle];
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.triangle.bottom = self.bottom + 0.6;
    self.triangle.centerX = (self.selectedIndex + 0.5) * (self.width / 3);
}

#pragma mark - setter

- (void)setItems:(NSMutableArray *)items
{
    if (self.buttons.count > 0)
    {
        [self.buttons removeAllObjects];
    }
    if (items.count > 0)
    {
        for (NSInteger i = 0; i < items.count; i ++)
        {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
            [button setTitle:items[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(self.itemWidth * i, 0, self.itemWidth, self.itemHeight);
            [self addSubview:button];
            [self.buttons addObject:button];
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex < 0 || selectedIndex == _selectedIndex)
    {
        return;
    }
    _selectedIndex = selectedIndex;
    for (NSInteger i = 0; i < self.buttons.count; i ++)
    {
        //        UIButton * btn = self.buttons[i];
        if (i == selectedIndex)
        {
            [UIView animateWithDuration:0.35 animations:^
             {
                 self.triangle.centerX = (i + 0.5) * (self.width / 3);
             } completion:NULL];
        }
    }
}

/**
 点击事件
 */
- (void)buttonAction:(UIButton *) sender
{
    self.selectedIndex = [self.buttons indexOfObject:sender];
    if (self.clickedBlock)
    {
        self.clickedBlock(self.selectedIndex);
    }
}

#pragma mark - getter

- (UIImageView *)triangle
{
    if (!_triangle)
    {
        _triangle = [[UIImageView alloc] init];
        _triangle.size = CGSizeMake(10, 5);
        _triangle.image = [UIImage imageNamed:@"NavSegmentViewImage"];
    }
    return _triangle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
