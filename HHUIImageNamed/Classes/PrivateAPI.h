//
//  PrivateAPI.h
//  HHUIImageNamed
//
//  Created by Hyuk Hur on 2018-02-09.
//  Copyright © 2018 Hyuk Hur. All rights reserved.
//

@import Foundation;
@import UIKit;
@import CoreImage;

OBJC_EXTERN NSString *HHUIImageNamedCandidatedFileName;
OBJC_EXTERN NSString *HHCIImageNamedCandidatedFileName;

@interface CIImage (HHFileNamedImage)
@property(nonatomic, strong) NSString *fileName_hh;
@end

@interface UIImage (HHFileNamedImage)
@property(nonatomic, strong) NSString *fileName_hh;
- (NSString *)description_hh;
@end

@interface UIImageView (HHFileNamedImage)
- (NSString *)description_hh;
@end

void SwizzleDescriptionMethodForClass(Class clazz);
