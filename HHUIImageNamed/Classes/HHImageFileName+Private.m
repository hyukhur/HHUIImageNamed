//
//  HHImageFileName+Private.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2018-02-10.
//  Copyright © 2018 Hyuk Hur. All rights reserved.
//

#import "HHUIImageNamed.h"
@import CoreImage;
#import <objc/runtime.h>
#import "HHImageFileName+Private.h"

#if USE_PRIVATE
#import "UIImageNibPlaceholder+HHFileNamedImage.h"
#import "fishhook.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"

static CGImageSourceRef (* CGImageSourceCreateWithURL_Impl)(CFURLRef __nonnull url, CFDictionaryRef __nullable options) = NULL;
static CGImageSourceRef CGImageSourceCreateWithURL_hh(CFURLRef __nonnull url, CFDictionaryRef __nullable options)
{
    CGImageSourceRef result = (*CGImageSourceCreateWithURL_Impl)(url, options);
    CFStringRef fileName = CFURLCopyLastPathComponent(url);
    if (fileName) {
        [HHImageFileName setCandidatedFileName:CFBridgingRelease(fileName)];
    }
    return result;
}

static CGDataProviderRef __nullable (*CGDataProviderCreateWithURL_Impl)(CFURLRef cg_nullable url) = NULL;
static CGDataProviderRef __nullable CGDataProviderCreateWithURL_hh(CFURLRef cg_nullable url)
{
    CGDataProviderRef result = (*CGDataProviderCreateWithURL_Impl)(url);
    CFStringRef fileName = CFURLCopyLastPathComponent(url);
    if (fileName) {
        [HHImageFileName setCandidatedFileName:CFBridgingRelease(fileName)];
    }
    return result;
}

static CGDataProviderRef __nullable (*CGDataProviderCreateWithFilename_Impl)(const char * cg_nullable filename) = NULL;
static CGDataProviderRef __nullable CGDataProviderCreateWithFilename_hh(const char * cg_nullable filename)
{
    CGDataProviderRef result = (*CGDataProviderCreateWithFilename_Impl)(filename);
    if (filename) {
        [HHImageFileName setCandidatedFileName:CFBridgingRelease(filename)];
    }
    return result;
}

static CGImageRef __nullable (*CGImageSourceCreateImageAtIndex_Impl)(CGImageSourceRef __nonnull isrc, size_t index, CFDictionaryRef __nullable options) = NULL;
static CGImageRef __nullable CGImageSourceCreateImageAtIndex_hh(CGImageSourceRef __nonnull isrc, size_t index, CFDictionaryRef __nullable options)
{
    CGImageRef result = (*CGImageSourceCreateImageAtIndex_Impl)(isrc, index, options);
    NSString *fileName = [HHImageFileName candidatedFileName];
    if (fileName) {
        [HHImageFileName setFileName:fileName CGImage:result];
    }
    return result;
}

static CGImageRef __nullable (*CGImageSourceCreateThumbnailAtIndex_Impl)(CGImageSourceRef __nonnull isrc, size_t index, CFDictionaryRef __nullable options) = NULL;
static CGImageRef __nullable CGImageSourceCreateThumbnailAtIndex_hh(CGImageSourceRef __nonnull isrc, size_t index, CFDictionaryRef __nullable options)
{
    CGImageRef result = (*CGImageSourceCreateThumbnailAtIndex_Impl)(isrc, index, options);
    NSString *fileName = [HHImageFileName candidatedFileName];
    if (fileName) {
        [HHImageFileName setFileName:fileName CGImage:result];
    }
    return result;
}

#endif

#pragma clang diagnostic pop

@implementation HHImageFileName(Private)
#if USE_PRIVATE
+ (BOOL)isUsePrivateAPIs
{
    return YES;
}
#else
+ (BOOL)isUsePrivateAPIs
{
    return NO;
}
#endif

+ (void)swizzleCGImageClasses
{
#if USE_PRIVATE
    rebind_symbols(
                   (struct rebinding[5]){
                       {"CGImageSourceCreateWithURL", CGImageSourceCreateWithURL_hh, (void *)&CGImageSourceCreateWithURL_Impl},
                       {"CGDataProviderCreateWithURL", CGDataProviderCreateWithURL_hh, (void *)&CGDataProviderCreateWithURL_Impl},
                       {"CGDataProviderCreateWithFilename", CGDataProviderCreateWithFilename_hh, (void *)&CGDataProviderCreateWithFilename_Impl},
                       {"CGImageSourceCreateImageAtIndex", CGImageSourceCreateImageAtIndex_hh, (void *)&CGImageSourceCreateImageAtIndex_Impl},
                       {"CGImageSourceCreateThumbnailAtIndex", CGImageSourceCreateThumbnailAtIndex_hh, (void *)&CGImageSourceCreateThumbnailAtIndex_Impl},
                   }, 5);
#endif
}


+ (void)swizzleUIImageNibPlaceholder_initWithCoder
{
#if USE_PRIVATE
    UIImageNibPlaceholder_initWithCoder = (UIImage*(*)(id, SEL, NSKeyedUnarchiver*))class_replaceMethod(NSClassFromString(@"UIImageNibPlaceholder"), @selector(initWithCoder:), (IMP)UIImageNibPlaceholder_initWithCoder_hh, "@@:@");
#endif
}

@end
