//
//  UIImage+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2014. 9. 24..
//  Copyright (c) 2014년 Hyuk Hur. All rights reserved.
//

#import "UIImage+HHFileNamedImage.h"
#import <objc/runtime.h>


@implementation UIImage (HHFileNamedImage)

- (NSString *)hh_fileName
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)hh_setFileName:(NSString *)hh_fileName
{
    objc_setAssociatedObject(self, @selector(hh_fileName), hh_fileName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)hh_description
{
    if (![self respondsToSelector:@selector(hh_fileName)]) {
        return [self hh_description];
    }
    NSString *fileName = [self hh_fileName];
    if (!fileName) {
        return [self hh_description];
    }
    return [NSString stringWithFormat:@"%@, %@", fileName, [self hh_description]];
}

- (CGImageRef)CGImage_hh
{
    [[NSThread currentThread] ]
    return [self CGImage_hh];
}

- (CIImage *)CIImage_hh
{
    return [self CIImage_hh];
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

- (instancetype)initWithData_hh:(NSData *)data
{
    self = [self initWithData_hh:data];
    if (self) {
//        [self hh_setFileName:[path lastPathComponent]];
    }
    return self;
}

- (instancetype)initWithCGImage_hh:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    self = [self initWithCGImage_hh:cgImage scale:scale orientation:orientation];
    if (self) {
//        [self hh_setFileName:[path lastPathComponent]];
    }
    return self;
}

- (instancetype)initWithCIImage_hh:(CIImage *)ciImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    self = [self initWithCIImage_hh:ciImage scale:scale orientation:orientation];
    if (self) {
//        [self hh_setFileName:[path lastPathComponent]];
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
        SEL originalSelector = @selector(description);
        SEL swizzledSelector = @selector(hh_description);
        {
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(CGImage_hh)),            class_getInstanceMethod(self, @selector(CGImage_hh)));
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(CIImage_hh)),            class_getInstanceMethod(self, @selector(CIImage_hh)));

        method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithContentsOfFile:)),            class_getInstanceMethod(self, @selector(initWithContentsOfFile_hh:)));
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithData:)),                      class_getInstanceMethod(self, @selector(initWithData_hh:)));
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithCGImage:scale:orientation:)), class_getInstanceMethod(self, @selector(initWithCGImage_hh:scale:orientation:)));
        method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithCIImage:scale:orientation:)), class_getInstanceMethod(self, @selector(initWithCIImage_hh:scale:orientation:)));
        method_exchangeImplementations(class_getClassMethod(self, @selector(imageNamed:)), class_getClassMethod(self, @selector(imageNamed_hh:)));
    });
}

@end
