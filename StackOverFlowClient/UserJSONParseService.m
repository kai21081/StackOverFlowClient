//
//  UserJSONParseService.m
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 18..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import "UserJSONParseService.h"

@implementation UserJSONParseService

+(User *) parseJSONForUser:(NSData *)data{
  User *user = [[User alloc]init];
  NSError *error;
  NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  NSArray *userObjects = [jsonObject objectForKey:@"items"];
  for (NSDictionary *userObj in userObjects) {
    user.user_id = (NSString*)[userObj objectForKey:@"user_id"];
    user.display_name = (NSString*)[userObj objectForKey:@"display_name"];
    user.link  = (NSString*)[userObj objectForKey:@"link"];
    user.profile_image_url = (NSString*)[userObj objectForKey:@"profile_image"];
    NSDictionary *badges = [userObj objectForKey:@"badge_counts"];
    user.bronze_badge_count = (int)[badges objectForKey:@"bronze"];
    user.silver_badge_count = (int)[badges objectForKey:@"silver"];
    user.gold_badge_count = (int)[badges objectForKey:@"gold"];
    user.reputation = (int)[userObj objectForKey:@"reputation"];
  }
  return user;
}
@end
