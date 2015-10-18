//
//  Photo.h
//  FavoritePhotos
//
//  Created by Paul Kitchener on 10/17/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property BOOL *isFavorite;
@property UIImage *image;

-(instancetype)initWithContentsOfDictionary:(NSDictionary *)photoDictionary;

@end
