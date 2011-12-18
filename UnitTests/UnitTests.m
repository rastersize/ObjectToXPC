/**
 * ObjectToXPC
 *
 * Copyright 2011 Aron Cedercrantz. All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 *   1. Redistributions of source code must retain the above copyright notice,
 *      this list of conditions and the following disclaimer.
 * 
 *   2. Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation
 *      and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY ARON CEDERCRANTZ ''AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL ARON CEDERCRANTZ OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * The views and conclusions contained in the software and documentation are
 * those of the authors and should not be interpreted as representing official
 * policies, either expressed or implied, of Aron Cedercrantz.
 */

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
	STAssertTrue(xpc_arrayFromObjc != NULL,							@"XPCObject must NOT return NULL for a populated NSArray.");
	STAssertTrue(xpc_get_type(xpc_arrayFromObjc) == XPC_TYPE_ARRAY,	@"Returned XPCObject must be of type XPC_TYPE_ARRAY.");

	
	NSArray *objc_arrayFromXpc = [NSArray arrayWithXPCObject:xpc_arrayFromObjc];
	STAssertNotNil(objc_arrayFromXpc,								@"Initiating from an XPC array object should NOT return NULL/nil.");
	STAssertFalse(objc_array == objc_arrayFromXpc,					@"The objc_array pointer should NOT be equal to the objc_arrayFromXpc pointer.");
	STAssertEqualObjects(objc_array, objc_arrayFromXpc,				@"objc_array must be equal to objc_arrayFromXpc content wise.");
}

- (void)testDataObject
{
	NSData *objc_data = [@"test data string" dataUsingEncoding:NSUTF8StringEncoding];
	xpc_object_t xpc_dataFromObjc = [objc_data XPCObject];
	STAssertTrue(xpc_dataFromObjc != NULL,							@"XPCObject must NOT return NULL for a NSData object with data.");
	STAssertTrue(xpc_get_type(xpc_dataFromObjc) == XPC_TYPE_DATA,	@"Returned XPCObject must be of type XPC_TYPE_DATA.");
	
	NSData *objc_dataFromXpc = [NSData dataWithXPCObject:xpc_dataFromObjc];
	STAssertNotNil(objc_dataFromXpc,								@"Initiating from an XPC data object should NOT return NULL/nil.");
	STAssertFalse(objc_data == objc_dataFromXpc,					@"The objc_data pointer should NOT be equal to the objc_dataFromXpc pointer.");
	STAssertEqualObjects(objc_data, objc_dataFromXpc,				@"objc_data must be equal to objc_dataFromXpc content wise.");
}

- (void)testDateObject
{
	NSDate *objc_date = [NSDate dateWithTimeIntervalSince1970:3600];
	xpc_object_t xpc_dateFromObjc = [objc_date XPCObject];
	STAssertTrue(xpc_dateFromObjc != NULL,							@"XPCObject must NOT return NULL.");
	STAssertTrue(xpc_get_type(xpc_dateFromObjc) == XPC_TYPE_DATE,	@"Returned XPCObject must be of type XPC_TYPE_DATE.");
	
	NSDate *objc_dateFromXpc = [NSDate dateWithXPCObject:xpc_dateFromObjc];
	STAssertNotNil(objc_dateFromXpc,								@"Initiating from an XPC date object should NOT return NULL/nil.");
	STAssertEqualObjects(objc_date, objc_dateFromXpc,				@"objc_date must be equal to objc_dateFromXpc content wise.");
}

- (void)testDictionaryObject
{
	NSString *arrayKey = @"array";
	NSArray *array = [NSArray arrayWithObjects:@"foo", @"bar", nil];
	NSString *dateKey = @"date";
	NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:3600.0];
	NSString *dataKey = @"data";
	NSData *data = [@"Some data..." dataUsingEncoding:NSUTF8StringEncoding];
	NSString *dictionaryKey = @"dict";
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"anObject", @"aKey", nil];
	NSString *nullKey = @"null";
	NSNull *nullObj = [NSNull null];
	
	NSString *boolKey = @"bool";
	NSNumber *numberBool = [NSNumber numberWithBool:YES];
	NSString *doubleKey = @"double";
	NSNumber *numberDouble = [NSNumber numberWithDouble:123.456];
	NSString *int64Key = @"int64";
	NSNumber *numberInt64 = [NSNumber numberWithLongLong:-123456];
	NSString *uint64Key = @"uint64";
	NSNumber *numberUint64 = [NSNumber numberWithUnsignedLongLong:123456];
	
	NSString *stringKey = @"string";
	NSString *string = @"A nice and relatively long string.";
	
	NSDictionary *objc_dict = [NSDictionary dictionaryWithObjectsAndKeys:
							   array,			arrayKey,
							   date,			dateKey,
							   data,			dataKey,
							   dictionary,		dictionaryKey,
							   nullObj,			nullKey,
							   numberBool,		boolKey,
							   numberDouble,	doubleKey,
							   numberInt64,		int64Key,
							   numberUint64,	uint64Key,
							   string,			stringKey,
							   nil];
	
	xpc_object_t xpc_dictFromObjc = [objc_dict XPCObject];
	STAssertTrue(xpc_dictFromObjc != NULL,								@"XPCObject must NOT return NULL for a populated NSDictionary.");
	STAssertTrue(xpc_get_type(xpc_dictFromObjc) == XPC_TYPE_DICTIONARY,	@"Returned XPCObject must be of type XPC_TYPE_DICTIONARY.");
	
	
	NSDictionary *objc_dictFromXpc = [NSDictionary dictionaryWithXPCObject:xpc_dictFromObjc];
	STAssertNotNil(objc_dictFromXpc,								@"Initiating from an XPC dictionary object should NOT return NULL/nil.");
	STAssertFalse(objc_dict == objc_dictFromXpc,					@"The objc_dict pointer should NOT be equal to the objc_dictFromXpc pointer.");
	STAssertEqualObjects(objc_dict, objc_dictFromXpc,				@"objc_dict must be equal to objc_dictFromXpc content wise.");
}

- (void)testNumberObject
{
	BOOL primitive_bool_yes			= YES;
	BOOL primitive_bool_no			= NO;
	int64_t primitive_int64			= INT64_MIN + 1;//-549755813888; // 2^39 = (2^40)/2
	uint64_t primitive_uint64		= UINT64_MAX - 1; //1099511627776; // 2^40
	double primitive_double			= 1.234567890;
	
	NSNumber *objc_number_bool_yes	= [NSNumber numberWithBool:primitive_bool_yes];
	NSNumber *objc_number_bool_no	= [NSNumber numberWithBool:primitive_bool_no];
	NSNumber *objc_number_int64		= [NSNumber numberWithLongLong:primitive_int64];
	NSNumber *objc_number_uint64	= [NSNumber numberWithUnsignedLongLong:primitive_uint64];
	NSNumber *objc_number_double	= [NSNumber numberWithDouble:primitive_double];
	
	NSLog(@"bool nsnumber objCType: %s", [objc_number_bool_yes objCType]);
	
	xpc_object_t xpc_number_bool_yes	= [objc_number_bool_yes XPCObject];
	xpc_object_t xpc_number_bool_no		= [objc_number_bool_no XPCObject];
	xpc_object_t xpc_number_int64		= [objc_number_int64 XPCObject];
	xpc_object_t xpc_number_uint64		= [objc_number_uint64 XPCObject];
	xpc_object_t xpc_number_double		= [objc_number_double XPCObject];
	
	xpc_type_t typeYes = xpc_get_type(xpc_number_bool_yes);
	NSLog(@"xpc_type_get(xpc_number_bool_yes): %p // %p", typeYes, XPC_TYPE_BOOL);
	
	// XPC objects MUST NOT be NULL/nil
	STAssertTrue(xpc_number_bool_yes != NULL,	@"XPCObject must NOT return NULL for a boolean (true) number.");
	STAssertTrue(xpc_number_bool_no != NULL,	@"XPCObject must NOT return NULL for a boolean (false) number.");
	STAssertTrue(xpc_number_int64 != NULL,		@"XPCObject must NOT return NULL for a int64 number.");
	STAssertTrue(xpc_number_uint64 != NULL,		@"XPCObject must NOT return NULL for a uint64 number.");
	STAssertTrue(xpc_number_double != NULL,		@"XPCObject must NOT return NULL for a double number.");
	
	// XPC objcets MUST be of correct type
	// It can not be guaranteed that a BOOL will be stored as a BOOL inside a
	// NSNumber (NSNumber implementation detail) it can (and is) for instance be
	// stored as an char.
	STAssertTrue(xpc_get_type(xpc_number_bool_yes) == XPC_TYPE_BOOL ||
				 xpc_get_type(xpc_number_bool_yes) == XPC_TYPE_INT64,	@"Returned XPCObject must be of type XPC_TYPE_BOOL for a boolean (true)  number.");
	// It can not be guaranteed that a BOOL will be stored as a BOOL inside a
	// NSNumber (NSNumber implementation detail) it can (and is) for instance be
	// stored as an char.
	STAssertTrue(xpc_get_type(xpc_number_bool_no) == XPC_TYPE_BOOL ||
				 xpc_get_type(xpc_number_bool_no) == XPC_TYPE_INT64,	@"Returned XPCObject must be of type XPC_TYPE_BOOL for a boolean (false) number.");
	STAssertTrue(xpc_get_type(xpc_number_int64) == XPC_TYPE_INT64,		@"Returned XPCObject must be of type XPC_TYPE_INT64 for a int64 number.");
	STAssertTrue(xpc_get_type(xpc_number_uint64) == XPC_TYPE_UINT64,	@"Returned XPCObject must be of type XPC_TYPE_UINT64 for a uint64 number.");
	STAssertTrue(xpc_get_type(xpc_number_double) == XPC_TYPE_DOUBLE,	@"Returned XPCObject must be of type XPC_TYPE_DOUBLE for a double number.");
	
	
	NSNumber *objc_number_bool_yesFromXpc	= [NSNumber numberWithXPCObject:xpc_number_bool_yes];
	NSNumber *objc_number_bool_noFromXpc	= [NSNumber numberWithXPCObject:xpc_number_bool_no];
	NSNumber *objc_number_int64FromXpc		= [NSNumber numberWithXPCObject:xpc_number_int64];
	NSNumber *objc_number_uint64FromXpc		= [NSNumber numberWithXPCObject:xpc_number_uint64];
	NSNumber *objc_number_doubleFromXpc		= [NSNumber numberWithXPCObject:xpc_number_double];
	
	// NSNumber objects derived from XPC objects MUST NOT be NULL/nil
	STAssertNotNil(objc_number_bool_yesFromXpc,	@"Initiating from an XPC boolean (true) object should not return NULL/nil.");
	STAssertNotNil(objc_number_bool_noFromXpc,	@"Initiating from an XPC boolean (false) object should not return NULL/nil.");
	STAssertNotNil(objc_number_int64FromXpc,	@"Initiating from an XPC int64 object should not return NULL/nil.");
	STAssertNotNil(objc_number_uint64FromXpc,	@"Initiating from an XPC uint64 object should not return NULL/nil.");
	STAssertNotNil(objc_number_doubleFromXpc,	@"Initiating from an XPC doulbe object should not return NULL/nil.");
	
	// NSNumber objects derived from XPC objects SHOULD be new instances
	STAssertFalse(objc_number_bool_yes == objc_number_bool_yesFromXpc,	@"The objc_number_bool_yes pointer should NOT be equal to the objc_number_bool_yesFromXpc pointer.");
	STAssertFalse(objc_number_bool_no == objc_number_bool_noFromXpc,	@"The objc_number_bool_no pointer should NOT be equal to the objc_number_bool_noFromXpc pointer.");
	STAssertFalse(objc_number_int64 == objc_number_int64FromXpc,		@"The objc_number_int64 pointer should NOT be equal to the objc_number_int64FromXpc pointer.");
	STAssertFalse(objc_number_uint64 == objc_number_uint64FromXpc,		@"The objc_number_uint64 pointer should NOT be equal to the objc_number_uint64FromXpc pointer.");
	STAssertFalse(objc_number_double == objc_number_doubleFromXpc,		@"The objc_number_double pointer should NOT be equal to the objc_number_doubleFromXpc pointer.");
	
	// NSNumber objects derived from XPC objects MUST be equal to original
	// NSNumber objects
	STAssertEqualObjects(objc_number_bool_yes,	objc_number_bool_yesFromXpc,	@"objc_number_bool_yes must be equal to objc_number_bool_yesFromXpc content wise.");
	STAssertEqualObjects(objc_number_bool_no,	objc_number_bool_noFromXpc,		@"objc_number_bool_no must be equal to objc_number_bool_noFromXpc content wise.");
	STAssertEqualObjects(objc_number_int64,		objc_number_int64FromXpc,		@"objc_number_int64 must be equal to objc_number_int64FromXpc content wise.");
	STAssertEqualObjects(objc_number_uint64,	objc_number_uint64FromXpc,		@"objc_number_uint64 must be equal to objc_number_uint64FromXpc content wise.");
	STAssertEqualObjects(objc_number_double,	objc_number_doubleFromXpc,		@"objc_number_double must be equal to objc_number_doubleFromXpc content wise.");
	
	
	bool extracted_primitive_bool_yes	= [objc_number_bool_yesFromXpc boolValue];
	bool extracted_primitive_bool_no	= [objc_number_bool_noFromXpc boolValue];
	int64_t extracted_primitive_int64	= [objc_number_int64FromXpc longLongValue];
	uint64_t extracted_primitive_uint64	= [objc_number_uint64FromXpc unsignedLongLongValue];
	double extracted_primitive_double	= [objc_number_doubleFromXpc doubleValue];
	
	// The extracted primitive values of the derived NSNumber objcets should be
	// the same as the original primitives
	STAssertTrue(primitive_bool_yes == extracted_primitive_bool_yes,	@"The original primitive 'primitive_bool_yes' should be equal to the extracted primitive 'extracted_primitive_bool_yes'.");
	STAssertTrue(primitive_bool_no == extracted_primitive_bool_no,		@"The original primitive 'primitive_bool_no' should be equal to the extracted primitive 'extracted_primitive_bool_no'.");
	STAssertTrue(primitive_int64 == extracted_primitive_int64,			@"The original primitive 'primitive_int64' should be equal to the extracted primitive 'extracted_primitive_int64'.");
	STAssertTrue(primitive_uint64 == extracted_primitive_uint64,		@"The original primitive 'primitive_uint64' should be equal to the extracted primitive 'extracted_primitive_uint64'.");
	STAssertTrue(primitive_double == extracted_primitive_double,		@"The original primitive 'primitive_double' should be equal to the extracted primitive 'extracted_primitive_double'.");
}

- (void)testStringObject
{
	NSString *objc_string = @"A nice test string!";
	xpc_object_t xpc_stringFromObjc = [objc_string XPCObject];
	STAssertTrue(xpc_stringFromObjc != NULL,							@"XPCObject must NOT return NULL.");
	STAssertTrue(xpc_get_type(xpc_stringFromObjc) == XPC_TYPE_STRING,	@"Returned XPCObject must be of type XPC_TYPE_STRING.");
	
	NSString *objc_stringFromXpc = [NSString stringWithXPCObject:xpc_stringFromObjc];
	STAssertNotNil(objc_stringFromXpc,									@"Initiating from an XPC string object should NOT return NULL/nil.");
	STAssertEqualObjects(objc_string, objc_stringFromXpc,				@"objc_string must be equal to objc_stringFromXpc content wise.");
}


@end
