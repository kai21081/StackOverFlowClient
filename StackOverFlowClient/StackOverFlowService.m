//
//  StackOverFlowService.m
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 13..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import "StackOverFlowService.h"
#import "QuestionJSONParseService.h"
#import "UserJSONParseService.h"
#import "User.h"

NSString const *key = @"V57AAsWf6VhYlzNFHKprtw((";

@implementation StackOverFlowService

+(void)fetchQuestionsForSearchTerm:(NSString*)searchText completionHandler:(void (^)(NSArray *,NSString *))completionHandler{
  NSString *urlString = @"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&site=stackoverflow&intitle=";
  urlString = [urlString stringByAppendingString:searchText];
  
  NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
  if(token){
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&access_token=%@",token]];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&key=%@",key]];
  }
  NSURL *url = [[NSURL alloc]initWithString:urlString];
  NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
  [[[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if(error != nil){
      
    }else{
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
      switch (httpResponse.statusCode) {
        case 200:{
          NSArray *questions = [QuestionJSONParseService parseJSONForQuestion:data];
          dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(questions, nil);
          });
          
        }
          break;
          
        default:
          break;
      }
    }
  }] resume];
}

+(void)fetchUserLoggedIn:(void (^)(User *, NSString*))completionHandler{
  NSString *urlString = @"https://api.stackexchange.com/2.2/me?order=desc&sort=reputation&site=stackoverflow";
  NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
  if(token){
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&access_token=%@",token]];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&key=%@",key]];
  }
  NSURL *url = [[NSURL alloc]initWithString:urlString];
  NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
  [[[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if(error != nil){
      
    }else{
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
      switch (httpResponse.statusCode) {
        case 200:{
          User *user = [UserJSONParseService parseJSONForUser:data];
          dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(user, nil);
          });
          
        }
          break;
          
        default:
          break;
      }
    }
  }] resume];
}
@end
