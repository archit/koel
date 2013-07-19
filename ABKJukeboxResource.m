//
//  ABKJukeboxResource.m
//  Koel
//
//  Created by Archit Baweja on 7/18/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import "ABKJukeboxResource.h"
#import "AFNetworking.h"
#import "ABKSongResource.h"

static NSString * const kWarbleJukeboxBaseUrl = @"http://warble.local:3000/jukebox";

@implementation ABKJukeboxResource

@synthesize currentSong = _currentSong;

+ (ABKJukeboxResource *)sharedClient {
    static ABKJukeboxResource *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ABKJukeboxResource alloc] initWithBaseURL:[NSURL URLWithString:kWarbleJukeboxBaseUrl]];
    });
    
    return _sharedClient;
}

-(id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

+(void)getCurrentPlayWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id JSON))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSLog(@"Fetching jukebox state...");
    ABKJukeboxResource *client = [ABKJukeboxResource sharedClient];
    return [client getPath:nil parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        // Save latest song received.
        [client setCurrentSong:[JSON valueForKeyPath:@"current_play"]];
        success(operation, JSON);
    } failure:failure];
}

+(void)setVolume:(int)level
{
    NSLog(@"Send volume=%i", level);
    ABKJukeboxResource *client = [ABKJukeboxResource sharedClient];
    [client putPath:@"volume" parameters:@{@"value": [NSString stringWithFormat:@"%d",level]} success:nil failure:nil];
}

+(void)skipSong
{
    NSLog(@"Skipping song...");
    ABKJukeboxResource *client = [ABKJukeboxResource sharedClient];
    return [client postPath:@"skip" parameters:nil success:nil failure:nil];
}

+(void)likeSong
{
    NSLog(@"Liking song...");
    ABKJukeboxResource *client = [ABKJukeboxResource sharedClient];
    NSString *songId = [[client currentSong] valueForKey:@"id"];
    return [ABKSongResource likeSongWithId:songId];
}
@end
