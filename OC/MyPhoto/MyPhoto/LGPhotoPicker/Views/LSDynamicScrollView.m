//
//  LSDynamicScrollView.m
//  MyPhoto
//
//  Created by song on 16/7/5.
//  Copyright © 2016年 timelink. All rights reserved.
//

#import "LSDynamicScrollView.h"
#import "LGPhotoPickerCommon.h"

#define kDeleteButtonSize 26

@implementation LSDynamicScrollView
{
    float width;
    float height;
    float singleWidth;
    float imageViewWidth;
    CGPoint startPoint;
    CGPoint originPoint;
    BOOL isContain;
}

- (id)initWithFrame:(CGRect)frame withImages:(NSMutableArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBottomBarColor;
//        self.backgroundColor=[UIColor redColor];
        UIScreen *screen = [UIScreen mainScreen];
        width = screen.bounds.size.width;
        height = screen.bounds.size.height;
        _viewItems = [NSMutableArray arrayWithCapacity:images.count];
        self.images = images;
        singleWidth=CGRectGetHeight(frame);
        imageViewWidth=singleWidth-kDeleteButtonSize/2;
        //创建底部滑动视图
        [self _initScrollView];
        [self _initViews];
    }
    return self;
}

- (void)_initScrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
}

- (void)_initViews
{
    for (int i = 0; i < self.images.count; i++) {
        NSString *imageName = self.images[i];
        [self createImageViews:i withImageName:imageName];
    }
    self.scrollView.contentSize = CGSizeMake(self.images.count * singleWidth, self.scrollView.frame.size.height);
}

- (void)createImageViews:(int)i withImageName:(NSString *)imageName
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(singleWidth*i, 0, singleWidth, singleWidth)];
    [self.scrollView addSubview:view];
    [self.viewItems addObject:view];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imgView.frame = CGRectMake(0, kDeleteButtonSize/2, imageViewWidth, imageViewWidth);
    imgView.userInteractionEnabled = YES;
    [view addSubview:imgView];
    UITapGestureRecognizer *tapPress=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [imgView addGestureRecognizer:tapPress];

    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:[UIImage imageNamed:@"album_select_cancel"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    deleteButton.frame = CGRectMake(imageViewWidth-kDeleteButtonSize/2, 0, kDeleteButtonSize, kDeleteButtonSize);
    deleteButton.backgroundColor = [UIColor clearColor];
    [view addSubview:deleteButton];
}

-(void)tapAction:(UITapGestureRecognizer*)recognizer{
    if (self.clickImageBlock) {
        UIImageView *imageView = (UIImageView *)recognizer.view;
        int index = (int)[self.viewItems indexOfObject:imageView.superview];
        self.clickImageBlock(index);
    }
}

- (void)deleteAction:(UIButton *)button
{
    UIView *view = (UIView *)button.superview;
    __block int index = (int)[self.viewItems indexOfObject:view];
    __block CGRect rect = view.frame;
    __weak UIScrollView *weakScroll = self.scrollView;
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        if (self.deleteImageBlock) {
            self.deleteImageBlock(index);
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            for (int i = index + 1; i < self.viewItems.count; i++) {
                UIImageView *otherImageView = self.viewItems[i];
                CGRect originRect = otherImageView.frame;
                otherImageView.frame = rect;
                rect = originRect;
            }
        } completion:^(BOOL finished) {
            [self.viewItems removeObject:view];
            if (self.viewItems.count*singleWidth >= width) {
                weakScroll.contentSize = CGSizeMake(singleWidth*self.viewItems.count, self.scrollView.frame.size.height);
            }
        }];
    }];
}

//添加一个新图片
- (void)addImageView:(NSString *)imageName
{
    [self createImageViews:(int)self.viewItems.count withImageName:imageName];
    
    self.scrollView.contentSize = CGSizeMake(singleWidth*self.viewItems.count, self.scrollView.frame.size.height);
    if (self.viewItems.count*singleWidth >=width) {
        [self.scrollView setContentOffset:CGPointMake(self.viewItems.count*singleWidth-width, 0) animated:YES];
    }
}

@end
