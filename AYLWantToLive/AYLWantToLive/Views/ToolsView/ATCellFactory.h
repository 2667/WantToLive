//
//  ATCellFactory.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/16.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATCellFactory : NSObject

//工厂+反射生产Cell
+ (UITableViewCell *)createCellWithClassName:(NSString *)cellClassName cellModel:(id)cellModels  indexPath:(NSIndexPath *) indexPath;

@end
