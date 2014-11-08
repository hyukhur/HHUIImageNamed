//
//  NSData+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 11/8/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

#import "NSData+HHFileNamedImage.h"
#import <objc/runtime.h>
#import "UIImage+HHFileNamedImage.h"

@implementation NSData (HHFileNamedImage)

- (instancetype)initWithContentsOfFile_hh:(NSString *)path options:(NSDataReadingOptions)readOptionsMask error:(NSError **)errorPtr
{
    self = [self initWithContentsOfFile_hh:path options:readOptionsMask error:errorPtr];
    if (self) {
        [[[NSThread currentThread] threadDictionary] setObject:[path lastPathComponent] forKey:HHUIImageNamedCandidatedFileName];
    }
    return self;
}

- (instancetype)initWithContentsOfFile_hh:(NSString *)path
{
    self = [self initWithContentsOfFile_hh:path];
    if (self) {
        [[[NSThread currentThread] threadDictionary] setObject:[path lastPathComponent] forKey:HHUIImageNamedCandidatedFileName];
    }
    return self;
}

#pragma mark -

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithContentsOfFile:options:error:)), class_getInstanceMethod(self, @selector(initWithContentsOfFile_hh:options:error:)));
            method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithContentsOfFile:)), class_getInstanceMethod(self, @selector(initWithContentsOfFile_hh:)));
        }
    });
}
@end
