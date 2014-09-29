//
//  HHUIImageNamedTests.m
//  HHUIImageNamedTests
//
//  Created by Hyuk Hur on 2014. 9. 23..
//  Copyright (c) 2014년 Hyuk Hur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UIImage+HHFileNamedImage.h"

@interface UIImage ()
- (NSString *)hh_fileName;
@end

@interface HHUIImageNamedTests : XCTestCase

@end

@implementation HHUIImageNamedTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFinalFunction {
    UIImage *image = [UIImage imageNamed:@"1"];
    XCTAssertTrue([[image description] containsString:@"1"]);
}

- (void)testStoreFileName {
    UIImage *image = [UIImage imageNamed:@"1"];
    XCTAssertEqualObjects(@"1", [image hh_fileName]);
}

- (void)testNormalObject {
    NSString *string = @"test string";
    XCTAssertFalse([[string description] containsString:@","]);
}

- (void)testCallTwice {
    UIImage *image = [UIImage imageNamed:@"1"];
    XCTAssertTrue([[image description] containsString:@"1"]);
    XCTAssertTrue([[image description] containsString:@"1"]);
    XCTAssertTrue([[image description] containsString:@"1"]);
}

- (void)testUIImageView {
    UIImage *image = [UIImage imageNamed:@"1.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    XCTAssertTrue([[imageView description] containsString:@"1.png"]);
}

- (void)testPerformanceExample {
    [self measureBlock:^{
        __unused UIImage *imageNamed = [UIImage imageNamed:@"1.png"];
        __unused UIImage *imageFiled = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.png"]];
    }];
}

- (void)testContentsOfFile {
    UIImage *image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.png"]];
    XCTAssertTrue([[image description] containsString:@"1.png"]);
}

- (void)testData {
    NSData *data = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.png"]];
    UIImage *image = [UIImage imageWithData:data];
    XCTAssertTrue([[image description] containsString:@"1.png"]);
}

- (void)testDataWithScale {
    NSData *data = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.png"]];
    UIImage *image = [UIImage imageWithData:data scale:1];
    XCTAssertTrue([[image description] containsString:@"1.png"]);
}

- (void)testCGImage {
    CGImageRef imageRef = [[UIImage imageNamed:@"1.png"] CGImage];
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    XCTAssertTrue([[image description] containsString:@"1.png"]);
}

- (void)testCGImageWithScaleAndOrientation {
    CGImageRef imageRef = [[UIImage imageNamed:@"1.png"] CGImage];
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:(UIImageOrientationUp)];
    XCTAssertTrue([[image description] containsString:@"1.png"]);
}

- (void)testCIImage {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"1" withExtension:@"png"];
    CIImage *ciImage = [CIImage imageWithContentsOfURL:fileURL];
    UIImage *image = [UIImage imageWithCIImage:ciImage];
    XCTAssertTrue([[image description] containsString:@"1.png"]);
}

- (void)testCIImageWithScaleAndOrientation {
    CIImage *ciImage = [[UIImage imageNamed:@"1.png"] CIImage];
    UIImage *image = [UIImage imageWithCIImage:ciImage scale:1.0 orientation:(UIImageOrientationUp)];
    XCTAssertTrue([[image description] containsString:@"1.png"]);
}

- (void)testTrackingFileNameFromDraw {
    UIImage *image = [UIImage imageNamed:@"1.png"];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextFillRect(context, rect);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    XCTAssertFalse([[image description] containsString:@"1.png"]);
    XCTAssertFalse([[image description] containsString:@"HHUIImageNamedTests"]);
}

@end
