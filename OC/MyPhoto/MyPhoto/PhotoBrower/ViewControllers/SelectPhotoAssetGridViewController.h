//
//  SelectPhotoAssetGridViewController.h
//  MyPhoto
//
//  Created by song on 16/7/6.
//  Copyright © 2016年 timelink. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;

@interface SelectPhotoAssetGridViewController : UIViewController

@property (strong) PHFetchResult *assrtsFetchResults;
@property (strong) PHAssetCollection *assetCollection;

@end
