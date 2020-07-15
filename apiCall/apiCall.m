//
//  post.m
//  apiCall
//
//  Created by Kodey Thomas on 14/07/2020.
//  Copyright (c) 2020 Kodey Thomas. All rights reserved.
//

#import "apiCall.h"

@implementation apiCall

+ (apiCall *)sharedInstance {
    static dispatch_once_t pred;
    static apiCall *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

-(instancetype)init
{
  self = [super init];
  if (self) {

  }
  return self;
}

-(NSMutableDictionary *)POST_JSON:(NSString*)urlString :(NSString*)parameterString { // POST Request in JSON
  NSError *error;
  NSURL *url = [NSURL URLWithString:urlString];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  [request setHTTPMethod:@"POST"];
  [request setURL:url];
  [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  NSData *postData = [parameterString dataUsingEncoding:NSUTF8StringEncoding];
  [request setHTTPBody:postData];
  NSData *rawResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
  NSMutableDictionary *response = [NSJSONSerialization JSONObjectWithData: rawResponse options: NSJSONReadingMutableContainers error: &error];
  return response;
}

@end
