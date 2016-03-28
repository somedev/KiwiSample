//
//  EPStack_tests.m
//
//  Created by Eduard Panasiuk on 30.09.13.
//

#import <Kiwi.h>
#import "EPStack.h"

@interface EPStack_tests : XCTestCase

@end

@implementation EPStack_tests

@end

#define MAX_CAPACITY 10

SPEC_BEGIN(EPStackTests)

describe(@"EPStack testing", ^{

    context(@"Test New Stack", ^{
        __block EPStack* stack;
        beforeEach(^{
            stack= [[EPStack alloc] initWithMaxCapacity:MAX_CAPACITY];
        });
        afterEach(^{
            stack=nil;
        });
        context(@"Stack Initialization", ^{
            it(@"Instance creation", ^{
                [[stack shouldNot] beNil];
            });

            it(@"Max Capacity", ^{
                [[theValue(stack.maxCapacity) should] equal:theValue(MAX_CAPACITY)];
            });

            it(@"Default Capacity", ^{
                EPStack *theStack= [[EPStack alloc] init];
                [[theValue(theStack.maxCapacity) should] equal:theValue(cEPStackDefaultCapacity)];
            });

        });

        context(@"Stack Count", ^{
            it(@"Count After Creation", ^{
                [[theValue(stack.count) should] equal:theValue(0)];
            });

            it(@"Count After Push", ^{
                [stack push:@"object"];
                [[theValue(stack.count) should] equal:theValue(1)];
            });

            it(@"Count After Pop", ^{
                [stack push:@"object"];
                [stack push:@"object"];
                [[theValue(stack.count) should] equal:theValue(2)];
                [stack pop];
                [[theValue(stack.count) should] equal:theValue(1)];
            });

        });
        
        context(@"Clear", ^{
            it(@"Clear stack", ^{
                [stack push:@"object"];
                [stack push:@"object"];
                [[theValue(stack.count) should] equal:theValue(2)];
                [stack clear];
                [[theValue(stack.count) should] equal:theValue(0)];
            });
        
        });

        context(@"Push Pop Peak", ^{
            it(@"Check object Push Pop", ^{
                NSString *str=@"Test";
                [stack push:str];
                id result= [stack pop];
                [[result should] equal:str];
                [[theValue(stack.count) should] equal:theValue(0)];
            });
            it(@"Peak", ^{

                NSString *str=@"Test";
                [stack push:@"!!!"];
                [stack push:str];
                NSUInteger cnt=stack.count;
                id result= [stack peak];
                [[result should] equal:str];
                [[theValue(stack.count) should] equal:theValue(cnt)];
            });
            it(@"Pop empty", ^{
                id obj=[stack pop];
                [[obj should] beNil];

                [stack push:@"Test"];
                [stack pop];
                obj=[stack pop];
                [[obj should] beNil];
                [[theValue(stack.count) should] equal:theValue(0)];
            });
            it(@"Push Array", ^{
                NSString *last=@"last";
                NSArray *array=@[@"one", @"two", @"three", last];
                [stack pushArray:array];
                [[theValue(stack.count) should] equal:theValue(array.count)];
                id obj= [stack peak];
                [[obj should] equal:last];
            });
            it(@"Capacity", ^{
                for (NSUInteger j = 0; j < (MAX_CAPACITY+ 1); j++) {
                    [stack push:@(j)];
                }
                [[theValue(stack.count) should] equal:theValue(MAX_CAPACITY)];
            });
            it(@"Capacity W Array Pop", ^{
                NSArray *array=@[@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" ",@" "];
                [stack pushArray:array];
                [[theValue(stack.count) should] equal:theValue(MAX_CAPACITY)];
            });
        });

    });



});
SPEC_END