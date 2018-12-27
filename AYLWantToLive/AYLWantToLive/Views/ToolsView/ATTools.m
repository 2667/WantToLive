//
//  ATTools.m
//  AnnTenants
//
//  Created by HuangGang on 2018/3/13.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ATTools

//获取类的所有属性
+ (id)getProperties:(id)cls{
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList(object_getClass(cls), &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    
    return mArray;
}


+ (NSString *) createUniqueUUID {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

//SHA1加密
+ (NSString *)getSha1String:(NSString *)srcString {
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
 
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
 
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];

    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//创建目录
+ (NSString *) createFileDirectory:(NSString *) directoryname {
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString * path = [paths[0]stringByAppendingPathComponent:directoryname];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){//推断createPath路径目录是否已存在。此处createPath为须要新建的目录的绝对路径
        
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];//创建目录
    }
    return  [NSString stringWithFormat:@"/%@", directoryname];
}


+ (NSString *) saveImage:(UIImage *)saveImage imageDirectory:(NSString *) imageDirectory  imageName:(NSString *)imageName imageCompressionRatio:(CGFloat) ratio {
    if ([ATTools isBlankString:imageDirectory]) {
        imageDirectory = @"";
    }
    if ([ATTools isBlankString:imageName]) {
        imageName = @"";
    }
    NSString *directory = [ATTools createFileDirectory:imageDirectory];
    
//    时间精确到纳秒
    NSString *timestamp = [ATTools currentTimestamp:1000*1000];
    NSString *name = [NSString stringWithFormat:@"%@/AnnTenants%@%@", directory,timestamp,imageName];
    NSString *absolutePath = [NSString stringWithFormat:@"%@%@",ATDocumentPath, name];
    
    NSData *imageData = UIImageJPEGRepresentation(saveImage, ratio);
//    atomically：这个参数意思是如果为YES则保证文件的写入原子性,就是说会先创建一个临时文件,直到文件内容写入成功再导入到目标文件里.
    BOOL isWrite = [imageData writeToFile:absolutePath atomically:NO];
    if (!isWrite) {
        ATLog(@"图片未写入成功");
    }
    NSLog(@"-------------->图片写入路径：%@", absolutePath);
    return name;
}

+ (UIImage *) readPictureFromAbsolutePath:(NSString *) picturePath {
    NSString *absoluteImagePath = [NSString stringWithFormat:@"%@%@", ATDocumentPath, picturePath];
    UIImage *picture = [UIImage imageWithContentsOfFile:absoluteImagePath];
    return picture;
}

//获取当前时间戳
+ (NSString *)currentTimestamp:(NSUInteger) secondType{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time = 0.0;
    if (secondType < 1000 ) {
        time=[date timeIntervalSince1970];  //秒
    }else if (secondType >= 1000 && secondType < 1000*1000 ) {
        time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    }else {
        time=[date timeIntervalSince1970]*1000*1000; //纳秒
    }
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

//获得未来7天时间
+ (NSMutableArray *)getWeekDayFordate
{
    NSDictionary *digitDic = @{@-1:@"日", @0:@"一", @1:@"二", @2:@"三", @3:@"四", @4:@"五", @5:@"六"};
    NSMutableArray *dates = [NSMutableArray array];
    
    //    指定日历的算法，这里按公历来算
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //    在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //    时间容器，一个包含了详细的年月日时分秒的容器
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //    获取指定日期的年、月、日、星期、时、分、秒
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    for (int i = 0; i< 7; i ++) {
        NSTimeInterval calculateDate = 24 * 60 *60 *i;
        //    现在时间
        NSDate *now = [[NSDate alloc] initWithTimeIntervalSinceNow:calculateDate];
        comps = [calendar components:unitFlags fromDate:now];
        NSString *dateStr = [NSString stringWithFormat:@"%ld月%ld日 周%@", (long)comps.month, (long)comps.day, digitDic[@(comps.weekday-2)]];
        [dates addObject:dateStr];
    }
    return dates;
}


+ (NSString *)saveImageWithName:(NSString *)name withImage:(UIImage *) currentImage {
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.8);
    NSString *imageName = [NSString stringWithFormat:@"/ATPicture_%0.f.png", [[NSDate date] timeIntervalSince1970]];
    NSString *imagePath = [NSString stringWithFormat:@"%@%@",ATDocumentPath,imageName];
    BOOL isWrite = [imageData writeToFile:imagePath atomically:NO];
    if (!isWrite) {
        ATLog(@"图片未写入成功");
    }
    return imageName;
}

+ (BOOL) deleteImageWith:(NSString *)path {
    NSString *picturePath = [NSString stringWithFormat:@"%@%@", ATDocumentPath, path];
    if([[NSFileManager defaultManager] fileExistsAtPath: picturePath])//假设存在暂时文件的配置文件
    {
        return  [[NSFileManager defaultManager]  removeItemAtPath: picturePath error:nil];
    }else {
        ATLog(@"删除图片失败");
        return NO;
    }
}


/**
 获得图片路径

 @param directory 图片目录
 @return 图片沙盒绝对值路径
 */
+ (NSString *) unarchiveImageDirectory:(NSString *)directory {
    ATMyHeadModel * headM = nil;
    NSString *unPath = [ATUserManager filePath];

    WZLSERIALIZE_UNARCHIVE(headM, @"ATMyHeadModel", unPath);
    if (headM.avatarPath == nil) {
        return nil;
    }else {
        NSString *imagePath = [NSString stringWithFormat:@"%@%@", ATDocumentPath, headM.avatarPath];
        
        return imagePath;
    }
}

+ (NSString *)storageDocumentPathForName:(NSString *)name {
    NSString *applications = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES).firstObject;
    //    查找字符串
    NSRange range = [applications rangeOfString:@"Application/"];
    //    截取从第n+1位开始截取,至字符串最后
    NSString *replace =  [applications substringFromIndex:(range.location + range.length)];
    NSString *documentPath = [applications stringByReplacingOccurrencesOfString:replace withString: name];
    
    return documentPath;
}

+ (NSString *) arhciverPath {
    NSString *archiverPath = [ATTools storageDocumentPathForName:@"archiver"];
    return archiverPath;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return  YES;
    }
    if (string.length == 0 ) {
        return YES;
    }
    return NO;
}

//给model属性赋值  问题：有些值不能进行赋值为空
+(id)setValueForClass:(Class)cls withDictionary:(NSDictionary *)dic
{
    id model = [[cls alloc] init];
    if (model)
    {
        unsigned int count = 0;
        //获取类的属性列表
        Ivar *ivars = class_copyIvarList(cls, &count);
        //给属性赋值
        for (int i = 0; i<count; i++)
        {
            Ivar ivar = ivars[i];
            //获取变量名称
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            //生成setter方法
            NSString *usefullStr = [key substringFromIndex:1];          //跳过下划线
            key = usefullStr.capitalizedString;                         //大写首字母
            key = [NSString stringWithFormat:@"set%@:", key];           //拼接set方法字符串
            SEL setSel = NSSelectorFromString(key);
            //调用setter方法
            if ([model respondsToSelector:setSel])
            {
                id value = @"";
                if ([dic objectForKey:usefullStr]!=nil) {
                    value = [dic objectForKey:usefullStr];
                }
                [model performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
            }
        }
        free(ivars);
    }
    return model;
}

@end
