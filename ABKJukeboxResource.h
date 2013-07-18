//
//  ABKJukeboxResource.h
//  Koel
//
//  Created by Archit Baweja on 7/18/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface ABKJukeboxResource : AFHTTPClient

+(void)setVolume:(int)level;
+(void)getCurrentPlayWithSuccess:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                         failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure;
@end
