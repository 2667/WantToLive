//
//  ATPickerController.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/8.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATMyHeadView,TZImagePickerController;

@protocol ImagePickerDelegate<NSObject>

@optional
- (void) pickerPhotos:(NSMutableArray *)arrayPhotos assets:(NSMutableArray *)arrayAssets;

@end

@interface ATPickerController : UIViewController
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
}
@property(nonatomic, strong) ATMyHeadView* headView;
@property(nonatomic, strong) TZImagePickerController *tzimagePC;
@property(nonatomic, weak) id <ImagePickerDelegate>delegate;
@property (nonatomic, assign) NSInteger numbers;



- (void)cameraAction;
- (void) choosePictureOfNumbers:(NSInteger ) numbers;
//- (void) useCameraPicture:(UIImage *)picture addAssert:(id) asset completion:(void (^)(void))completion;

@end
