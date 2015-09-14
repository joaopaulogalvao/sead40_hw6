//
//  sead40_hw6Tests.m
//  sead40_hw6Tests
//
//  Created by Joao Paulo Galvao Alves on 9/7/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface sead40_hw6Tests : XCTestCase

@end

@implementation sead40_hw6Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testNil {
  XCTAssertNil(nil);
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
