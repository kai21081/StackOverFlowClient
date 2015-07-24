//
//  QuestionCell.h
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 14..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *votesCount;
@property (weak, nonatomic) IBOutlet UILabel *answerCount;
@property (weak, nonatomic) IBOutlet UILabel *viewCount;
//@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *reputationLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@end
