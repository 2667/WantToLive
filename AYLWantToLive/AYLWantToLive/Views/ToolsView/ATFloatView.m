//
//  ATFloatView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/22.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATFloatView.h"

@interface ATFloatView()

//@property(nonatomic, strong) UITextField *textField;
//@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) id responderView;

@end

@implementation ATFloatView

- (instancetype)initWithFrame:(CGRect)frame keyboardResponder:(id) responder {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.responderView = responder;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        
        [self addGestureRecognizer:tapGesturRecognizer];
    }
    return self;
}

- (void) showFloatView {
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
}

- (void) tapAction {
    if ([self.responderView isKindOfClass:[UITextField class]]) {
        [self.responderView resignFirstResponder];
    }else if ([self.responderView isKindOfClass:[UITextView class]]) {
        [self.responderView resignFirstResponder];
    }
    [self removeFromSuperview];
}

//点击的是view就结束编辑并且返回view本身，这样就不影响了view本身的操作，然后点击的是tableview的子视图的时候就返回子视图就行了。
//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    id view = [super hitTest:point withEvent:event];
//    return view;
//    if (![view isKindOfClass:[UITextField class]]) {
//        [self endEditing:YES];
//        return self;
//    }else {
//        return view;
//    }
//}

@end
