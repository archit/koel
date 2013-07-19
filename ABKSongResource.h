//
//  ABKSongResource.h
//  Koel
//
//  Created by Archit Baweja on 7/18/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#include <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface ABKSongResource : AFHTTPClient

+(void)likeSongWithId:(id)songId;

@end
