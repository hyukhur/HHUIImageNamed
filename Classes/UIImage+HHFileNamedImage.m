//
//  UIImage+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2014. 9. 24..
//  Copyright (c) 2014년 Hyuk Hur. All rights reserved.
//

#import "UIImage+HHFileNamedImage.h"
#import <objc/runtime.h>

void methodExchange(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation UIImage (HHFileNamedImage)

- (NSString *)hh_fileName
{
    return objc_getAssociatedObject(self, _cmd);
}


- (void)hh_setFileName:(NSString *)hh_fileName
{
    objc_setAssociatedObject(self, @selector(hh_fileName), hh_fileName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSUInteger)hh_callCount
{
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}


- (void)hh_setCallCount:(NSUInteger)hh_callCount
{
    objc_setAssociatedObject(self, @selector(hh_callCount), @(hh_callCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)hh_description
{
    if (![self respondsToSelector:@selector(hh_fileName)]) {
        return [self hh_description];
    }
    NSString *fileName = [self hh_fileName];
    NSUInteger callCount = [self hh_callCount];
    if (!fileName || callCount) {
        return [self hh_description];
    }
    [self hh_setCallCount:callCount++];
    return [NSString stringWithFormat:@"%@, %@", fileName, [self hh_description]];
}

/*
 initWithContentsOfFile
 */
- (instancetype)initWithContentsOfFile_hh:(NSString *)path
{
    self = [self initWithContentsOfFile_hh:path];
    if (self) {
        [self hh_setFileName:[path lastPathComponent]];
    }
    return self;
}

+ (UIImage *)imageNamed_hh:(NSString *)name
{
    UIImage *image = [self imageNamed_hh:name];
    [image hh_setFileName:name];
    return image;
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        methodExchange(class, @selector(description), @selector(hh_description));
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithContentsOfFile:)), class_getInstanceMethod(self, @selector(initWithContentsOfFile_hh:)));
        method_exchangeImplementations(class_getClassMethod(self, @selector(imageNamed:)), class_getClassMethod(self, @selector(imageNamed_hh:)));
    });
}

@end
