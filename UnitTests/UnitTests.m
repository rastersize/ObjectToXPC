//
//  UnitTests.m
//  UnitTests
//
//  Created by Aron Cedercrantz on 2011-12-17.
//  Copyright (c) 2011 Icomera. All rights reserved.
//

#import "UnitTests.h"

#import "NSArray+CDXPC.h"
#import "NSData+CDXPC.h"
#import "NSDate+CDXPC.h"
#import "NSDictionary+CDXPC.h"
#import "NSNumber+CDXPC.h"
#import "NSString+CDXPC.h"

@implementation UnitTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testArrayObject
{
	NSArray *array = [NSArray arrayWithObjects:@"foo", @"bar", nil];
	NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:3600.0];
	NSData *data = [@"Some data..." dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"anObject", @"aKey", nil];
	NSNull *nullObj = [NSNull null];

	NSNumber *numberBool = [NSNumber numberWithBool:YES];
	NSNumber *numberDouble = [NSNumber numberWithDouble:123.456];
	NSNumber *numberInt64 = [NSNumber numberWithLongLong:-123456];
	NSNumber *numberUint64 = [NSNumber numberWithUnsignedLongLong:123456];

	NSString *string = @"A nice and relatively long string.";

	NSArray *objc_array = [NSArray arrayWithObjects:
						   array,
						   date,
						   data,
						   dictionary,
						   nullObj,
						   numberBool,
						   numberDouble,
						   numberInt64,
						   numberUint64,
						   string,
						   nil];
	xpc_object_t xpc_arrayFromObjc = [objc_array XPCObject];
	STAssertTrue(xpc_arrayFromObjc != NULL, @"XPCObject must NOT return NULL for a populated NSArray.");
	STAssertTrue(xpc_get_type(xpc_arrayFromObjc) == XPC_TYPE_ARRAY, @"Returned XPCObject must be of type XPC_TYPE_ARRAY.");


	NSArray *objc_arrayFromXpc = [NSArray arrayWithXPCObject:xpc_arrayFromObjc];
	STAssertNotNil(objc_arrayFromXpc, @"Initiating from an XPC data object should NOT return NULL/nil.");
	STAssertFalse(objc_array == objc_arrayFromXpc, @"The objc_array pointer should NOT be equal to the objc_arrayFromXpc pointer.");
	STAssertEqualObjects(objc_array, objc_arrayFromXpc, @"objc_array must be equal to objc_arrayFromXpc content wise.");
}

@end
