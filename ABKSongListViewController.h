//
//  ABKSongListViewController.h
//  Koel
//
//  Created by Archit Baweja on 7/20/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPullToRefresh.h"

@interface ABKSongListViewController : UITableViewController <SSPullToRefreshViewDelegate>

@property (strong, nonatomic) SSPullToRefreshView *pullToRefresh;

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view;
- (void)viewWillAppear:(BOOL)animated;
- (void)showSongPicker:(id)sender;

@end
