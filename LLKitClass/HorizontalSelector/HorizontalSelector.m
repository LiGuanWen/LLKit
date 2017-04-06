//
//  HorizontalSelector.m
//  News
//
//  Created by Lilong on 2016/12/14.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "HorizontalSelector.h"
#import "HorizontalSelectorCell.h"
#import "YYKit.h"
@interface HorizontalSelector ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation HorizontalSelector


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HorizontalSelectorCell" bundle:nil] forCellWithReuseIdentifier:@"HorizontalSelectorCell"];
}

+ (instancetype)initSelectorWithFrame:(CGRect)frame
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"HorizontalSelector" owner:nil options:nil];
    if (nibs.count > 0) {
        HorizontalSelector * selector = nibs[0];
        selector.frame = frame;
        return selector;
    }else{
        return nil;
    }
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    self.collectionView.scrollEnabled = titles.count > 3;
    [self.collectionView reloadData];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex == selectedIndex) return;
    _selectedIndex = selectedIndex;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - UICollection

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.titles.count > 3 ? 10 : CGFLOAT_MIN;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.titles.count < 4)
    {
        return CGSizeMake((kScreenWidth / self.titles.count), 40.0f);
    }
    return [HorizontalSelectorCell cellSizeWithTitle:self.titles[indexPath.item]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HorizontalSelectorCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHorizontalSelectorCell forIndexPath:indexPath];
    cell.title = self.titles[indexPath.item];
    cell.selected = (indexPath.item == self.selectedIndex);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == indexPath.item) return;
    self.selectedIndex = indexPath.item;
    if (self.itemSelectedBlock)
    {
        self.itemSelectedBlock(indexPath.item);
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
