//
//  CHOURLCoder.h
//  CHOURLCoder
//
//  Created by JingdaCao on 12/18/2017.
//  Copyright (c) 2017 chojd.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHOURLCoder : NSObject

+ (instancetype)sharedCoder;

// https://tools.ietf.org/html/rfc3986#section-2.3
@property (nonatomic, readonly) NSCharacterSet *unreservedCharacterSetInRFC3986;// ALPHA / DIGIT / "-" / "." / "_" / "~"
@property (nonatomic, readonly) NSCharacterSet *decimalDigitCharacterSet;// DECIMAL DIGIT characters : 0-9
@property (nonatomic, readonly) NSCharacterSet *alphaCharacterSet;// ALPHA characters : A-Za-z

- (NSString *)encodeQueryValue:(NSString *)string;
- (NSString *)decodeQueryValue:(NSString *)string;

@end
