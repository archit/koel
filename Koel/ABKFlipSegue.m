//
//  ABKFlipSegue.m
//  Koel
//
//  Created by Archit Baweja on 7/20/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import "ABKFlipSegue.h"

@implementation ABKFlipSegue

-(void)perform {
    UIViewController *src = (UIViewController *)self.sourceViewController;
    UIViewController *dst = (UIViewController *)self.destinationViewController;
    
    [UIView transitionWithView:src.navigationController.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                      [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:NULL];
}
@end
