//
//  ATCellFactory.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/16.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATCellFactory.h"

@implementation ATCellFactory

+ (UITableViewCell *)createCellWithClassName:(NSString *)cellClassName cellModel:(id)cellModels  indexPath:(NSIndexPath *) indexPath {
    ATRootCell *cell = nil;
//    通过反射来定义cell，当遇到cell拓展时，可以直接用字符串反射
    Class classForCell = NSClassFromString(cellClassName);
    cell = [[classForCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClassName];
    [cell initData:cellModels indexPath:indexPath];
    return cell;
}

@end
