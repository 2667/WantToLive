//
//  IndexHeardView.m
//  AYLWantToLive
//
//  Created by AYLiOS on 2018/12/24.
//  Copyright © 2018 AYLiOS. All rights reserved.
//

#import "IndexHeardView.h"

@interface IndexHeardView()

@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation IndexHeardView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"IndexHeardView" owner:self options:nil];
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self.contentView setFrame:self.bounds];
    
    [self addSubview:self.contentView];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}


- (IBAction)zheng:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectJumpPage:)]) {
        [self.delegate selectJumpPage:0];
    }
}


- (IBAction)he:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectJumpPage:)]) {
        [self.delegate selectJumpPage:1];
    }
}

@end
