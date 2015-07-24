//
//  QuestionJSONParseService.m
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 13..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import "QuestionJSONParseService.h"
#import "Question.h"
#import "User.h"

@implementation QuestionJSONParseService

+(NSArray *) parseJSONForQuestion:(NSData *)data{
  
  NSMutableArray *questions = [[NSMutableArray alloc]init];
  NSError *error;
  NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  //NSLog(@"%@",jsonObject);
  NSArray *items = [jsonObject objectForKey:@"items"];
  for (NSDictionary *item in items){
    NSString *question_id = (NSString*)[item objectForKey:@"question_id"];
    NSDictionary *owner = [item objectForKey:@"owner"];
    NSString *user_id = (NSString*)[owner objectForKey:@"user_id"];
    User *user = [[User alloc]init];
    Question *question = [[Question alloc]initWithUserID:user_id questionID:question_id];
    question.create_date = [NSDate dateWithTimeIntervalSince1970:(int)[item objectForKey:@"creation_date"]];
    question.last_activity_date = [NSDate dateWithTimeIntervalSince1970:(int)[item objectForKey:@"last_activity_date"]];
    question.is_answered = (BOOL)[item objectForKey:@"is_answered"];
    question.link = (NSString*)[item objectForKey:@"link"];
    question.title = (NSString*)[item objectForKey:@"title"];
    question.title = [question.title stringByReplacingOccurrencesOfString:@"&#39;"
                                   withString:@"\""];
    question.title = [question.title stringByReplacingOccurrencesOfString:@"&quot;"
                                                               withString:@"\'"];
    question.view_count = (int)[item objectForKey:@"view_count"];
    question.answer_count = (int)[item objectForKey:@"answer_count"];
    question.score = (int)[item objectForKey:@"score"];
    
    user.display_name = (NSString *)[owner objectForKey:@"display_name"];
    user.link = (NSString *)[owner objectForKey:@"link"];
    user.profile_image_url = (NSString *)[owner objectForKey:@"profile_image"];
    user.reputation = (int)[item objectForKey:@"reputation"];
    user.user_id = user_id;
    question.user = user;
    [questions addObject:question];
  }
  return questions;
}
@end
