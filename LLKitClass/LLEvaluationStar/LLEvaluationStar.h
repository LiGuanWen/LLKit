//
//  EvaluationStar.h
//  PPAutoInsurance
//
//  Created by Lilong on 16/1/1.
//  Copyright © 2016年 PPChe. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLEvaluationStarDelegate <NSObject>
@optional
-(void)theCurrentCommentText:(NSString *)commentText;//获得实时评价级别
-(void)starChanged:(NSInteger)currentStar;  // 当前星级变更

@end

@interface LLEvaluationStar : UIView
@property (nonatomic,strong) NSString *commentText;//评价级别

@property (nonatomic,assign) float width;//实时记录评价详细分数

@property (nonatomic,assign) id <LLEvaluationStarDelegate> delegate;
//初始化 （用于选择）
- (id)initWithFrame:(CGRect)frame EmptyImage:(NSString *)Empty StarImage:(NSString *)Star andSpacing:(float)spacing;
//设置几星 和是否可编辑
- (void)setStarCount:(float)count editable:(BOOL)yesOrNo;

@end
