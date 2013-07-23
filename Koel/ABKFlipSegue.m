//
//  ABKFlipSegue.m
//  Koel
//
//  Created by Archit Baweja on 7/20/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import "ABKFlipSegue.h"
#import "ABKSongListViewController.h"

@implementation ABKFlipSegue

-(void)perform {
    UIViewController *src = (UIViewController *)self.sourceViewController;
    UIViewController *dst = (UIViewController *)self.destinationViewController;
    
    UIViewAnimationOptions animation;
    if ([src isKindOfClass:[ABKSongListViewController class]]) {
        animation = UIViewAnimationOptionTransitionFlipFromLeft;
    } else {
        animation = UIViewAnimationOptionTransitionFlipFromRight;
    }

    [UIView transitionWithView:src.navigationController.view
                      duration:0.4
                       options:animation
                    animations:^{
                      [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:NULL];
}
@end
