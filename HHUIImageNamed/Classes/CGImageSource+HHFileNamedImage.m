//
//  CGImageSource+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2018-02-08.
//  Copyright © 2018 Hyuk Hur. All rights reserved.
//

#import "HHUIImageNamed.h"
#import "CGImageSource+HHFileNamedImage.h"
#import "PrivateAPI.h"
#import <objc/runtime.h>
#import "fishhook.h"

static CGImageSourceRef (* CGImageSourceCreateWithURL_Impl)(CFURLRef __nonnull url, CFDictionaryRef __nullable options) = NULL;
static CGImageSourceRef CGImageSourceCreateWithURL_hh(CFURLRef __nonnull url, CFDictionaryRef __nullable options)
{
    CGImageSourceRef result = (*CGImageSourceCreateWithURL_Impl)(url, options);
    if (result) {
        [[[NSThread currentThread] threadDictionary] setObject:[(__bridge NSURL *)url lastPathComponent] forKey:HHUIImageNamedCandidatedFileName];
    }
    return result;
}

static CGImageSourceRef (* CGImageSourceCreateWithDataProvider_Impl)(CGDataProviderRef __nonnull provider, CFDictionaryRef __nullable options) = NULL;
static CGImageSourceRef CGImageSourceCreateWithDataProvider_hh(CGDataProviderRef __nonnull provider, CFDictionaryRef __nullable options)
{
    CGImageSourceRef result = (*CGImageSourceCreateWithDataProvider_Impl)(provider, options);
    if (result) {
//        [[[NSThread currentThread] threadDictionary] setObject:[(__bridge NSURL *)url lastPathComponent] forKey:HHUIImageNamedCandidatedFileName];
    }
    return result;
}


void loadCGImageSource(void) {
//#ifdef USE_PRIVATE
    rebind_symbols(
                   (struct rebinding[2]){
                       {"CGImageSourceCreateWithURL", CGImageSourceCreateWithURL_hh, (void *)&CGImageSourceCreateWithURL_Impl},
                       {"CGImageSourceCreateWithDataProvider", CGImageSourceCreateWithDataProvider_hh, (void *)&CGImageSourceCreateWithDataProvider_Impl}},
                   2);
//#endif
}
//IMAGEIO_EXTERN CGImageSourceRef __nullable CGImageSourceCreateWithDataProvider(CGDataProviderRef __nonnull provider, CFDictionaryRef __nullable options) IMAGEIO_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
//
///* Create an image source reading from `data'.  The `options' dictionary
// * may be used to request additional creation options; see the list of keys
// * above for more information. */
//
//IMAGEIO_EXTERN CGImageSourceRef __nullable CGImageSourceCreateWithData(CFDataRef __nonnull data, CFDictionaryRef __nullable options) IMAGEIO_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);

