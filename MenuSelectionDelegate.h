//
//  MenuSelectionDelegate.h
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 13..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuSelectionDelegate <NSObject>

-(void)userDidSelectOption:(NSUInteger)selection;

@end
