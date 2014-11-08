//
//  CIImage+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 11/7/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

#import "CIImage+HHFileNamedImage.h"
#import <objc/runtime.h>
#import "UIImage+HHFileNamedImage.h"


@implementation CIImage (HHFileNamedImage)

- (id)initWithContentsOfURL_hh:(NSURL *)url options:(NSDictionary *)d
{
    self = [self initWithContentsOfURL_hh:url options:d];
    if (self) {
        [[[NSThread currentThread] threadDictionary] setObject:[url lastPathComponent] forKey:HHUIImageNamedCandidatedFileName];
    }
    return self;
}

#pragma mark -

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithContentsOfURL:options:)), class_getInstanceMethod(self, @selector(initWithContentsOfURL_hh:options:)));
        }
    });
}
@end
