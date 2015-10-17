//
//  ViewController.m
//  FavoritePhotos
//
//  Created by Paul Kitchener on 10/17/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@property NSDictionary *allPhotosDictionary;
@property NSMutableArray *arrayOfPhotoDictionaries;
@property NSMutableArray *arrayOfPhotos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self loadJSONData];


}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Worked");

    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=51fd729b24e9432fb32af5cbf7399474", self.searchTextField.text];
    NSURL *url = [NSURL URLWithString:urlString];

    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation ([UIImage imageWithData:[NSData dataWithContentsOfURL:url]], 1.0f)];

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        self.allPhotosDictionary = [NSDictionary new];
        self.allPhotosDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        self.arrayOfPhotoDictionaries = [NSMutableArray new];
        self.arrayOfPhotoDictionaries = [self.allPhotosDictionary objectForKey:@"data"];

        self.arrayOfPhotos = [NSMutableArray new];

        for (NSDictionary *temporaryDictionary in self.arrayOfPhotoDictionaries) {
            Photo *photo = [[Photo alloc]initWithContentsOfDictionary:temporaryDictionary];
        }
    }] resume];

    self.searchTextField.text = @"";

    return 0;
}

@end

_____checkinggitHub

//for (NSDictionary *temporaryDictionary in self.arrayOfPhotoDictionaries) {
//    Photo *photo = [[Photo alloc]initWithContentsOfDictionary:temporaryDictionary];
//
//    if (self.arrayOfPhotos.count < 10) {
//
//        for (int i = 0; i < 10; i++) {
//            [self.arrayOfPhotos addObject:photo];
//            self.imageView.image = [UIImage imageWithData:imageData];
//        }
//    }
//
//    NSLog(@"%lu",self.arrayOfPhotos.count);
//    NSLog(@"%@", self.arrayOfPhotos.description);
//}