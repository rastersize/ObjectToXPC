//
//  NSDictionary+CDXPC.h
//  CollectionToXPC
//
//  Created by Aron Cedercrantz on 2011-12-17.
//  Copyright (c) 2011 Aron Cedercrantz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <xpc/xpc.h>

@interface NSDictionary (CDXPC)

+ (id)dictionaryWithXPCObject:(xpc_object_t)xpcObject;

- (id)initWithXPCObject:(xpc_object_t)xpcObject;

- (xpc_object_t)XPCObject;

@end
