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
- (NSString *)fileName_hh;
@end

@implementation UIImageView (HHFileNamedImage)

- (NSString *)description_hh
{
    if (![self image]) {
        return [self description_hh];
    }
    UIImage *image = [self image];
    if (![image respondsToSelector:@selector(fileName_hh)]) {
        return [self description_hh];
    }
    NSString *fileName = [image fileName_hh];
    if (!fileName) {
        return [self description_hh];
    }
    return [NSString stringWithFormat:@"%@, %@", fileName, [self description_hh]];
}

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
    });
}

@end
