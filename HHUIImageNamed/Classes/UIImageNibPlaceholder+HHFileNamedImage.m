//
//  UIImageNibPlaceholder+HHFileNamedImage.m
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2018-02-09.
//  Copyright © 2018 Hyuk Hur. All rights reserved.
//

#import "HHUIImageNamed.h"
#import "UIImageNibPlaceholder+HHFileNamedImage.h"
#import "HHImageFileName.h"

NSString *HHUIImageNibPlaceholderUIResourceName = @"UIResourceName";

UIImage *(*UIImageNibPlaceholder_initWithCoder)(id, SEL, NSCoder*) = NULL;
UIImage *UIImageNibPlaceholder_initWithCoder_hh(id self, SEL _cmd, NSCoder *aDecoder)
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
