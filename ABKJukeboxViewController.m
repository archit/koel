//
//  ABKJukeboxViewController.m
//  Koel
//
//  Created by Archit Baweja on 7/17/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import "ABKJukeboxViewController.h"
#import "ABKWarbleResource.h"
#import "UIImageView+AFNetworking.h"
#import "SSPullToRefresh.h"

@implementation ABKJukeboxViewController

@synthesize pullToRefresh = _pullToRefresh;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UI updaters

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.volumeControl setThumbImage:[UIImage imageNamed:@"slider-button.png"] forState:UIControlStateNormal];
    [self.volumeControl setMinimumTrackImage:[UIImage imageNamed:@"slider-bg.png"] forState:UIControlStateNormal];
    [self.volumeControl setMaximumTrackImage:[UIImage imageNamed:@"slider-bg.png"] forState:UIControlStateNormal];
    
    [(UIScrollView *)self.view setContentSize:CGSizeMake(320, 500)];
    self.pullToRefresh = [[SSPullToRefreshView alloc] initWithScrollView:(UIScrollView *)self.view delegate:(id)self];
    
    [ABKWarbleResource getCurrentPlayWithSuccess:^(AFHTTPRequestOperation *operation, id JSON) {
        [self updateViewWithJSON: JSON];
    } failure:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.pullToRefresh = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
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

#pragma mark - Event Handlers

-(IBAction)handleLikeSong:(id)sender
{
    [ABKWarbleResource likeSong];
}

-(IBAction)handleSkipSong:(id)sender
{
    [ABKWarbleResource skipSong];
}

-(IBAction)handleVolume:(UISlider *)sender
{
    [ABKWarbleResource setVolume:[sender value]];
}

-(void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view
{
    [ABKWarbleResource getCurrentPlayWithSuccess:^(AFHTTPRequestOperation *operation, id JSON) {
        [self updateViewWithJSON: JSON];
        [view finishLoading];
    } failure:nil];
}

@end
