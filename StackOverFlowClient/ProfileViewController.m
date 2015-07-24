//
//  ProfileViewController.m
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 18..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import "ProfileViewController.h"
#import "StackOverFlowService.h"
#import "User.h"

@interface ProfileViewController ()
@property (assign, nonatomic) IBOutlet UIImageView *profileImage;
@property (assign, nonatomic) IBOutlet UIView *goldImageView;
@property (assign, nonatomic) IBOutlet UIView *silverImageView;
@property (assign, nonatomic) IBOutlet UIView *bronzeImageView;
@property (assign, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (assign, nonatomic) IBOutlet UILabel *goldBadgeCount;
@property (assign, nonatomic) IBOutlet UILabel *silverBadgeCount;
@property (assign, nonatomic) IBOutlet UILabel *bronzeBadgeCount;
@property (retain, nonatomic) User* user;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [StackOverFlowService fetchUserLoggedIn:^(User *user, NSString *error) {
    self.user = user;
    self.displayNameLabel.text = self.user.display_name;
    self.goldImageView.layer.cornerRadius = self.goldImageView.frame.size.width/2;
    self.silverImageView.layer.cornerRadius = self.silverImageView.frame.size.width/2;
    self.bronzeImageView.layer.cornerRadius = self.bronzeImageView.frame.size.width/2;
    self.goldBadgeCount.text = [NSString stringWithFormat:@"%d",self.user.gold_badge_count];
    self.silverBadgeCount.text = [NSString stringWithFormat:@"%d",self.user.silver_badge_count];
    self.bronzeBadgeCount.text = [NSString stringWithFormat:@"%d",self.user.bronze_badge_count];
  }];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
  [super viewWillAppear:animated];
  [self.user release];
  
}

@end
