//
//  HHUIImageNamedTests.m
//  HHUIImageNamedTests
//
//  Created by Hyuk Hur on 2014. 9. 23..
//  Copyright (c) 2014년 Hyuk Hur. All rights reserved.
//

@import UIKit;
@import XCTest;
@import HHUIImageNamed;

@interface UIImage ()
@property(readonly) NSString *fileName_hh;
@property NSString *fileNameCache_hh;
@property(readonly) BOOL isGuessing_hh;
@end

@interface HHUIImageNamedTests : XCTestCase

@end

@implementation HHUIImageNamedTests

- (void)setUp {
    [super setUp];
    [[[NSThread currentThread] threadDictionary] removeObjectForKey:@"HHUIImageNamedCandidatedFileName"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFinalFunction {
    UIImage *image = [UIImage imageNamed:@"img1"];
    XCTAssertTrue([[image description] hasPrefix:@"img1"]);
}

- (void)testStoreFileName {
    UIImage *image = [UIImage imageNamed:@"img1"];
    XCTAssertEqualObjects(@"img1", [image fileName_hh]);
}

- (void)testNormalObject {
    NSString *string = @"test string";
    XCTAssertFalse([[string description] containsString:@","]);
}

- (void)testCallTwice {
    UIImage *image = [UIImage imageNamed:@"img1"];
    XCTAssertTrue([[image description] hasPrefix:@"img1"]);
    XCTAssertTrue([[image description] hasPrefix:@"img1"]);
    XCTAssertTrue([[image description] hasPrefix:@"img1"]);
}

- (void)testUIImageView {
    UIImage *image = [UIImage imageNamed:@"img1.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    XCTAssertTrue([[imageView description] hasPrefix:@"img1.png"]);
}

- (void)testPerformanceExample {
    [self measureBlock:^{
        __unused UIImage *imageNamed = [UIImage imageNamed:@"img1.png"];
        __unused UIImage *imageFiled = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"img1.png"]];
    }];
}

- (void)testContentsOfFile {
    UIImage *image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"img1.png"]];
    XCTAssertTrue([[image description] hasPrefix:@"img1.png"]);
}

- (void)testResizableImageWithCapInsets {
    UIImage *image = [[UIImage imageNamed:@"img1.png"] resizableImageWithCapInsets:UIEdgeInsetsZero];
    XCTAssertTrue([[image description] hasPrefix:@"img1.png"]);
}

- (void)testResizableImageWithCapInsetsResizingMode {
    UIImage *image = [[UIImage imageNamed:@"img1.png"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:(UIImageResizingModeStretch)];
    XCTAssertTrue([[image description] hasPrefix:@"img1.png"]);
}

- (void)testStretchableImageWithLeftCapWidth {
    UIImage *image = [[UIImage imageNamed:@"img1.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    XCTAssertTrue([[image description] hasPrefix:@"img1.png"]);
}

- (void)testImageWithAlignmentRectInsets {
    UIImage *image = [[UIImage imageNamed:@"img1.png"] imageWithAlignmentRectInsets:(UIEdgeInsetsZero)];
    XCTAssertTrue([[image description] hasPrefix:@"img1.png"]);
}

- (void)testImageWithRenderingMode {
    UIImage *image = [[UIImage imageNamed:@"img1.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    XCTAssertTrue([[image description] hasPrefix:@"img1.png"]);
}

- (void)testAnimatedImageNamed {
    UIImage *image = [UIImage animatedImageNamed:@"img" duration:1];
    XCTAssertTrue([[image description] containsString:@"img"]);
}

- (void)testAnimatedResizableImageNamed {
    UIImage *image = [UIImage animatedResizableImageNamed:@"img" capInsets:(UIEdgeInsetsZero) duration:1];
    XCTAssertTrue([[image description] containsString:@"img"]);
}

- (void)testAnimatedResizableImageNamedResizingMode {
    UIImage *image = [UIImage animatedResizableImageNamed:@"img" capInsets:(UIEdgeInsetsZero) resizingMode:(UIImageResizingModeStretch) duration:1];
    XCTAssertTrue([[image description] containsString:@"img"]);
}

- (void)testAnimatedImageWithImages {
    UIImage *image = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"img1.png"], [UIImage imageNamed:@"img2.png"], [UIImage imageNamed:@"img3.png"]] duration:1];
    XCTAssertTrue([[image description] hasPrefix:@"img1.png"]);
    XCTAssertTrue([[image description] containsString:@"img2.png"]);
    XCTAssertTrue([[image description] containsString:@"img3.png"]);
}

- (void)testData {
    NSData *data = [NSData dataWithContentsOfURL:[[[NSBundle bundleForClass:self.class] resourceURL] URLByAppendingPathComponent:@"img1.png"] options:(NSDataReadingMappedIfSafe) error:NULL];
    UIImage *image = [UIImage imageWithData:data];
    XCTAssertTrue([[image description] containsString:@"img1.png"]);
    XCTAssertTrue([[image description] containsString:@"Guessing"]);
    XCTAssertTrue([image isGuessing_hh]);

    NSData *data2 = [NSData dataWithContentsOfURL:[[[NSBundle bundleForClass:self.class] resourceURL] URLByAppendingPathComponent:@"img2.png"]];
    UIImage *image2 = [UIImage imageWithData:data2];
    XCTAssertTrue([[image2 description] containsString:@"img2.png"]);
    XCTAssertTrue([[image2 description] containsString:@"Guessing"]);
    XCTAssertTrue([image2 isGuessing_hh]);
}

- (void)testDataWithScale {
    NSData *data = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"img1.png"]];
    UIImage *image = [UIImage imageWithData:data scale:1];
    XCTAssertTrue([[image description] containsString:@"img1.png"]);
    XCTAssertTrue([[image description] containsString:@"Guessing"]);
    XCTAssertTrue([image isGuessing_hh]);
}

- (void)testCGImage {
    CGImageRef imageRef = [[UIImage imageNamed:@"img1.png"] CGImage];
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    XCTAssertTrue([[image description] containsString:@"img1.png"]);
    XCTAssertTrue([[image description] containsString:@"Guessing"]);
    XCTAssertTrue([image isGuessing_hh]);
}

- (void)testCGImageWithScaleAndOrientation {
    CGImageRef imageRef = [[UIImage imageNamed:@"img1.png"] CGImage];
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:(UIImageOrientationUp)];
    XCTAssertTrue([[image description] containsString:@"img1.png"]);
    XCTAssertTrue([[image description] containsString:@"Guessing"]);
    XCTAssertTrue([image isGuessing_hh]);
}

- (void)testCIImage {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"img1" withExtension:@"png"];
    CIImage *ciImage = [CIImage imageWithContentsOfURL:fileURL];
    UIImage *image = [UIImage imageWithCIImage:ciImage];
    XCTAssertTrue([[image description] hasPrefix:@"img1.png"]);
}

- (void)testCIImageWithScaleAndOrientation {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"img1" withExtension:@"png"];
    CIImage *ciImage = [CIImage imageWithContentsOfURL:fileURL];
    UIImage *image = [UIImage imageWithCIImage:ciImage scale:1.0 orientation:(UIImageOrientationUp)];
    XCTAssertTrue([[image description] hasPrefix:@"img1.png"]);
    XCTAssertTrue([[ciImage description] hasPrefix:@"img1.png"]);
}

- (void)testFailMakingCIImageFromUIImageWithoutCIImage {
    CIImage *ciImage = [[UIImage imageNamed:@"img1.png"] CIImage];
    UIImage *image = [UIImage imageWithCIImage:ciImage scale:1.0 orientation:(UIImageOrientationUp)];
    XCTAssertNil(ciImage);
    XCTAssertNil(image);
}

- (void)testCIImageFromUIImageWithCIImage {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"img1" withExtension:@"png"];
    CIImage *ciImage = [CIImage imageWithContentsOfURL:fileURL];
    UIImage *image = [UIImage imageWithCIImage:ciImage scale:1.0 orientation:(UIImageOrientationUp)];
    CIImage *ciImage2 = [image CIImage];
    XCTAssertNotNil(ciImage2);
    XCTAssertTrue([[ciImage2 description] hasPrefix:@"img1.png"]);
}

- (void)testTrackingFileNameFromDraw {
    UIImage *image = [UIImage imageNamed:@"img1.png"];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextDrawImage(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [[[UIColor redColor] colorWithAlphaComponent:0.5] CGColor]);
    CGContextFillRect(context, rect);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    XCTAssertTrue([[image description] containsString:@"img1.png"]);
    XCTAssertTrue([[image description] containsString:@"Guessing"]);
    XCTAssertTrue([image isGuessing_hh]);
}

- (void)testXcodeAssets {
    UIImage *image = [UIImage imageNamed:@"asset_img1"];
    XCTAssertTrue([[image description] containsString:@"asset_img1"]);
}

- (void)testImageInStoryboard {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    UIImageView *imageView = (UIImageView *)[[vc.view subviews] firstObject];
    XCTAssertTrue([[imageView description] hasPrefix:@"img1.png"]);
}

- (void)testCaching {
    UIImage *image = [UIImage imageNamed:@"img1"];
    XCTAssertNil([image fileNameCache_hh]);
    XCTAssertTrue([[image description] hasPrefix:@"img1"]);
    XCTAssertTrue([[image fileNameCache_hh] hasPrefix:@"img1"]);
    [image setFileNameCache_hh:nil];
    XCTAssertNil([image fileNameCache_hh]);
    XCTAssertTrue([[image description] hasPrefix:@"img1"]);
    XCTAssertTrue([[image fileNameCache_hh] hasPrefix:@"img1"]);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [image performSelector:@selector(setFileName_hh:) withObject:@"img2"];
#pragma clang diagnostic pop
    XCTAssertNil([image fileNameCache_hh]);
    XCTAssertTrue([[image description] hasPrefix:@"img2"]);
    XCTAssertTrue([[image fileNameCache_hh] hasPrefix:@"img2"]);
}

@end
