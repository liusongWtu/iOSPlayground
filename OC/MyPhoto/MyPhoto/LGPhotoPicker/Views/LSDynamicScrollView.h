//
//  LSDynamicScrollView.h
//  MyPhoto
//
//  Created by song on 16/7/5.
//  Copyright © 2016年 timelink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDynamicScrollView : UIView


@property(nonatomic,retain)UIScrollView *scrollView;

@property(nonatomic,retain)NSMutableArray *images;

@property(nonatomic,retain)NSMutableArray *viewItems;

@property(nonatomic,copy)void(^deleteImageBlock)(int index);

@property(nonatomic,copy)void (^clickImageBlock)(int index);

- (id)initWithFrame:(CGRect)frame withImages:(NSMutableArray *)images;

//添加一个新图片
- (void)addImageView:(NSString *)imageName;

@end
