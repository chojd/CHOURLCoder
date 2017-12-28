//
//  CHOAppDelegate.m
//  CHOURLCoder
//
//  Created by JingdaCao on 12/18/2017.
//  Copyright (c) 2017 chojd.com All rights reserved.
//

#import "CHOAppDelegate.h"

#import <CHOURLCoder/CHOURLCoder.h>

@implementation CHOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *crash = @"%20%22";
    NSString *enStr1 = [[CHOURLCoder sharedCoder] encodeQueryValue:crash];
    NSString *deStr1 = [[CHOURLCoder sharedCoder] decodeQueryValue:enStr1];
    
    NSString *value = [[CHOURLCoder sharedCoder] encodeQueryValue:@"http://hello.com/data:2034?item=123👴🏻👮🏽"];
    NSString *string = [NSString stringWithFormat:@"http://ofashion.com.cn:2000?%@=%@",@"value", value];
    NSURL *anURL = [NSURL URLWithString:string];
    NSURLComponents *component = [NSURLComponents componentsWithURL:anURL resolvingAgainstBaseURL:YES];
    
    NSLog(@"URLQueryAllowedCharacterSet");
    [self printCharacterSet:[CHOURLCoder sharedCoder].unreservedCharacterSetInRFC3986];
    
    return YES;
}

- (void)printCharacterSet:(NSCharacterSet *)charSet {
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"\n"];
    for (int index = 0; index < 255; index++) {
        if ([charSet characterIsMember:index]) {
            [string appendFormat:@"%c", index];
        }
    }
    NSLog(@"%@", string);
}

@end
