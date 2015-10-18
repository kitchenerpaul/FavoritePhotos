//
//  ViewController.m
//  FavoritePhotos
//
//  Created by Paul Kitchener on 10/17/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "FavoritesViewController.h"

@interface ViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *starImage;

@property NSDictionary *allPhotosDictionary;
@property NSMutableArray *arrayOfPhotoDictionaries;
@property NSMutableArray *arrayOfPhotos;
@property NSMutableArray *arrayOfFavoritePhotos;

@property UISwipeGestureRecognizer *swipeLeft;
@property UISwipeGestureRecognizer *swipeRight;

@property int swipeCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTextField.delegate = self;
    self.starImage.hidden = YES;

    self.swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeL:)];
    self.swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.swipeLeft];

    self.swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(didSwipeR:)];
    self.swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.swipeRight];

}

//-(void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (textField.text.length > 0) {
//        self.starImage.hidden = YES;
//    }
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=51fd729b24e9432fb32af5cbf7399474", self.searchTextField.text];
    NSURL *url = [NSURL URLWithString:urlString];

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        self.allPhotosDictionary = [NSDictionary new];
        self.allPhotosDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        self.arrayOfPhotoDictionaries = [NSMutableArray new];
        self.arrayOfPhotoDictionaries = [self.allPhotosDictionary objectForKey:@"data"];

        self.arrayOfPhotos = [[NSMutableArray alloc] init];
        self.arrayOfPhotos = [[[self.arrayOfPhotoDictionaries valueForKey:@"images"] valueForKey:@"low_resolution"] valueForKey:@"url"];

        dispatch_async(dispatch_get_main_queue(), ^{

            [self iterateThroughPhotos];

        });
    }] resume];

    self.starImage.hidden = NO;
    self.searchTextField.text = @"";
    return 0;
}

- (void)didSwipeL:(UISwipeGestureRecognizer*)swipe{
    int i = self.swipeCount;
    self.starImage.highlighted = NO;

    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {

        if (self.swipeCount == 0) {
            self.swipeCount = 1;
        }
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.arrayOfPhotos objectAtIndex:i]]]];
        self.swipeCount--;
    }
}

- (void)didSwipeR:(UISwipeGestureRecognizer*)swipe{
    int i = self.swipeCount;
    self.starImage.highlighted = NO;

    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {

        if (self.swipeCount == 10) {
            self.swipeCount = 9;
        }
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.arrayOfPhotos objectAtIndex:i]]]];
        self.swipeCount++;
    }
}

-(void)iterateThroughPhotos {

    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.arrayOfPhotos objectAtIndex:0]]]];
}

- (IBAction)favoritesButtonPressed:(id)sender {

    if (self.starImage.highlighted == YES) {
        self.starImage.highlighted = NO;
    } else if (self.starImage.highlighted == NO) {
        self.starImage.highlighted = YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FavoritesViewController *favViewController = segue.destinationViewController;
    favViewController.ArrayOfFavoritePhotos = self.arrayOfFavoritePhotos;

}


@end