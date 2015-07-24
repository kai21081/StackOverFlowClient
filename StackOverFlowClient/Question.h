//
//  Question.h
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 13..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface Question : NSObject

@property (nonatomic) BOOL is_answered;
@property (nonatomic) int view_count;
@property (nonatomic) int answer_count;
@property (nonatomic) int score;
@property (strong, nonatomic) NSDate *last_activity_date;
@property (strong, nonatomic) NSDate *create_date;
@property (strong, nonatomic) NSString *question_id;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) User *user;

-(instancetype)initWithUserID:(NSString *)user_id questionID:(NSString *)question_id;

@end
