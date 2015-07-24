//
//  BurgerContainerViewController.m
//  
//
//  Created by Jisoo Hong on 2015. 5. 11..
//
//

#import "BurgerContainerViewController.h"
#import "MainMenuViewController.h"
#import "SearchQuestionsViewController.h"
#import "MyQuestionsViewController.h"
#import "MenuSelectionDelegate.h"
#import "ProfileViewController.h"

@interface BurgerContainerViewController ()<MenuSelectionDelegate>

@property (strong, nonatomic) UIViewController *topViewController;
@property (strong, nonatomic) UITapGestureRecognizer *tapToClose;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) UIButton *burgerMenu;
@property (strong, nonatomic) UINavigationController *searchQuestionsVC;
@property (strong, nonatomic) MyQuestionsViewController *myQuestionsVC;
@property (strong, nonatomic) ProfileViewController *profileVC;

@end

@implementation BurgerContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  MainMenuViewController *mainMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuVC"];
  [self addChildViewController:mainMenuVC];
  mainMenuVC.view.frame = self.view.frame;
  [self.view addSubview:mainMenuVC.view];
  [mainMenuVC didMoveToParentViewController:self];
  mainMenuVC.delegate = self;
    // Do any additional setup after loading the view.
  
  self.searchQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchQuestionsVC"];
  [self addChildViewController:self.searchQuestionsVC];
  self.searchQuestionsVC.view.frame = self.view.frame;
  [self.view addSubview:self.searchQuestionsVC.view];
  [self.searchQuestionsVC didMoveToParentViewController:self];
  self.topViewController = self.searchQuestionsVC;
  
  self.burgerMenu = [[UIButton alloc]initWithFrame:CGRectMake(8, 8, 50, 50)];
  [self.burgerMenu setBackgroundImage:[UIImage imageNamed:@"burgerIcon"] forState:UIControlStateNormal];
  [self.burgerMenu addTarget:self action:@selector(burgerMenuPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.topViewController.view addSubview:self.burgerMenu];
  
  self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
  [self.topViewController.view addGestureRecognizer:self.panGesture];
  
  self.tapToClose = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTopViewTap:)];
}

- (void)burgerMenuPressed{
  self.burgerMenu.userInteractionEnabled = false;
  [UIView animateWithDuration:0.3 animations:^{
    self.topViewController.view.frame = CGRectMake(self.view.frame.size.width * 0.80, 0, self.topViewController.view.frame.size.width, self.topViewController.view.frame.size.height);
  } completion:^(BOOL finished) {
    [self.topViewController.view addGestureRecognizer:self.tapToClose];
  }];
  
}

- (void)handlePanGesture:(UIPanGestureRecognizer*)panGesture{
  CGPoint translatedPt = [panGesture translationInView:self.view];
  CGPoint velocity = [panGesture velocityInView:self.view];
  if (panGesture.state == UIGestureRecognizerStateChanged) {
    if (velocity.x > 0 || self.topViewController.view.frame.origin.x > 0) {
      self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x+translatedPt.x, self.topViewController.view.center.y);
      [panGesture setTranslation:CGPointZero inView:self.view];
    }
  }
  if (panGesture.state == UIGestureRecognizerStateEnded) {
    if (self.topViewController.view.frame.origin.x > self.view.frame.size.width/3) {
      [UIView animateWithDuration:0.3 animations:^{
        self.topViewController.view.frame = CGRectMake(self.view.frame.size.width * 0.80, 0, self.topViewController.view.frame.size.width, self.topViewController.view.frame.size.height);
      } completion:^(BOOL finished) {
        [self.topViewController.view addGestureRecognizer:self.tapToClose];
      }];
    }else{
      [UIView animateWithDuration:0.2 animations:^{
        self.topViewController.view.frame = self.view.frame;
      } completion:^(BOOL finished) {
        self.burgerMenu.userInteractionEnabled = true;
      }];
      
    }
  }
}

- (void)handleTopViewTap:(UITapGestureRecognizer*)tap{
  [UIView animateWithDuration:0.3 animations:^{
    self.topViewController.view.frame = self.view.frame;
  } completion:^(BOOL finished) {
    [self.topViewController.view removeGestureRecognizer:self.tapToClose];
    self.burgerMenu.userInteractionEnabled = true;
  }];
}

-(void)userDidSelectOption:(NSUInteger)selection{
  if(selection == 0){
    if(self.topViewController != self.searchQuestionsVC){
      [self switchToViewController:self.searchQuestionsVC];
      return;
    }
  }else if(selection == 1){
    if(self.topViewController != self.myQuestionsVC){
      [self switchToViewController:self.myQuestionsVC];
      return;
    }
  }else if(selection == 2){
    if(self.topViewController != self.profileVC){
      [self switchToViewController:self.profileVC];
      return;
    }
  }
}

-(void)switchToViewController:(UIViewController *)viewController{
  [UIView animateWithDuration:0.1 animations:^{
    self.topViewController.view.frame = CGRectMake(self.view.frame.size.width, self.topViewController.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
  } completion:^(BOOL finished) {
    viewController.view.frame = self.topViewController.view.frame;
    
    [self.topViewController.view removeGestureRecognizer:self.panGesture];
    [self.burgerMenu removeFromSuperview];
    [self.topViewController willMoveToParentViewController:nil];
    [self.topViewController.view removeFromSuperview];
    [self.topViewController removeFromParentViewController];
    self.topViewController = viewController;
    
    [self.topViewController.view addGestureRecognizer:self.panGesture];
    [self.topViewController.view addSubview:self.burgerMenu];
    [self.topViewController didMoveToParentViewController:self];
    [self.view addSubview:self.topViewController.view];
    [self addChildViewController:self.topViewController];
    
    [UIView animateWithDuration:0.3 animations:^{
      self.topViewController.view.frame = self.view.frame;
    } completion:^(BOOL finished) {
      self.burgerMenu.userInteractionEnabled = true;
    }];
    
  }];
}

-(MyQuestionsViewController *)myQuestionsVC{
  if(_myQuestionsVC != nil){
    return _myQuestionsVC;
  }else{
    _myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionsVC"];
    return _myQuestionsVC;
  }
}

-(ProfileViewController *)profileVC{
  if(_profileVC != nil){
    return _profileVC;
  }else{
    _profileVC =[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
    return _profileVC;
  }
}

@end
