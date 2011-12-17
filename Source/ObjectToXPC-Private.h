//
//  ObjectToXPC-Private.h
//  ObjectToXPC
//
//  Created by Aron Cedercrantz on 2011-12-16.
//  Copyright (c) 2011 Aron Cedercrantz. All rights reserved.
//

#ifndef ObjectToXPC_CollectionToXPC_Private_h
#define ObjectToXPC_CollectionToXPC_Private_h

/**
 * Force a category to be loaded when an app starts up.
 *
 * Add this macro before each category implementation, so we don't have to use
 * -all_load or -force_load to load object files from static libraries that only contain
 * categories and no classes.
 * See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 *
 * Macro from the Numbis project at https://github.com/jverkoey/nimbus/.
 */
#define CD_FIX_CATEGORY_BUG(name) @interface CD_FIX_CATEGORY_BUG_##name @end \
@implementation CD_FIX_CATEGORY_BUG_##name @end

#endif
