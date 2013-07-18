//
//  ABKJukeboxViewController.h
//  Koel
//
//  Created by Archit Baweja on 7/17/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABKJukeboxViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UILabel *albumLabel;
@property (strong, nonatomic) IBOutlet UIImageView *cdArt;
@property (strong, nonatomic) IBOutlet UISlider *volumeControl;
@property (strong, nonatomic) IBOutlet UIButton *likeSong;
@property (strong, nonatomic) IBOutlet UIButton *skipSong;

-(IBAction)handleSkipSong:(id)sender;
-(IBAction)handleLikeSong:(id)sender;
-(IBAction)handleVolume:(id)sender;
@end
