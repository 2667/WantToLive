//
//  ATPickerController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/8.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATPickerController.h"
#import <CoreLocation/CoreLocation.h>

@interface ATPickerController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) CLLocation *location;

@end

@implementation ATPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 拍照
- (void)cameraAction {
    BOOL isCamera = [self checkCameraAuthority];
    if (isCamera) {
        [self pushImagePickerController];
    }
}

#pragma mark - 选择图片
- (void) choosePictureOfNumbers:(NSInteger ) numbers {
//    self.numbers = numbers;
////    目前已经选中的图片数组
//    if (numbers > 1) {
//        self.tzimagePC.selectedAssets = _selectedAssets;
//    }
////    在内部显示拍照按钮
//    self.tzimagePC.allowTakePicture = YES;
//    self.tzimagePC.allowPickingImage = YES;
//    self.tzimagePC.allowPickingOriginalPhoto = YES;
////    照片排列按修改时间升序
//    self.tzimagePC.sortAscendingByModificationDate = YES;
//    self.tzimagePC.showSelectBtn = NO;
////    允许裁剪
//    self.tzimagePC.allowCrop = YES;
////    使用圆形剪裁框
//    self.tzimagePC.needCircleCrop = YES;
//
//    // 设置竖屏下的裁剪尺寸
//    NSInteger left = 30;
//    NSInteger widthHeight = self.view.frame.size.width - 2 * left;
//    NSInteger top = (self.view.frame.size.height - widthHeight) / 2;
//    self.tzimagePC.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
//    self.tzimagePC.statusBarStyle = UIStatusBarStyleLightContent;
    
//    你可以通过block或者代理，来得到用户选择的照片.
//    [self.tzimagePC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        photos = self->_selectedPhotos;
//        assets = self->_selectedAssets;
//        isSelectOriginalPhoto= NO;
//    }];
    
    
//    self.tzimagePC.didFinishPickingPhotosHandle(_selectedPhotos, _selectedAssets, NO);
    
//    [self presentViewController:self.tzimagePC animated:YES completion:nil];
}

/*
 typedef NS_ENUM(NSInteger, AVAuthorizationStatus) {
 AVAuthorizationStatusNotDetermined = 0,    没决定
 AVAuthorizationStatusRestricted    = 1,    家长控制
 AVAuthorizationStatusDenied        = 2,    拒绝
 AVAuthorizationStatusAuthorized    = 3,    允许
 }
 */
//检查相机权限和相册权限
- (BOOL) checkCameraAuthority {
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    //iOS7之前都可以访问相机，iOS7之后访问相机有权限设置
//    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
//        // 无相机权限 做一个友好的提示
//        if (iOS8Later) {
//            [self showAlertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机"];
//        } else {
//            [self showAlertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机"];
//        }
//    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
//        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
//        if (iOS7Later) {
//            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//                if (granted) { //点击允许访问时调用
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self cameraAction];
//                    });
//                }
//            }];
//        } else {
//            [self cameraAction];
//        }
//        // 拍照之前还需要检查相册权限
//    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
//        if (iOS8Later) {
//            [self showAlertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册"];
//        } else {
//            [self showAlertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册"];
//        }
//    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
//        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
//            [self cameraAction];
//        }];
//    } else {
//        return  YES;
//    }
    return FALSE;
}


// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
//    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = [locations firstObject];
//    } failureBlock:^(NSError *error) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = nil;
//    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera; //数据来源于相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
//        if(iOS8Later) {
//            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;  //presented VC的弹出方式和presenting VC的父VC的方式相同
//        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

#pragma mark - UIImagePickerControllerDelegate
//相机获取图片的操作
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];  ////指定用户选择的媒体类型
//    if ([type isEqualToString:@"public.image"]) {
//        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
//        tzImagePickerVc.sortAscendingByModificationDate = NO;
//        [tzImagePickerVc showProgressHUD];
//        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];  //获取原始图片
//
//        // save photo and get asset / 保存图片，获取到asset
//        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
//            if (error) {
//                [tzImagePickerVc hideProgressHUD];
//                NSLog(@"图片保存失败 %@",error);
//            } else {
//                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:NO completion:^(TZAlbumModel *model) {
//                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
//                        [tzImagePickerVc hideProgressHUD];
//                        TZAssetModel *assetModel = [models firstObject];
//                        if (tzImagePickerVc.sortAscendingByModificationDate) {
//                            assetModel = [models lastObject];
//                        }
////                        [self.headView getHeadPortraitFromCameraWithHeadPortrait:image completion:^(UIImage* image) {
////
////                        }];
//                        [self.headView getHeadPortraitFromCameraWithHeadPortrait:image];
//                        [self dismissViewControllerAnimated:FALSE completion:nil];
//
//                    }];
//                }];
//            }
//        }];
//    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:FALSE completion:nil];
    }
}

#pragma mark - UIAlertViewDelegate
//用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
//    [picker dismissViewControllerAnimated:FALSE completion:nil];
//    [self dismissViewControllerAnimated:FALSE completion:nil];
}

//这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
//    [self printAssetsName:assets];
    // 2.图片位置信息
//    if (iOS8Later) {
//        for (PHAsset *phAsset in assets) {
//            NSLog(@"location:%@",phAsset.location);
//        }
//    }
    [self.delegate pickerPhotos:_selectedPhotos assets:_selectedAssets];
    [self dismissViewControllerAnimated:FALSE completion:nil];
}

//决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result {
    return  YES;
}

// 决定asset显示与否
- (BOOL)isAssetCanSelect:(id)asset {
    return YES;
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    UIAlertAction *setting = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    
    [actionSheet addAction:cancle];
    [actionSheet addAction:setting];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}


- (UIImagePickerController *)imagePickerVc {
//    if (_imagePickerVc == nil) {
//        _imagePickerVc = [[UIImagePickerController alloc] init];
//        _imagePickerVc.delegate = self;
//        // set appearance / 改变相册选择页的导航栏外观
//        if (iOS7Later) {
//            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
//        }
//        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
//        UIBarButtonItem *tzBarItem, *BarItem;
//        if (iOS9Later) {
//            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
//            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
//        } else {
//            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
//            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
//        }
//        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
//        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
//
//    }
    return _imagePickerVc;
}

-(TZImagePickerController *)tzimagePC {
//    if (!_tzimagePC) {
//        self.tzimagePC = [[TZImagePickerController alloc] initWithMaxImagesCount:self.numbers columnNumber:4 delegate:self pushPhotoPickerVc:YES];
//        self.tzimagePC.isSelectOriginalPhoto = YES;
//    }
    return _tzimagePC;
}


- (void)dealloc{
    NSLog(@"-------------------------->ATPickerController 内存未泄露");
}
@end
