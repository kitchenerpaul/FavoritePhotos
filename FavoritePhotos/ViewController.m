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

        self.arrayOfPhotos = [NSMutableArray new];

        dispatch_async(dispatch_get_main_queue(), ^{

            self.imageView.image = [UIImage imageWithData:data];

        });
    }] resume];




    self.searchTextField.text = @"";

    return 0;
}

@end



//    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation ([UIImage imageWithData:[NSData dataWithContentsOfURL:url]], 1.0f)];
//
//    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        self.allPhotosDictionary = [NSDictionary new];
//        self.allPhotosDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//
//        self.arrayOfPhotoDictionaries = [NSMutableArray new];
//        self.arrayOfPhotoDictionaries = [self.allPhotosDictionary objectForKey:@"data"];
//
//        self.arrayOfPhotos = [NSMutableArray new];
//
//        for (NSDictionary *temporaryDictionary in self.arrayOfPhotoDictionaries) {
//            Photo *photo = [[Photo alloc]initWithContentsOfDictionary:temporaryDictionary];
//        }
//    }] resume];