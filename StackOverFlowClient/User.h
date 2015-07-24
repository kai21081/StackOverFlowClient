//
//  User.h
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 14..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *profile_image_url;
@property (strong, nonatomic) UIImage *profile_image;
@property (strong, nonatomic) NSString *display_name;
@property (strong, nonatomic) NSString *link;
@property (nonatomic) int reputation;
@property (nonatomic) int bronze_badge_count;
@property (nonatomic) int silver_badge_count;
@property (nonatomic) int gold_badge_count;

@end
