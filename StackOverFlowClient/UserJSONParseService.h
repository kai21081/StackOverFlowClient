//
//  UserJSONParseService.h
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 18..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserJSONParseService : NSObject
+(User*) parseJSONForUser:(NSData *)data;
@end
