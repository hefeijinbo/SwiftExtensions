//
//  OCTests.m
//  Tests
//
//  Created by jinbo on 2020/8/8.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

#import "OCTests.h"
#import <XCTest/XCTest.h>
#import "Tests-Swift.h"

@implementation OCTests

- (void)setUp {
    [super setUp];
}

- (void)testEmailLogin {
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"test" foregroundColor:UIColor.redColor systemFontSize:15].bolded.struckthrough;
    NSLog(@"%@", attributedString);
}


@end
