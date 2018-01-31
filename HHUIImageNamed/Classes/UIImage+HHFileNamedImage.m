//
//  UIImage+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2014. 9. 24..
//  Copyright (c) 2014년 Hyuk Hur. All rights reserved.
//

#import "UIImage+HHFileNamedImage.h"
#import <objc/runtime.h>

NSString *HHUIImageNamedCandidatedFileName = @"HHUIImageNamedCandidatedFileName";

@implementation UIImage (HHFileNamedImage)

#pragma mark -

- (NSString *)fileName_hh
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFileName_hh:(NSString *)fileName_hh
{
    objc_setAssociatedObject(self, @selector(fileName_hh), fileName_hh, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[[NSThread currentThread] threadDictionary] removeObjectForKey:HHUIImageNamedCandidatedFileName];
}

- (NSString *)description_hh
{
    if (![self respondsToSelector:@selector(fileName_hh)]) {
        return [self description_hh];
    }
    NSString *fileName = [self fileName_hh];
    if (!fileName) {
        return [self description_hh];
    }
    return [NSString stringWithFormat:@"%@, %@", fileName, [self description_hh]];
}

#pragma mark - 

- (UIImage *)resizableImageWithCapInsets_hh:(UIEdgeInsets)capInsets
{
    UIImage *result = [self resizableImageWithCapInsets_hh:capInsets];
    if ([self fileName_hh]) {
        [result setFileName_hh:[self fileName_hh]];
    }
    return result;
}

- (UIImage *)resizableImageWithCapInsets_hh:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode
{
    UIImage *result = [self resizableImageWithCapInsets_hh:capInsets resizingMode:resizingMode];
    if ([self fileName_hh]) {
        [result setFileName_hh:[self fileName_hh]];
    }
    return result;
}

- (UIImage *)imageWithAlignmentRectInsets_hh:(UIEdgeInsets)alignmentInsets
{
    UIImage *result = [self imageWithAlignmentRectInsets_hh:alignmentInsets];
    if ([self fileName_hh]) {
        [result setFileName_hh:[self fileName_hh]];
    }
    return result;
}

- (UIImage *)imageWithRenderingMode_hh:(UIImageRenderingMode)renderingMode
{
    UIImage *result = [self imageWithRenderingMode_hh:renderingMode];
    if ([self fileName_hh]) {
        [result setFileName_hh:[self fileName_hh]];
    }
    return result;
}

- (UIImage *)stretchableImageWithLeftCapWidth_hh:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight
{
    UIImage *result = [self stretchableImageWithLeftCapWidth_hh:leftCapWidth topCapHeight:topCapHeight];
    if ([self fileName_hh]) {
        [result setFileName_hh:[self fileName_hh]];
    }
    return result;
}

- (CGImageRef)CGImage_hh
{
    if ([self fileName_hh]) {
        [[[NSThread currentThread] threadDictionary] setObject:[self fileName_hh] forKey:HHUIImageNamedCandidatedFileName];
    }
    return [self CGImage_hh];
}

- (CIImage *)CIImage_hh
{
    if ([self fileName_hh]) {
        [[[NSThread currentThread] threadDictionary] setObject:[self fileName_hh] forKey:HHUIImageNamedCandidatedFileName];
    }
    return [self CIImage_hh];
}

/*
 initWithContentsOfFile
 */
- (instancetype)initWithContentsOfFile_hh:(NSString *)path
{
    self = [self initWithContentsOfFile_hh:path];
    if (self) {
        [self setFileName_hh:[path lastPathComponent]];
    }
    return self;
}

- (instancetype)initWithData_hh:(NSData *)data
{
    self = [self initWithData_hh:data];
    if (self) {
        NSString *fileName = [[[NSThread currentThread] threadDictionary] objectForKey:HHUIImageNamedCandidatedFileName];
        if (fileName) {
            [self setFileName_hh:fileName];
        }
    }
    return self;
}

- (instancetype)initWithCGImage_hh:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    self = [self initWithCGImage_hh:cgImage scale:scale orientation:orientation];
    if (self) {
        NSString *fileName = [[[NSThread currentThread] threadDictionary] objectForKey:HHUIImageNamedCandidatedFileName];
        if (fileName) {
            [self setFileName_hh:fileName];
        }
    }
    return self;
}

- (instancetype)initWithCIImage_hh:(CIImage *)ciImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    self = [self initWithCIImage_hh:ciImage scale:scale orientation:orientation];
    if (self) {
        NSString *fileName = [[[NSThread currentThread] threadDictionary] objectForKey:HHUIImageNamedCandidatedFileName];
        if (fileName) {
            [self setFileName_hh:fileName];
        }
    }
    return self;
}

#pragma mark -

+ (UIImage *)animatedImageNamed_hh:(NSString *)name duration:(NSTimeInterval)duration
{
    UIImage *result = [self animatedImageNamed_hh:name duration:duration];
    [result setFileName_hh:name];
    return result;
}

+ (UIImage *)animatedResizableImageNamed_hh:(NSString *)name capInsets:(UIEdgeInsets)capInsets duration:(NSTimeInterval)duration
{
    UIImage *result = [self animatedResizableImageNamed_hh:name capInsets:capInsets duration:duration];
    [result setFileName_hh:name];
    return result;
}

+ (UIImage *)animatedResizableImageNamed_hh:(NSString *)name capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode duration:(NSTimeInterval)duration
{
    UIImage *result = [self animatedResizableImageNamed_hh:name capInsets:capInsets resizingMode:resizingMode duration:duration];
    [result setFileName_hh:name];
    return result;
}

+ (UIImage *)animatedImageWithImages_hh:(NSArray *)images duration:(NSTimeInterval)duration
{
    UIImage *result = [self animatedImageWithImages_hh:images duration:duration];
    if (result) {
        NSMutableArray *names = [NSMutableArray arrayWithCapacity:[images count]];
        [images enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL *stop) {
            if ([obj respondsToSelector:@selector(fileName_hh)]) {
                [names addObject:[obj fileName_hh]?:@""];
            }
        }];
        [result setFileName_hh:[names componentsJoinedByString:@", "]];
    }
    return result;
}

+ (UIImage *)imageNamed_hh:(NSString *)name
{
    UIImage *image = [self imageNamed_hh:name];
    [image setFileName_hh:name];
    return image;
}

#pragma mark - 

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(description);
        SEL swizzledSelector = @selector(description_hh);
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
        {
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(resizableImageWithCapInsets:)), class_getInstanceMethod(self, @selector(resizableImageWithCapInsets_hh:)));
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(resizableImageWithCapInsets:resizingMode:)), class_getInstanceMethod(self, @selector(resizableImageWithCapInsets_hh:resizingMode:)));
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(imageWithAlignmentRectInsets:)), class_getInstanceMethod(self, @selector(imageWithAlignmentRectInsets_hh:)));
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(imageWithRenderingMode:)), class_getInstanceMethod(self, @selector(imageWithRenderingMode_hh:)));
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(stretchableImageWithLeftCapWidth:topCapHeight:)), class_getInstanceMethod(self, @selector(stretchableImageWithLeftCapWidth_hh:topCapHeight:)));

            method_exchangeImplementations(class_getInstanceMethod(self, @selector(CGImage)), class_getInstanceMethod(self, @selector(CGImage_hh)));
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(CIImage)), class_getInstanceMethod(self, @selector(CIImage_hh)));
        }
        {
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithContentsOfFile:)), class_getInstanceMethod(self, @selector(initWithContentsOfFile_hh:)));
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithData:)), class_getInstanceMethod(self, @selector(initWithData_hh:)));
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithCGImage:scale:orientation:)), class_getInstanceMethod(self, @selector(initWithCGImage_hh:scale:orientation:)));
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithCIImage:scale:orientation:)), class_getInstanceMethod(self, @selector(initWithCIImage_hh:scale:orientation:)));
        }
        {
            method_exchangeImplementations(class_getClassMethod(self, @selector(animatedImageNamed:duration:)), class_getClassMethod(self, @selector(animatedImageNamed_hh:duration:)));
            method_exchangeImplementations(class_getClassMethod(self, @selector(animatedResizableImageNamed:capInsets:duration:)), class_getClassMethod(self, @selector(animatedResizableImageNamed_hh:capInsets:duration:)));
            method_exchangeImplementations(class_getClassMethod(self, @selector(animatedResizableImageNamed:capInsets:resizingMode:duration:)), class_getClassMethod(self, @selector(animatedResizableImageNamed_hh:capInsets:resizingMode:duration:)));
            method_exchangeImplementations(class_getClassMethod(self, @selector(animatedImageWithImages:duration:)), class_getClassMethod(self, @selector(animatedImageWithImages_hh:duration:)));
            method_exchangeImplementations(class_getClassMethod(self, @selector(imageNamed:)), class_getClassMethod(self, @selector(imageNamed_hh:)));
        }
    });
}

@end



@interface UIImageNibPlaceholder : UIImage <NSCoding>
@end

NSString *HHUIImageNibPlaceholderUIResourceName = @"UIResourceName";

@implementation UIImageNibPlaceholder (HHFileNamedImage)

- (instancetype)initWithCoder_hh:(NSCoder *)aDecoder
{
    self = [self initWithCoder_hh:aDecoder];
    if (self) {
        NSString *imageName = [aDecoder decodeObjectForKey:HHUIImageNibPlaceholderUIResourceName];
        if ([imageName isKindOfClass:[NSString class]]) {
            [self setFileName_hh:imageName];
        }
    }
    return self;
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithCoder:)), class_getInstanceMethod(self, @selector(initWithCoder_hh:)));
        }
    });
}
@end
