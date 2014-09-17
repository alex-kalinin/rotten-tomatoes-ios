//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Alex Kalinin on 9/11/14.
//  Copyright (c) 2014 Alex Kalinin. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailControllerViewController.h"

@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UILabel* errorLabel;
@end

@implementation MoviesViewController
{
    NSArray* _moviesDict;
    NSString* _url;
    UIRefreshControl* _refreshControl;
}

static const NSString *API_KEY = @"7t9jf6ya8gbfzxryv9ty3gdh";

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
    [self initErrorLabel];
    
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
    self.tableView.rowHeight = 120;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
    // Initialize Refresh Control
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refreshControl];
    
    [self loadData];
}

-(void) handleRefresh
{
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (!_moviesDict) {
        self.tableView.contentOffset = CGPointMake(0, -_refreshControl.frame.size.height);
        [_refreshControl beginRefreshing];
    }
}

-(void) initErrorLabel
{
        CGRect labelFrame = CGRectMake(0, 34, 320, 30);
    UILabel* label = [[UILabel alloc] initWithFrame:labelFrame];
    [label setBackgroundColor:[UIColor redColor]];
    label.textColor=[UIColor whiteColor];
    label.textAlignment=  NSTextAlignmentCenter;
    label.text = @"Connection error";
    label.font=[UIFont systemFontOfSize:15];
    
    [self.view addSubview:label];
    label.hidden = YES;
    self.errorLabel = label;
}

-(id) initWithUrl:(NSString*)rtUrl
{
    self = [super self];
    _url = [NSString stringWithFormat:rtUrl, API_KEY];
    return self;
}

- (void) loadData
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
            [self showError];
        } else {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.errorLabel.hidden=YES;
            _moviesDict = dict[@"movies"];
            [self.tableView reloadData];
        }
        [_refreshControl endRefreshing];
    }];
}

- (void)showError
{
    self.errorLabel.hidden = NO;
    self.errorLabel.frame = CGRectMake(0, 34, 320, 30);

    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^
    {
        self.errorLabel.frame  = CGRectMake(0, 64, 320,30);
    } completion:^(BOOL finished) {
        
    }];
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailControllerViewController* detail = [MovieDetailControllerViewController new];
    detail.movieDict = _moviesDict[indexPath.row];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:true];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _moviesDict.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* movie = _moviesDict[indexPath.row];
    
    MovieCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieCell"];

    cell.titleLabel.text = movie[@"title"];
    cell.descriptionView.text = movie[@"synopsis"];
    cell.mpaaRating.text = [NSString stringWithFormat:@"%@, %@ min", movie[@"mpaa_rating"], movie[@"runtime"]];
    
    cell.posterView.alpha=0;
    [cell.posterView setImageWithURL:[NSURL URLWithString:movie[@"posters"][@"profile"]]];
    [UIView animateWithDuration:1 animations:^{
        cell.posterView.alpha=1;
    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
