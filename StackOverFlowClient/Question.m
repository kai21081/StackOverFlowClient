//
//  Question.m
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 13..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import "Question.h"

@implementation Question

-(instancetype)initWithUserID:(NSString *)user_id questionID:(NSString *)question_id{
  self.user_id = user_id;
  self.question_id = question_id;
  return self;
}
@end
