//
//  ABKWarbleResource.m
//  Koel
//
//  Created by Archit Baweja on 7/18/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import "ABKWarbleResource.h"
#import "AFNetworking.h"

static NSString * const kWarbleJukeboxBaseUrl = @"http://warble.local:3000";

@implementation ABKWarbleResource

@synthesize currentSong = _currentSong;
@synthesize songQueue = _songQueue;

+(ABKWarbleResource *)sharedClient {
    static ABKWarbleResource *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ABKWarbleResource alloc] initWithBaseURL:[NSURL URLWithString:kWarbleJukeboxBaseUrl]];
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
    ABKWarbleResource *client = [ABKWarbleResource sharedClient];
    return [client getPath:@"jukebox" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        // Save latest song received.
        [client setCurrentSong:[JSON valueForKeyPath:@"current_play"]];
        success(operation, JSON);
    } failure:failure];
}

+(void)setVolume:(int)level
{
    NSLog(@"Send volume=%i", level);
    ABKWarbleResource *client = [ABKWarbleResource sharedClient];
    [client putPath:@"jukebox/volume" parameters:@{@"value": [NSString stringWithFormat:@"%d",level]} success:nil failure:nil];
}

+(void)skipSong
{
    NSLog(@"Skipping song...");
    ABKWarbleResource *client = [ABKWarbleResource sharedClient];
    return [client postPath:@"jukebox/skip" parameters:nil success:nil failure:nil];
}

+(void)likeSong
{
    NSLog(@"Liking song...");
    ABKWarbleResource *client = [ABKWarbleResource sharedClient];
    NSString *songId = [[client currentSong] valueForKey:@"id"];
    [client postPath:[NSString stringWithFormat:@"songs/%@/votes", songId] parameters:nil success:nil failure:nil];
}

+(NSArray *)songQueue
{
    return [[ABKWarbleResource sharedClient] songQueue];
}
+(NSUInteger)getQueueLength
{
    return [ABKWarbleResource sharedClient].songQueue.count;
}

+(void)getQueueWithSuccess:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSLog(@"Getting song queue...");
    ABKWarbleResource *client = [ABKWarbleResource sharedClient];
    [client getPath:nil parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        // Save song queue received.
        [client setSongQueue:[JSON valueForKeyPath:@""]];
        success(operation, JSON);
    } failure:failure];
}

@end
