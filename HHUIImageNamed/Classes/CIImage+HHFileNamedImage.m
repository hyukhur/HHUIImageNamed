//
//  CIImage+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 11/7/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

#import "CIImage+HHFileNamedImage.h"
#import <objc/runtime.h>
#import "PrivateAPI.h"

@implementation CIImage (HHFileNamedImage)

- (NSString *)fileName_hh
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFileName_hh:(NSString *)fileName_hh
{
    objc_setAssociatedObject(self, @selector(fileName_hh), fileName_hh, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (id)initWithContentsOfURL_hh:(NSURL *)url options:(NSDictionary *)d
{
    self = [self initWithContentsOfURL_hh:url options:d];
    if (self) {
        [self setFileName_hh:[url lastPathComponent]];
    }
    return self;
}

#pragma mark -

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleDescriptionMethodForClass([self class]);
        {
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithContentsOfURL:options:)), class_getInstanceMethod(self, @selector(initWithContentsOfURL_hh:options:)));
        }
    });
}
@end
