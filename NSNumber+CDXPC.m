//
//  NSNumber+CDXPC.m
//  CollectionToXPC
//
//  Created by Aron Cedercrantz on 2011-12-17.
//  Copyright (c) 2011 Aron Cedercrantz. All rights reserved.
//

#import "NSNumber+CDXPC.h"

#import "ObjectToXPC-Private.h"

CD_FIX_CATEGORY_BUG(NSNumber_CDXPC)
@implementation NSNumber (CDXPC)

+ (id)numberWithXPCObject:(xpc_object_t)xpcObject
{
	return [[[self class] alloc] initWithXPCObject:xpcObject];
}

- (id)initWithXPCObject:(xpc_object_t)xpcObject
{
	xpc_type_t objectType = xpc_get_type(xpcObject);
	NSAssert((objectType == XPC_TYPE_BOOL ||
			  objectType == XPC_TYPE_DOUBLE ||
			  objectType == XPC_TYPE_INT64 ||
			  objectType == XPC_TYPE_UINT64),
			 @"xpcObject must be one of; bool, double, int64 or uint64.");
	
	
	NSNumber *newSelf = nil;
	if (objectType == XPC_TYPE_BOOL) {
		_Bool boolValue = xpc_bool_get_value(xpcObject);
		newSelf = [[NSNumber alloc] initWithBool:boolValue];
	}
	else if (objectType == XPC_TYPE_DOUBLE) {
		double doubleValue = xpc_double_get_value(xpcObject);
		newSelf = [[NSNumber alloc] initWithDouble:doubleValue];
	}
	else if (objectType == XPC_TYPE_INT64) {
		int64_t int64Value = xpc_int64_get_value(xpcObject);
		newSelf = [[NSNumber alloc] initWithLongLong:int64Value];
	}
	else if (objectType == XPC_TYPE_UINT64) {
		uint64_t uint64Value = xpc_uint64_get_value(xpcObject);
		newSelf = [[NSNumber alloc] initWithUnsignedLongLong:uint64Value];
	}
	
	self = newSelf;
	return self;
}


- (xpc_object_t)XPCObject
{
	xpc_object_t resXpcNumber = NULL;
	
	// Bools
	if (strcmp([self objCType], "B") == 0) {
		resXpcNumber = xpc_bool_create(([self boolValue] == YES));
	}
	// Integers (all stored as an int64_t)
	else if (strcmp([self objCType], "c") == 0 ||
			 strcmp([self objCType], "i") == 0 ||
			 strcmp([self objCType], "s") == 0 ||
			 strcmp([self objCType], "l") == 0 ||
			 strcmp([self objCType], "q") == 0) {
		
		resXpcNumber = xpc_int64_create([self longLongValue]);
	}
	// Unsigned integers (all stored as an uint64_t)
	else if (strcmp([self objCType], "C") == 0 ||
			 strcmp([self objCType], "I") == 0 ||
			 strcmp([self objCType], "S") == 0 ||
			 strcmp([self objCType], "L") == 0 ||
			 strcmp([self objCType], "Q") == 0) {
		
		resXpcNumber = xpc_uint64_create([self unsignedLongLongValue]);
	}
	// Floats and doubles (all stored as an double)
	else if (strcmp([self objCType], "f")  == 0 ||
			 strcmp([self objCType], "d")  == 0) {
		
		resXpcNumber = xpc_double_create([self doubleValue]);
	}
	
	return resXpcNumber;
}

@end
