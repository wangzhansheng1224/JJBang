//
//  NSMutableString+AXNetworkingMethods.m
//  RTNetworking
//
//  Created by casa on 14-5-17.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "NSMutableString+LDNetworkingMethods.h"
#import "NSObject+LDNetworkingMethods.h"

@implementation NSMutableString (LDNetworkingMethods)

- (void)appendURLRequest:(NSURLRequest *)request {
  [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
  [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields
                                                  ? request.allHTTPHeaderFields
                                                  : @"\t\t\t\t\tN/A"];
  [self appendFormat:@"\n\nHTTP Body:\n\t%@",
                     [[[NSString alloc] initWithData:request.HTTPBody
                                            encoding:NSUTF8StringEncoding]
                         LD_defaultValue:@"\t\t\t\tN/A"]];
}

@end
