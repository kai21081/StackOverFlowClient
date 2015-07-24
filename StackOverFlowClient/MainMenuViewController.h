//
//  MainMenuViewController.h
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 12..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuSelectionDelegate.h"

@interface MainMenuViewController : UITableViewController

@property (weak, nonatomic)id <MenuSelectionDelegate> delegate;
@end
