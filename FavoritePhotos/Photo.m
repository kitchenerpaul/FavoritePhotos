//
//  Photo.m
//  FavoritePhotos
//
//  Created by Paul Kitchener on 10/17/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype)initWithContentsOfDictionary:(NSDictionary *)photoDictionary {

    self = [super init];

    if (self) {
//        self.tag = [[[photoDictionary objectForKey:@"data"] objectForKey:@"tags"] firstObject];
        self.image = [[[[photoDictionary objectForKey:@"data"] objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"];
    }

    return self;
}

@end