//
//  CHOURLCoder.m
//  CHOURLCoder
//
//  Created by JingdaCao on 12/18/2017.
//  Copyright (c) 2017 chojd.com All rights reserved.
//

#import "CHOURLCoder.h"

static NSString *alphaChars = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
static NSString *decimalDigitChars = @"0123456789";
static NSString *otherChars = @"-._~";


@interface CHOURLCoder ()

@property (nonatomic, strong, readwrite) NSCharacterSet *unreservedCharacterSetInRFC3986;
@property (nonatomic, strong, readwrite) NSCharacterSet *decimalDigitCharacterSet;
@property (nonatomic, strong, readwrite) NSCharacterSet *alphaCharacterSet;

@end

@implementation CHOURLCoder

+ (instancetype)sharedCoder {
    static CHOURLCoder *_coder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _coder = [[self alloc] init];
    });
    return _coder;
}

- (NSCharacterSet *)unreservedCharacterSetInRFC3986 {
    if (_unreservedCharacterSetInRFC3986) {
        return _unreservedCharacterSetInRFC3986;
    }
    NSString *string = [NSString stringWithFormat:@"%@%@%@", alphaChars, decimalDigitChars, otherChars];
    _unreservedCharacterSetInRFC3986 = [NSCharacterSet characterSetWithCharactersInString:string];
    return _unreservedCharacterSetInRFC3986;
}

- (NSCharacterSet *)alphaCharacterSet {
    if (_alphaCharacterSet) {
        return _alphaCharacterSet;
    }
    _alphaCharacterSet = [NSCharacterSet characterSetWithCharactersInString:alphaChars];
    return _alphaCharacterSet;
}

- (NSCharacterSet *)decimalDigitCharacterSet {
    if (_decimalDigitCharacterSet) {
        return _decimalDigitCharacterSet;
    }
    _decimalDigitCharacterSet = [NSCharacterSet characterSetWithCharactersInString:decimalDigitChars];
    return _decimalDigitCharacterSet;
}

- (float)systemVersion {
    static float version;
    if (version) {
        return version;
    }
    version = [UIDevice currentDevice].systemVersion.floatValue;
    return version;
}

- (NSString *)encodeQueryValue:(NSString *)string {
    if (string == nil || ![string isKindOfClass:[NSString class]] || string.length == 0) {
        return @"";
    }
    
    if ([self systemVersion] >= 9.0) {
        NSString *escaped = [string stringByAddingPercentEncodingWithAllowedCharacters:self.unreservedCharacterSetInRFC3986];
        return escaped;
    } else {
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < string.length) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wgnu"
            NSUInteger length = MIN(string.length - index, batchSize);
#pragma GCC diagnostic pop
            NSRange range = NSMakeRange(index, length);
            
            // To avoid breaking up character sequences such as 👴🏻👮🏽, on iOS 7,8
            range = [string rangeOfComposedCharacterSequencesForRange:range];
            
            NSString *substring = [string substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:self.unreservedCharacterSetInRFC3986];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        
        return escaped;
    }
}

- (NSString *)decodeQueryValue:(NSString *)string {
    if (string == nil || ![string isKindOfClass:[NSString class]] || string.length == 0) {
        return @"";
    }
    NSString *decoded = [string stringByRemovingPercentEncoding];
    return decoded;
}

@end
