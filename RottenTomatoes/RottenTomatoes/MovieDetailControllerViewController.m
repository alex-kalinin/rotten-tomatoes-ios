//
//  MovieDetailControllerViewController.m
//  RottenTomatoes
//
//  Created by Alex Kalinin on 9/16/14.
//  Copyright (c) 2014 Alex Kalinin. All rights reserved.
//

#import "MovieDetailControllerViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailControllerViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *posterImage;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *innerView;

@end

@implementation MovieDetailControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(320, 1100);
    
    self.innerView.frame = CGRectMake(0, 350, 320, 800);
    self.innerView.backgroundColor=[UIColor blackColor];
    self.innerView.alpha=0.75;

    self.descLabel.textColor = [UIColor whiteColor];
    self.descLabel.text = self.movieDict[@"synopsis"];
    [self.descLabel setNumberOfLines:0];
    [self.descLabel sizeToFit];

    
    // Do any additional setup after loading the view from its nib.
    [self.posterImage setImageWithURL:[NSURL URLWithString:self.movieDict[@"posters"][@"original"]]];

    NSString* str = self.movieDict[@"posters"][@"original"];
    NSString* origUrl = [str stringByReplacingOccurrencesOfString:@"_tmb" withString:@"_org"];
    [self.posterImage setImageWithURL:[NSURL URLWithString:origUrl]];
    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = self.movieDict[@"title"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
