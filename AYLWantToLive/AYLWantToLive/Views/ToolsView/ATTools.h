//
//  ATTools.h
//  AnnTenants
//
//  Created by HuangGang on 2018/3/13.
//  Copyright © 2018年 Harely. All rights reserved.
//沙盒路径存储：http://www.mamicode.com/info-detail-1787530.html

#import <Foundation/Foundation.h>

@interface ATTools : NSObject

#pragma mark -获取类的所有属性
+ (id)getProperties:(id)cls;
#pragma mark - 给model属性赋值
+(id)setValueForClass:(Class)cls withDictionary:(NSDictionary *)dic;

#pragma mark - 创造UUID
+ (NSString *) createUniqueUUID;
#pragma mark - SHA1加密
+ (NSString *)getSha1String:(NSString *)srcString;

#pragma mark - 16进制颜色转化
+ (UIColor *)colorWithHexString:(NSString *)color;

#pragma mark - 获取时间戳
+ (NSString *)currentTimestamp:(NSUInteger) secondType;
#pragma mark - 获得未来7天时间
+ (NSMutableArray *)getWeekDayFordate;

#pragma mark - 文件处理
//创建目录
+ (NSString *) createFileDirectory:(NSString *) directoryname;
//获取存储文件路径
+ (NSString *)storageDocumentPathForName:(NSString *)name;
//归档路径
+ (NSString *) arhciverPath;
//获得沙盒图片绝对路径
+ (NSString *) unarchiveImageDirectory:(NSString *)directory;

#pragma mark - 图片处理


/**
 图片写入指定目录

 @param saveImage 图片
 @param imageDirectory 图片目录名称
 @param imageName 图片名字
 @param ratio 图片压缩率
 @return 返回图片相对于沙盒的路径
 */
+ (NSString *) saveImage:(UIImage *)saveImage imageDirectory:(NSString *) imageDirectory  imageName:(NSString *)imageName imageCompressionRatio:(CGFloat) ratio;
//读取图片
+ (UIImage *) readPictureFromAbsolutePath:(NSString *) picturePath;
//图片放入文件夹中
+ (NSString *)saveImageWithName:(NSString *)name withImage:(UIImage *) currentImage;
//删除图片
+ (BOOL) deleteImageWith:(NSString *)path;
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

#pragma mark - 判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;
@end
