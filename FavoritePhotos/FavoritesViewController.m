//
//  FavoritesViewController.m
//  FavoritePhotos
//
//  Created by Paul Kitchener on 10/18/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *favoritesImageView;


@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Favorite Photos";



}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ArrayOfFavoritePhotos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FavoritePhotoCellID" forIndexPath:indexPath];

//    UIImageView *imageView = [self.ArrayOfFavoritePhotos objectAtIndex:indexPath.row];

//    cell.imageview.image = imageView.image;
//    cell.backgroundColor = picture.frameColor;

    return cell;
}

@end
