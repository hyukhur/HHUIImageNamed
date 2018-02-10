//
//  NSData+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 11/8/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

#import "NSData+HHFileNamedImage.h"
#import "HHImageFileName.h"

@implementation NSData (HHFileNamedImage)

- (instancetype)initWithContentsOfFile_hh:(NSString *)path options:(NSDataReadingOptions)readOptionsMask error:(NSError **)errorPtr
{
    self = [self initWithContentsOfFile_hh:path options:readOptionsMask error:errorPtr];
    if (self) {
        [HHImageFileName setCandidatedFileName:[path lastPathComponent]];
    }
    return self;
}

- (instancetype)initWithContentsOfFile_hh:(NSString *)path
{
    self = [self initWithContentsOfFile_hh:path];
    if (self) {
        [HHImageFileName setCandidatedFileName:[path lastPathComponent]];
    }
    return self;
}

+ (nullable instancetype)dataWithContentsOfURL_hh:(NSURL *)url options:(NSDataReadingOptions)readOptionsMask error:(NSError **)errorPtr
{
    NSData *data = [self dataWithContentsOfURL_hh:url options:readOptionsMask error:errorPtr];
    if (data) {
        [HHImageFileName setCandidatedFileName:[url lastPathComponent]];
    }
    return data;
}

#pragma mark -

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(initWithContentsOfFile:options:error:) modified:@selector(initWithContentsOfFile_hh:options:error:)];
        [HHImageFileName swizzleInstanceMethod:self origin:@selector(initWithContentsOfFile:) modified:@selector(initWithContentsOfFile_hh:)];
        [HHImageFileName swizzleClassMethod:self origin:@selector(dataWithContentsOfURL:options:error:) modified:@selector(dataWithContentsOfURL_hh:options:error:)];
    });
}
@end
