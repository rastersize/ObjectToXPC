//
//  NSDate+CDXPC.m
//  CollectionToXPC
//
//  Created by Aron Cedercrantz on 2011-12-17.
//  Copyright (c) 2011 Aron Cedercrantz. All rights reserved.
//

#import "NSDate+CDXPC.h"

#import "ObjectToXPC-Private.h"

CD_FIX_CATEGORY_BUG(NSDate_CDXPC)
@implementation NSDate (CDXPC)

+ (id)dateWithXPCObject:(xpc_object_t)xpcObject
{
	return [[[self class] alloc] initWithXPCObject:xpcObject];
}

- (id)initWithXPCObject:(xpc_object_t)xpcObject
{
	NSAssert(xpc_get_type(xpcObject) == XPC_TYPE_DATE, @"xpcObject must be of type XPC_TYPE_DATE");
	
	int64_t unixTimestamp = xpc_date_get_value(xpcObject);
	return [self initWithTimeIntervalSince1970:unixTimestamp];
}

- (xpc_object_t)XPCObject
{
	xpc_object_t resXpcDate = xpc_date_create([self timeIntervalSince1970]);
	return resXpcDate;
}

@end
