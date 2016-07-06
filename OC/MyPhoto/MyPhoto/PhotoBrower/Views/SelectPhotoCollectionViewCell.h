//
//  SelectPhotoCollectionViewCell.h
//  MyPhoto
//
//  Created by song on 16/7/6.
//  Copyright © 2016年 timelink. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const _cellIdentifier = @"collectionCell";

@interface SelectPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *cellImage;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndex:(NSIndexPath *)indexPath;

@end
