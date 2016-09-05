//
//  PHSearchNotingCell.m
//  iMSBuyerTicket
//
//  Created by Y杨定甲 on 16/4/9.
//  Copyright © 2016年 Martin Hartl. All rights reserved.
//

#import "PHSearchNotingCell.h"
#import "PHSearchRecommendCollectionCell.h"

#define CELLHEIGHT ((((self.frame.size.width - 20)/2)-10)/140)*187+84

@interface PHSearchNotingCell()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *recommendCollectionView;

@property (strong, nonatomic) NSMutableArray *collectionArray;
@end
@implementation PHSearchNotingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionArray = [NSMutableArray new];
    self.recommendCollectionView.delegate = self;
    self.recommendCollectionView.dataSource = self;
    
    self.recommendCollectionView.alwaysBounceVertical = NO;
    [self.recommendCollectionView registerNib:[UINib nibWithNibName:@"PHSearchRecommendCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"PHSearchRecommendCollectionCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)pushInfoData:(NSMutableArray *)array{
    self.collectionArray = array;
    [self.recommendCollectionView reloadData];
}


#pragma mark - UICollectionView协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellMark = @"PHSearchRecommendCollectionCell";
    PHSearchRecommendCollectionCell *recommendCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellMark forIndexPath:indexPath];
    
    return recommendCell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    self.collectionBlock(indexPath.row);
//    
//    NSLog(@"%ld",(long)indexPath.row);
//    
//}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((self.frame.size.width - 20)/2, CELLHEIGHT);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,8,0,8);//分别为上、左、下、右
}


- (void)handlerCellSelect:(BlockDidSelect)block{

    self.collectionBlock = block;

}


@end
