//
//  apiCall.h
//  apiCall
//
//  Created by Kodey Thomas on 14/07/2020.
//  Copyright (c) 2020 Kodey Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface apiCall : NSObject

+ (apiCall *)sharedInstance;
- (NSMutableDictionary *)POST_JSON:(NSString*)urlString:(NSString*)parameterString;

@end
