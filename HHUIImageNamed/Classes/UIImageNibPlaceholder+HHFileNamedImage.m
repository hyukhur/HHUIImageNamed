//
//  UIImageNibPlaceholder+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2018-02-09.
//  Copyright © 2018 Hyuk Hur. All rights reserved.
//

#import "HHUIImageNamed.h"
#import "UIImageNibPlaceholder+HHFileNamedImage.h"
#import "PrivateAPI.h"
#import <objc/runtime.h>

NSString *HHUIImageNibPlaceholderUIResourceName = @"UIResourceName";
#ifdef USE_PRIVATE
static UIImage *(*UIImageNibPlaceholder_initWithCoder)(id, SEL, NSCoder*) = NULL;
static UIImage *UIImageNibPlaceholder_initWithCoder_hh(id self, SEL _cmd, NSCoder *aDecoder)
{
    UIImage *result = (*UIImageNibPlaceholder_initWithCoder)(self, _cmd, aDecoder);
    if (result) {
        NSString *imageName = [aDecoder decodeObjectForKey:HHUIImageNibPlaceholderUIResourceName];
        if ([imageName isKindOfClass:[NSString class]]) {
            [result setFileName_hh:imageName];
        }
    }
    return result;
}
#endif

void loadUIImageNibPlaceholder_initWithCoder(void) {
#ifdef USE_PRIVATE
    UIImageNibPlaceholder_initWithCoder = (UIImage*(*)(id, SEL, NSKeyedUnarchiver*))class_replaceMethod(NSClassFromString(@"UIImageNibPlaceholder"), @selector(initWithCoder:), (IMP)UIImageNibPlaceholder_initWithCoder_hh, "@@:@");
#endif
}
