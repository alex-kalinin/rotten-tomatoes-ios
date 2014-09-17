//
//  AppDelegate.m
//  RottenTomatoes
//
//  Created by Alex Kalinin on 9/11/14.
//  Copyright (c) 2014 Alex Kalinin. All rights reserved.
//

#import "AppDelegate.h"
#import "MoviesViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    MoviesViewController* c = [[MoviesViewController alloc]initWithUrl:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=%@"];
    c.navigationItem.title = @"Top DVDs";
    UINavigationController* nv  = [[UINavigationController alloc]initWithRootViewController:c];
    nv.tabBarItem.title=@"Top DVDs";
    nv.tabBarItem.image=[UIImage imageNamed:@"tab_bar_dvd"];
    
    MoviesViewController* moviesController = [[MoviesViewController alloc]initWithUrl:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=%@"];
    moviesController.navigationItem.title = @"Top Box Office";
    UINavigationController* moviesNv  = [[UINavigationController alloc]initWithRootViewController:moviesController];
    moviesNv.tabBarItem.title=@"Top Box Office";
    moviesNv.tabBarItem.image=[UIImage imageNamed:@"tab_bar_box"];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[moviesNv, nv];
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x3b5999)]; //background Nav bar color
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithWhite:0.95f alpha:1.0f]];  //the item bar button color
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}]; // title text color
    
    [[UITableView appearance] setBackgroundColor:UIColorFromRGB(0xeeeff4)];
    [[UITableView appearance] setTableFooterView:[[UIView alloc] init]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
