//
//  LGPhotoPickerCommon.h
//  LGPhotoBrowser
//
//  Created by ligang on 15/10/27.
//  Copyright (c) 2015年 L&G. All rights reserved.

#ifndef ZLAssetsPickerDemo_PickerCommon_h
#define ZLAssetsPickerDemo_PickerCommon_h



#define iOS7gt ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define GetImage(imageName)  [UIImage imageNamed:imageName]
#define XG_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS9_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )

#define RGB(R,G,B)		[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
#define RGBA(R,G,B,A)   [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A/255.0f]

#define kBottomBarColor RGB(19,23,23)   //图片选择底部颜色
#define kPhotoPickerCollectionViewBgColor RGB(33,38,37) //图片选择列表背景颜色
#define kSelectedImageTipsColor RGB(132,137,135)    //已选择图片提示字体颜色

// 点击销毁的block
typedef void(^ZLPickerBrowserViewControllerTapDisMissBlock)(NSInteger);

//图片显示器分类
typedef NS_ENUM(NSInteger, LGShowImageType) {
    LGShowImageTypeImagePicker = 0, //照片选择器
    LGShowImageTypeImageBroswer,    //照片浏览器
    LGShowImageTypeImageURL,        //网络图片浏览器
};

// maxCount的默认值，不设置maxCount的时候有效
static NSInteger const KPhotoShowMaxCount = INT_MAX;

// ScrollView 滑动的间距
static CGFloat const LGPickerColletionViewPadding = 20;

// ScrollView拉伸的比例
static CGFloat const LGPickerScrollViewMaxZoomScale = 3.0;
static CGFloat const LGPickerScrollViewMinZoomScale = 1.0;

// 进度条的宽度/高度
static NSInteger const LGPickerProgressViewW = 50;
static NSInteger const LGPickerProgressViewH = 50;

// 分页控制器的高度
static NSInteger const LGPickerPageCtrlH = 25;

// NSNotification
static NSString *PICKER_TAKE_DONE = @"PICKER_TAKE_DONE";
static NSString *PICKER_TAKE_PHOTO = @"PICKER_TAKE_PHOTO";

static NSString *PICKER_PowerBrowserPhotoLibirayText = @"您屏蔽了选择相册的权限，开启请去系统设置->隐私->我的App来打开权限";


#endif
