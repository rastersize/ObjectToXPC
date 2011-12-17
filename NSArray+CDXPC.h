//
//  NSArray+CDXPC.h
//  CollectionToXPC
//
//  Created by Aron Cedercrantz on 2011-12-16.
//  Copyright (c) 2011 Aron Cedercrantz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <xpc/xpc.h>

@interface NSArray (CDXPC)

+ (id)arrayWithXPCObject:(xpc_object_t)xpcObject;

- (id)initWithXPCObject:(xpc_object_t)xpcObject;

- (xpc_object_t)XPCObject;

@end
