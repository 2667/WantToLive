//
//  IndexHeardView.h
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/24.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  IndexHeardViewDelegate;

@interface IndexHeardView : UIView

@property(nonatomic, weak)id<IndexHeardViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END

@protocol IndexHeardViewDelegate <NSObject>
@optional

-(void)selectJumpPage:(NSInteger)type;
@end
