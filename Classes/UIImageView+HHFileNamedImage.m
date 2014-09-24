//
//  UIImageView+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2014. 9. 25..
//  Copyright (c) 2014년 Hyuk Hur. All rights reserved.
//

#import "UIImageView+HHFileNamedImage.h"
#import <objc/runtime.h>

@interface UIImage (HHFileNamedImage)
- (NSString *)hh_fileName;
@end

@implementation UIImageView (HHFileNamedImage)

- (NSString *)hh_description
{
    if (![self image]) {
        return [self hh_description];
    }
    UIImage *image = [self image];
    if (![image respondsToSelector:@selector(hh_fileName)]) {
        return [self hh_description];
    }
    NSString *fileName = [image hh_fileName];
    if (!fileName) {
        return [self hh_description];
    }
    return [NSString stringWithFormat:@"%@, %@", fileName, [self hh_description]];
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
    });
}

@end
