//
//  ViewController.m
//  FavoritePhotos
//
//  Created by Paul Kitchener on 10/17/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"

@interface ViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property NSDictionary *allPhotosDictionary;
@property NSMutableArray *arrayOfPhotoDictionaries;
@property NSMutableArray *arrayOfPhotos;

@property UISwipeGestureRecognizer *swipeLeft;
@property UISwipeGestureRecognizer *swipeRight;

@property int swipeCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    self.swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.swipeLeft];

    self.swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(didSwipe:)];
    self.swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.swipeRight];

    }

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=51fd729b24e9432fb32af5cbf7399474", self.searchTextField.text];
    NSURL *url = [NSURL URLWithString:urlString];

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        self.allPhotosDictionary = [NSDictionary new];
        self.allPhotosDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        self.arrayOfPhotoDictionaries = [NSMutableArray new];
        self.arrayOfPhotoDictionaries = [self.allPhotosDictionary objectForKey:@"data"];

        NSLog(@"%@", [[[self.arrayOfPhotoDictionaries valueForKey:@"images"] valueForKey:@"low_resolution"] valueForKey:@"url"]);

        self.arrayOfPhotos = [[NSMutableArray alloc] initWithCapacity:10];
        self.arrayOfPhotos = [[[self.arrayOfPhotoDictionaries valueForKey:@"images"] valueForKey:@"low_resolution"] valueForKey:@"url"];

        dispatch_async(dispatch_get_main_queue(), ^{

            [self iterateThroughPhotos];

        });
    }] resume];

    self.searchTextField.text = @"";
    return 0;
}

- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    int i = self.swipeCount;

    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {

        if (self.swipeCount == 0) {
            self.swipeCount = 1;
        }

        NSLog(@"Swipe Left");
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.arrayOfPhotos objectAtIndex:i]]]];
        self.swipeCount--;
        NSLog(@"%i", i);
    }

    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {

        if (self.swipeCount == 10) {
            self.swipeCount = -1;
        }

        NSLog(@"Swipe Right");
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.arrayOfPhotos objectAtIndex:i]]]];
        self.swipeCount++;
        NSLog(@"%i", i);
        }

}

-(void)iterateThroughPhotos {

    NSLog(@"Reaches here");
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.arrayOfPhotos objectAtIndex:0]]]];

}

@end
//
//if (self.swipeRight) {
//    NSLog(@"reaches swiperight method");
//
//    for (int i=0; i<[self.arrayOfPhotos count]; i++) {
//        NSLog(@"%d: %@", i, self.arrayOfPhotos[i]);
//        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.arrayOfPhotos objectAtIndex:0]]]];
//    }
//    //                self.photoNumber = 0;
//    //                [self.arrayOfPhotos objectAtIndex:0] + 1;
//    //                self.photoNumber--;
//}