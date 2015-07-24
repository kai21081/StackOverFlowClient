//
//  StackOverFlowService.h
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 13..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface StackOverFlowService : NSObject
+(void)fetchQuestionsForSearchTerm:(NSString*)searchText completionHandler:(void (^)(NSArray *,NSString *))completionHandler;
+(void)fetchUserLoggedIn:(void (^)(User *, NSString*))completionHandler;
@end
