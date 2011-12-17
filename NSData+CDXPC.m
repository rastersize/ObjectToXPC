//
//  NSData+CDXPC.m
//  CollectionToXPC
//
//  Created by Aron Cedercrantz on 2011-12-17.
//  Copyright (c) 2011 Aron Cedercrantz. All rights reserved.
//

#import "NSData+CDXPC.h"

#import "ObjectToXPC-Private.h"

CD_FIX_CATEGORY_BUG(NSData_CDXPC)
@implementation NSData (CDXPC)

+ (id)dataWithXPCObject:(xpc_object_t)xpcObject
{
	return [[[self class] alloc] initWithXPCObject:xpcObject];
}

- (id)initWithXPCObject:(xpc_object_t)xpcObject
{
	NSAssert(xpc_get_type(xpcObject) == XPC_TYPE_DATA, @"xpcObject must be of type XPC_TYPE_DATA");
	
	NSUInteger length = xpc_data_get_length(xpcObject);
	const void *dataPtr = xpc_data_get_bytes_ptr(xpcObject);
	return [self initWithBytes:dataPtr length:length];
}

- (xpc_object_t)XPCObject
{
	const void *dataPtr = [self bytes];
	NSUInteger length = [self length];
	xpc_object_t resXpcData = xpc_data_create(dataPtr, length);
	
	return resXpcData;
}

@end
