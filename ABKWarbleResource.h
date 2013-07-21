//
//  ABKWarbleResource.h
//  Koel
//
//  Created by Archit Baweja on 7/18/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface ABKWarbleResource : AFHTTPClient

@property (strong, nonatomic) NSDictionary *currentSong;
@property (strong, nonatomic) NSArray *songQueue;

-(id)initWithBaseURL:(NSURL *)url;

+(void)setVolume:(int)level;
+(void)getCurrentPlayWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id JSON))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+(void)skipSong;
+(void)likeSong;

+(NSArray *)getSongQueue;
+(NSUInteger)getQueueLength;
+(void)getQueueWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id JSON))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
