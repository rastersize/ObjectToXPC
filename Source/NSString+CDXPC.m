//
//  NSString+CDXPC.m
//  CollectionToXPC
//
//  Created by Aron Cedercrantz on 2011-12-17.
//  Copyright (c) 2011 Aron Cedercrantz. All rights reserved.
//

#import "NSString+CDXPC.h"

#import "ObjectToXPC-Private.h"

CD_FIX_CATEGORY_BUG(NSString_CDXPC)
@implementation NSString (CDXPC)

+ (id)stringWithXPCObject:(xpc_object_t)xpcObject
{
	return [[[self class] alloc] initWithXPCObject:xpcObject];
}

- (id)initWithXPCObject:(xpc_object_t)xpcObject
{
	NSAssert(xpc_get_type(xpcObject) == XPC_TYPE_STRING, @"xpcObject must be of type XPC_TYPE_STRING");
	
	const char *xpcString = xpc_string_get_string_ptr(xpcObject);
	return [self initWithUTF8String:xpcString];
}

- (xpc_object_t)XPCObject
{
	xpc_object_t resXpcString = xpc_string_create([self UTF8String]);
	return resXpcString;
}

@end
