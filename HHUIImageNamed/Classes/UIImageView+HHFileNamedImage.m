//
//  UIImageView+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2014. 9. 25..
//  Copyright (c) 2014년 Hyuk Hur. All rights reserved.
//

#import "UIImageView+HHFileNamedImage.h"
#import "HHImageFileName.h"

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
        [HHImageFileName swizzleDescriptionMethodForClass:self];
    });
}

@end
