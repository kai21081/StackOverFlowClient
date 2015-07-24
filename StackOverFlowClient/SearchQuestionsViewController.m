//
//  SearchQuestionsViewController.m
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 12..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import "SearchQuestionsViewController.h"
#import "StackOverFlowService.h"
#import "Question.h"
#import "QuestionCell.h"
#import "ImageFetchService.h"

@interface SearchQuestionsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *questions;
@end

@implementation SearchQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.searchBar.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
    // Do any additional setup after loading the view.
}

-(NSString *)checkCount:(int)count{
  if (count > 500) {
    return @"500+";
  }
  return [NSString stringWithFormat:@"%d", count];
}

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  QuestionCell *cell = (QuestionCell*)[tableView dequeueReusableCellWithIdentifier:@"SearchQuestionCell"];
  Question *question = (Question*)self.questions[indexPath.row];
  cell.titleLabel.text = question.title;
  cell.votesCount.text = [self checkCount:question.score];
  cell.answerCount.text = [self checkCount:question.answer_count];
  cell.viewCount.text = [self checkCount:question.view_count];
  cell.reputationLabel.text = [NSString stringWithFormat:@"%d",question.user.reputation];
  cell.userIDLabel.text = question.user.display_name;
  if (question.user.profile_image == nil) {
    [ImageFetchService fetchImageWithString:question.user.profile_image_url size:CGSizeMake(30, 30) completionHandler:^(UIImage *thumbnailImage) {
      cell.profileImage.image = thumbnailImage;
      question.user.profile_image = thumbnailImage;
    }];
  }else{
    cell.profileImage.image = question.user.profile_image;
  }
  
  return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.questions.count;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
  [searchBar resignFirstResponder];
  [StackOverFlowService fetchQuestionsForSearchTerm:searchBar.text completionHandler:^(NSArray *questions, NSString *error) {
    if (error != nil) {
      //do some error checking
    }else{
      self.questions = questions;
      [self.tableView reloadData];
    }
  }];
}


@end
