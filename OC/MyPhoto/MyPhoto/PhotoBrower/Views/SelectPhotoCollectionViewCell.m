//
//  SelectPhotoCollectionViewCell.m
//  MyPhoto
//
//  Created by song on 16/7/6.
//  Copyright © 2016年 timelink. All rights reserved.
//

#import "SelectPhotoCollectionViewCell.h"

@implementation SelectPhotoCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndex:(NSIndexPath *)indexPath {
    SelectPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    if ([[cell.contentView.subviews lastObject] isKindOfClass:[UIImageView class]]) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    return cell;
}

@end
