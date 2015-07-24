//
//  LoginViewController.m
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 12..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import "LoginViewController.h"
#import "OAuthWebViewController.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  CAGradientLayer *gradient = [CAGradientLayer layer];
  gradient.frame = self.view.bounds;
  gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor orangeColor] CGColor], (id)[[UIColor grayColor] CGColor], nil];
  [self.view.layer insertSublayer:gradient atIndex:0];
    // Do any additional setup after loading the view.
}
- (IBAction)loginButtonPressed:(id)sender {
  OAuthWebViewController *oauthWebVC = [[OAuthWebViewController alloc]init];
  oauthWebVC.view.frame = self.view.frame;
  [self presentViewController:oauthWebVC animated:true completion:^{
    
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
