//
//  ABKJukeboxViewController.m
//  Koel
//
//  Created by Archit Baweja on 7/17/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import "ABKJukeboxViewController.h"
#import "ABKJukeboxResource.h"

@interface ABKJukeboxViewController ()

@end

@implementation ABKJukeboxViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ABKJukeboxResource getCurrentPlayWithSuccess:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        id song = [JSON valueForKeyPath:@"current_play.song"];
        NSLog(@"song: %@", song);
        NSString *songName   = [song valueForKey:@"title"];
        NSString *artistName = [song valueForKey:@"artist"];
        NSString *albumName  = [JSON valueForKeyPath:@"album"];
        self.titleLabel.text = songName;
        self.albumLabel.text = albumName;
        self.artistLabel.text = artistName;
    } failure:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)handleLikeSong:(id)sender
{
    
}

-(IBAction)handleSkipSong:(id)sender
{
    
}

-(IBAction)handleVolume:(UISlider *)sender
{
    [ABKJukeboxResource setVolume:(int)[sender value]];
}

@end
