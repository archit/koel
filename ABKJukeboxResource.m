//
//  ABKJukeboxResource.m
//  Koel
//
//  Created by Archit Baweja on 7/18/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import "ABKJukeboxResource.h"
#import "AFJSONRequestOperation.h"

static NSString * const kWarbleBaseUrl = @"http://warble.local:3000/";

@implementation ABKJukeboxResource

+ (ABKJukeboxResource *)sharedClient {
    static ABKJukeboxResource *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ABKJukeboxResource alloc] initWithBaseURL:[NSURL URLWithString:kWarbleBaseUrl]];
    });
    
    return _sharedClient;
}

-(id)initWithBaseUrl:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

+(void)getCurrentPlayWithSuccess:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{
    NSURL *url = [NSURL URLWithString:@"http://warble.local:3000/jukebox"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:success failure:failure];
    
    return [operation start];
}

+(void)setVolume:(int)level
{
    NSLog(@"Send volume=%@", level);
}

@end
