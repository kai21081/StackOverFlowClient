//
//  OAuthWebViewController.m
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 12..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import "OAuthWebViewController.h"
#import <WebKit/WebKit.h>
#import "BurgerContainerViewController.h"
#import "AppDelegate.h"

@interface OAuthWebViewController ()<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation OAuthWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.webView = [[WKWebView alloc]initWithFrame:self.view.frame];
  [self.webView setBackgroundColor:[UIColor whiteColor]];
  [self.view addSubview:self.webView];
  self.webView.navigationDelegate = self;
  NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://stackexchange.com/oauth/dialog?client_id=4798&scope=no_expiry&redirect_uri=https://stackexchange.com/oauth/login_success"]];
  [self.webView loadRequest:request];
    // Do any additional setup after loading the view.
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
  decisionHandler(WKNavigationActionPolicyAllow);
  NSURLRequest *request = navigationAction.request;
  NSURL *url = request.URL;
  NSLog(@"%@", url);
  
  if([[url description] containsString:@"access_token"]){
    NSArray *urlComponents = [[url description] componentsSeparatedByString:@"="];
    NSString *token = urlComponents.lastObject;
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
  }
  OAuthWebViewController *__weak weakSelf = self;
  if (![self.presentedViewController isBeingDismissed])
  {
    [self dismissViewControllerAnimated:true completion:^{
      AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
      UIWindow *window = appDelegate.window;
      BurgerContainerViewController *BurgerContainerVC = [window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"BurgerContainerVC"];
      [UIView transitionFromView:weakSelf.view toView:BurgerContainerVC.view duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
        window.rootViewController = BurgerContainerVC;
      }];
    }];
  }
}

@end
