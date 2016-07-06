//
//  SelectPhotoAssetGridViewController.m
//  MyPhoto
//
//  Created by song on 16/7/6.
//  Copyright © 2016年 timelink. All rights reserved.
//

#import "SelectPhotoAssetGridViewController.h"
#import "SelectPhotoCollectionView.h"
#import "SelectPhotoCollectionViewCell.h"

@interface SelectPhotoAssetGridViewController ()

@property (nonatomic, strong) SelectPhotoCollectionView *collectionView;

@end

@implementation SelectPhotoAssetGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self setupNavigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationController{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(dismiss)];
    self.title=@"相册";
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter
- (SelectPhotoCollectionView *)collectionView {
    if (_collectionView == nil) {
        CGFloat cellW = (self.view.frame.size.width - 2*3 -10)/4;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(cellW, cellW);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 2;
        
        _collectionView = [[SelectPhotoCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[SelectPhotoCollectionViewCell class] forCellWithReuseIdentifier:_cellIdentifier];
        _collectionView.contentInset = UIEdgeInsetsMake(5, 5, 44, 5);
        _collectionView.frame = self.view.bounds;
        if (self.assrtsFetchResults != nil) {
            _collectionView.assrtsFetchResults = self.assrtsFetchResults;
        }
        if (self.assetCollection != nil) {
            _collectionView.assetCollection = self.assetCollection;
        }
    }
    return _collectionView;
}

@end