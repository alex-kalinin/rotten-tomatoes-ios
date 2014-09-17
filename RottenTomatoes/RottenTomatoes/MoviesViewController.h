//
//  MoviesViewController.h
//  RottenTomatoes
//
//  Created by Alex Kalinin on 9/11/14.
//  Copyright (c) 2014 Alex Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
-(id) initWithUrl:(NSString*)rtUrl;
@end
