//
//  UIImage+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2014. 9. 24..
//  Copyright (c) 2014년 Hyuk Hur. All rights reserved.
//

#import "UIImage+HHFileNamedImage.h"
#import <objc/runtime.h>
#import "HHImageFileName.h"

@implementation UIImage (HHFileNamedImage)
#pragma mark -

- (NSString *)fileName_hh
{
    return [[HHImageFileName fileNameFromUIImage:self] description];
}

- (void)setFileName_hh:(NSString *)fileName_hh
{
    objc_setAssociatedObject(self, @selector(isGuessing_hh), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @selector(fileNameCache_hh), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [HHImageFileName setFileName:fileName_hh UIImage:self];
    [HHImageFileName setCandidatedFileName:nil];
}

- (NSString *)fileNameCache_hh
{
    return [objc_getAssociatedObject(self, _cmd) description];
}

- (void)setFileNameCache_hh:(NSString *)fileNameCache_hh
{
    objc_setAssociatedObject(self, @selector(fileNameCache_hh), fileNameCache_hh, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isGuessing_hh
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsGuessing_hh:(BOOL)isGuessing
{
    objc_setAssociatedObject(self, @selector(isGuessing_hh), @(isGuessing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)description_hh
{
    if ([self respondsToSelector:@selector(fileNameCache_hh)]) {
        NSString *cache = [self fileNameCache_hh];
        if (cache) {
            return cache;
        }
    }
    if (![self respondsToSelector:@selector(fileName_hh)]) {
        return [self description_hh];
    }
    NSString *fileName = [self fileName_hh];
    if (!fileName) {
        return [self description_hh];
    }
    BOOL isGuessing = [self isGuessing_hh];
    NSString *result = [NSString stringWithFormat:@"%@%@, %@", isGuessing ? @"Guessing - " : @"", fileName, [self description_hh]];
    [self setFileNameCache_hh:result];
    return result;
}

@end

@implementation UIImage (HHFileNamedImage_Hook)

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
    CGImageRef imageRef = [self CGImage_hh];
    if ([self fileName_hh]) {
        [HHImageFileName setFileName:[self fileName_hh] CGImage:imageRef];
        [HHImageFileName setCandidatedFileName:[self fileName_hh]];
    }
    return imageRef;
}

- (CIImage *)CIImage_hh
{
    CIImage *image = [self CIImage_hh];
    NSString *fileName = [self fileName_hh];
    if (fileName) {
        [image setFileName_hh:[self fileName_hh]];
    }
    return image;
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
        NSString *fileName = [HHImageFileName candidatedFileName];
        if (fileName) {
            [self setFileName_hh:fileName];
            [self setIsGuessing_hh:YES];
        }
    }
    return self;
}

- (instancetype)initWithCGImage_hh:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    self = [self initWithCGImage_hh:cgImage scale:scale orientation:orientation];
    if (self) {
        NSString *fileName = [HHImageFileName fileNameFromCGImage:cgImage];
        if (fileName) {
            [self setFileName_hh:fileName];
            return self;
        }
        if (fileName == nil) {
            fileName = [HHImageFileName candidatedFileName];
            if (fileName) {
                [self setFileName_hh:fileName];
                [self setIsGuessing_hh:YES];
            }
        }
    }
    return self;
}

- (instancetype)initWithCIImage_hh:(CIImage *)ciImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    self = [self initWithCIImage_hh:ciImage scale:scale orientation:orientation];
    if (self) {
        NSString *fileName = [HHImageFileName fileNameFromCIImage:ciImage];
        if (fileName) {
            [self setFileName_hh:fileName];
        } else {
            fileName = [HHImageFileName candidatedFileName];
            if (fileName) {
                [self setFileName_hh:fileName];
                [self setIsGuessing_hh:YES];
            }
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
        [HHImageFileName swizzleDescriptionMethodForClass:[self class]];
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(resizableImageWithCapInsets:) modified:@selector(resizableImageWithCapInsets_hh:)];
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(resizableImageWithCapInsets:resizingMode:) modified:@selector(resizableImageWithCapInsets_hh:resizingMode:)];
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(imageWithAlignmentRectInsets:) modified:@selector(imageWithAlignmentRectInsets_hh:)];
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(stretchableImageWithLeftCapWidth:topCapHeight:) modified:@selector(stretchableImageWithLeftCapWidth_hh:topCapHeight:)];
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(CGImage) modified:@selector(CGImage_hh)];
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(CIImage) modified:@selector(CIImage_hh)];

        [HHImageFileName swizzleInstanceMethod:self origin:@selector(initWithContentsOfFile:) modified:@selector(initWithContentsOfFile_hh:)];
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(initWithData:) modified:@selector(initWithData_hh:)];
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(initWithCGImage:scale:orientation:) modified:@selector(initWithCGImage_hh:scale:orientation:)];
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(initWithCIImage:scale:orientation:) modified:@selector(initWithCIImage_hh:scale:orientation:)];

        [HHImageFileName swizzleClassMethod:self origin:@selector(animatedImageNamed:duration:) modified:@selector(animatedImageNamed_hh:duration:)];
        [HHImageFileName swizzleClassMethod:self origin:@selector(animatedResizableImageNamed:capInsets:duration:) modified:@selector(animatedResizableImageNamed_hh:capInsets:duration:)];
        [HHImageFileName swizzleClassMethod:self origin:@selector(animatedResizableImageNamed:capInsets:resizingMode:duration:) modified:@selector(animatedResizableImageNamed_hh:capInsets:resizingMode:duration:)];
        [HHImageFileName swizzleClassMethod:self origin:@selector(animatedImageWithImages:duration:) modified:@selector(animatedImageWithImages_hh:duration:)];
        [HHImageFileName swizzleClassMethod:self origin:@selector(imageNamed:) modified:@selector(imageNamed_hh:)];
    });
}

@end
