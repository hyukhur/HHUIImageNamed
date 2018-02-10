//
//  HHImageFileName+Private.h
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2018-02-10.
//  Copyright © 2018 Hyuk Hur. All rights reserved.
//

@import Foundation;
#import "HHImageFileName.h"

@interface HHImageFileName(Private)
@property(class, assign, readonly, nonatomic) BOOL isUsePrivateAPIs;
+ (void)swizzleCGImageClasses;
+ (void)swizzleUIImageNibPlaceholder_initWithCoder;
@end
