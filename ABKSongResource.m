//
//  ABKSongResource.m
//  Koel
//
//  Created by Archit Baweja on 7/18/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import "ABKSongResource.h"
#import "AFNetworking.h"

static NSString * const kWarbleSongBaseUrl = @"http://warble.local:3000/songs";

@implementation ABKSongResource

+ (ABKSongResource *)sharedClient {
    static ABKSongResource *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ABKSongResource alloc] initWithBaseURL:[NSURL URLWithString:kWarbleSongBaseUrl]];
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

+(void)likeSongWithId:(id)songId
{
    ABKSongResource *client = [ABKSongResource sharedClient];
    return [client postPath:[NSString stringWithFormat:@"%@/votes", songId] parameters:nil success:nil failure:nil];
}
@end
