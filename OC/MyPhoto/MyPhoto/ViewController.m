//
//  ViewController.m
//  MyPhoto
//
//  Created by song on 16/7/1.
//  Copyright © 2016年 timelink. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "LGPhoto.h"
#import "LSDynamicScrollView.h"
#import "SelectPhotoAssetGridViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,LGPhotoPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) LGShowImageType showType;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
    
}

- (IBAction)defaultSelect:(id)sender {
    [self getImageFromIpc];
}

- (IBAction)mutiSelect:(id)sender {
    [self getAllAlbums];
}

- (IBAction)selectPic:(id)sender {
    [self presentPhotoPickerViewControllerWithStyle:LGShowImageTypeImagePicker];
}
- (IBAction)photoKitBrower:(id)sender {
    SelectPhotoAssetGridViewController *gridVC = [[SelectPhotoAssetGridViewController alloc] init];
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    gridVC.assrtsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
//    gridVC.modalPresentationStyle=UIModalPresentationPopover;
//    
//    UIPopoverPresentationController *popPC = gridVC.popoverPresentationController;
//    popPC.permittedArrowDirections = UIPopoverArrowDirectionAny;
//    [self showViewController:gridVC sender:nil];
    
    UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:gridVC];
    navController.view.frame = self.view.bounds;
//    [self addChildViewController:navController];
//    [self.view addSubview:navController.view];
//    [navController didMoveToParentViewController:self];
    navController.modalPresentationStyle=UIModalPresentationPopover;
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)presentPhotoPickerViewControllerWithStyle:(LGShowImageType)style {
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:style];
    pickerVc.status = PickerViewShowStatusCameraRoll;
//    pickerVc.maxCount = 9;   // 最多能选9张图片,默认为INT_MAX
    pickerVc.delegate = self;
    self.showType = style;
    [pickerVc showPickerVc:self];
}

#pragma mark - LGPhotoPickerViewControllerDelegate

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets isOriginal:(BOOL)original{
    /*
     //assets的元素是LGPhotoAssets对象，获取image方法如下:
     NSMutableArray *thumbImageArray = [NSMutableArray array];
     NSMutableArray *originImage = [NSMutableArray array];
     NSMutableArray *fullResolutionImage = [NSMutableArray array];
     
     for (LGPhotoAssets *photo in assets) {
     //缩略图
     [thumbImageArray addObject:photo.thumbImage];
     //原图
     [originImage addObject:photo.originImage];
     //全屏图
     [fullResolutionImage addObject:fullResolutionImage];
     }
     */
    
    NSInteger num = (long)assets.count;
    NSString *isOriginal = original? @"YES":@"NO";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送图片" message:[NSString stringWithFormat:@"您选择了%ld张图片\n是否原图：%@",(long)num,isOriginal] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)getImageFromIpc
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
}

-(void)getAllAlbums{
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *groupArray;
    assetsLibrary=[[ALAssetsLibrary alloc] init];
    groupArray=[[NSMutableArray alloc] initWithCapacity:1];
    
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [groupArray addObject:group];
            // 通过这个可以知道相册的名字，从而也可以知道安装的部分应用
            //例如 Name:柚子相机, Type:Album, Assets count:1
            NSLog(@"%@",group);
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    NSLog(@"index:%d---%s---%@",index,stop,result);
                }
                //停止遍历
                *stop=YES;
            }];
            
//            [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] options:NSEnumerationConcurrent usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//                if (result) {
//                    NSLog(@"index:%d---%s---%@",index,stop,result);
//                }
//            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
