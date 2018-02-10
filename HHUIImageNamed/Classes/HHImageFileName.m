//
//  HHImageFileName.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2018-02-09.
//  Copyright © 2018 Hyuk Hur. All rights reserved.
//

@import UIKit;
#import <objc/runtime.h>
#import "HHImageFileName.h"
#import "HHImageFileName+Private.h"

@interface HHImageFileName()
@end

const NSString *HHUIImageNamedCandidatedFileName = @"HHUIImageNamedCandidatedFileName";

@implementation HHImageFileName

+ (NSString *)candidatedFileName
{
    return [[[NSThread currentThread] threadDictionary] objectForKey:HHUIImageNamedCandidatedFileName];
}

+ (void)setCandidatedFileName:(NSString *)candidatedFileName
{
    if (candidatedFileName) {
        [[[NSThread currentThread] threadDictionary] setObject:candidatedFileName forKey:HHUIImageNamedCandidatedFileName];
    } else {
        [[[NSThread currentThread] threadDictionary] removeObjectForKey:HHUIImageNamedCandidatedFileName];
    }
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleUIImageNibPlaceholder_initWithCoder];
        [self swizzleCGImageClasses];
    });
}

+ (void)swizzleDescriptionMethodForClass:(Class) clazz
{
    SEL originalSelector = @selector(description);
    SEL swizzledSelector = @selector(description_hh);
    {
        Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector);

        BOOL didAddMethod = class_addMethod(clazz, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(clazz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}

+ (void)swizzleInstanceMethod:(Class)clazz origin:(SEL)originalSelector modified:(SEL)modifiedSelector
{
    method_exchangeImplementations(class_getInstanceMethod(clazz, originalSelector), class_getInstanceMethod(clazz, modifiedSelector));
}

+ (void)swizzleClassMethod:(Class)clazz origin:(SEL)originalSelector modified:(SEL)modifiedSelector
{
    method_exchangeImplementations(class_getClassMethod(clazz, originalSelector), class_getClassMethod(clazz, modifiedSelector));
}

+ (NSString *)fileNameFromUIImage:(UIImage *)image
{
    return objc_getAssociatedObject(image, _cmd);
}

+ (void)setFileName:(NSString *)fileName UIImage:(UIImage *)image
{
    objc_setAssociatedObject(image, @selector(fileNameFromUIImage:), fileName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSString *)fileNameFromCIImage:(CIImage *)image
{
    return objc_getAssociatedObject(image, _cmd);
}

+ (void)setFileName:(NSString *)fileName CIImage:(CIImage *)image
{
    objc_setAssociatedObject(image, @selector(fileNameFromCIImage:), fileName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSString *)fileNameFromCGImage:(CGImageRef)imageRef
{
    return objc_getAssociatedObject((__bridge id _Nonnull)(imageRef), _cmd);
}

+ (void)setFileName:(NSString *)fileName CGImage:(CGImageRef)imageRef
{
    objc_setAssociatedObject((__bridge id _Nonnull)(imageRef), @selector(fileNameFromCGImage:), fileName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
