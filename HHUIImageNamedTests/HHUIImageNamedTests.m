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

- (void)testFinalFunction2 {
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.png"]];
    XCTAssertTrue([[image description] containsString:@"1.png"]);
}

- (void)testStoreFileName2 {
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.png"]];
    XCTAssertEqualObjects(@"1.png", [image hh_fileName]);
}

- (void)testPerformanceExample {
    [self measureBlock:^{
        __unused UIImage *imageNamed = [UIImage imageNamed:@"1.png"];
        __unused UIImage *imageFiled = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.png"]];
    }];
}

@end
