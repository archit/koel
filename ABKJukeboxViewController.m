//
//  ABKJukeboxViewController.m
//  Koel
//
//  Created by Archit Baweja on 7/17/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import "ABKJukeboxViewController.h"
#import "ABKJukeboxResource.h"
#import "UIImageView+AFNetworking.h"

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
    [self.volumeControl setThumbImage:[UIImage imageNamed:@"slider-button.png"] forState:UIControlStateNormal];
    [self.volumeControl setMinimumTrackImage:[UIImage imageNamed:@"slider-bg.png"] forState:UIControlStateNormal];
    [self.volumeControl setMaximumTrackImage:[UIImage imageNamed:@"slider-bg.png"] forState:UIControlStateNormal];
    [ABKJukeboxResource getCurrentPlayWithSuccess:^(AFHTTPRequestOperation *operation, id JSON) {
        [self updateViewWithJSON: JSON];
    } failure:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)handleLikeSong:(id)sender
{
    [ABKJukeboxResource likeSong];
}

-(IBAction)handleSkipSong:(id)sender
{
    [ABKJukeboxResource skipSong];
}

-(IBAction)handleVolume:(UISlider *)sender
{
    [ABKJukeboxResource setVolume:[sender value]];
}

-(void)updateViewWithJSON:(id)JSON
{
    id song = [JSON valueForKeyPath:@"current_play.song"];
    [self updateSongDetails:song];
    [self updateVolume:[[JSON valueForKey:@"volume"] floatValue]];
}

-(void)updateSongDetails:(id)song
{
    NSLog(@"song: %@", song);
    NSString *songName   = [song valueForKey:@"title"];
    NSString *artistName = [song valueForKey:@"artist"];
    NSString *albumName  = [song valueForKey:@"album"];
    NSString *cdArtUrl   = [song valueForKey:@"cover_url"];
    if (![[NSNull null] isEqual:songName])
        self.titleLabel.text = songName;
    if (![[NSNull null] isEqual:albumName])
        self.albumLabel.text = albumName;
    if (![[NSNull null] isEqual:artistName])
        self.artistLabel.text = artistName;
    if (![[NSNull null] isEqual:cdArtUrl])
        [self.cdArt setImageWithURL:[NSURL URLWithString:cdArtUrl]];
}

-(void)updateVolume:(float)level
{
    [self.volumeControl setValue:level animated:YES];
}

@end
