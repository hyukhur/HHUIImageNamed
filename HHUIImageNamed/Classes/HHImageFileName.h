//
//  HHImageFileName.h
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2018-02-09.
//  Copyright © 2018 Hyuk Hur. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Foundation;
@import UIKit;
@import CoreImage;

@interface CIImage (HHFileNamedImage)
@property(nonatomic, strong) NSString *fileName_hh;
@end

@interface UIImage (HHFileNamedImage)
@property(nonatomic, strong) NSString *fileName_hh;
- (NSString *)description_hh;
@end

@interface UIImageView (HHFileNamedImage)
- (NSString *)description_hh;
@end

@interface HHImageFileName : NSObject
@property(class, strong, nonatomic) NSString *candidatedFileName;
+ (void)swizzleDescriptionMethodForClass:(Class)clazz;
+ (void)swizzleInstanceMethod:(Class)clazz origin:(SEL)originalSelector modified:(SEL)modifiedSelector;
+ (void)swizzleClassMethod:(Class)clazz origin:(SEL)originalSelector modified:(SEL)modifiedSelector;

+ (NSString *)fileNameFromUIImage:(UIImage *)image;
+ (void)setFileName:(NSString *)fileName UIImage:(UIImage *)image;
+ (NSString *)fileNameFromCIImage:(CIImage *)image;
+ (void)setFileName:(NSString *)fileName CIImage:(CIImage *)image;
+ (NSString *)fileNameFromCGImage:(CGImageRef)imageRef;
+ (void)setFileName:(NSString *)fileName CGImage:(CGImageRef)imageRef;
@end
