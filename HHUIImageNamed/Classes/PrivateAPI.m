//
//  PrivateAPI.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2018-02-09.
//  Copyright © 2018 Hyuk Hur. All rights reserved.
//

#import "PrivateAPI.h"
@import UIKit;
@import CoreImage;
#import <objc/runtime.h>

const NSString *HHUIImageNamedCandidatedFileName = @"HHUIImageNamedCandidatedFileName";
const NSString *HHCIImageNamedCandidatedFileName = @"HHCIImageNamedCandidatedFileName";

void SwizzleDescriptionMethodForClass(Class clazz) {
    SEL originalSelector = @selector(description);
    SEL swizzledSelector = @selector(description_hh);
    {
        Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector);

        BOOL didAddMethod = class_addMethod(clazz, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(clazz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}
