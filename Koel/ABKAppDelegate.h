//
//  ABKAppDelegate.h
//  Koel
//
//  Created by Archit Baweja on 7/17/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABKJukeboxViewController;

@interface ABKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ABKJukeboxViewController *mainViewController;

@end
