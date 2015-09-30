//
//  AppDelegate.h
//  StoreSearch
//
//  Created by Ekaterina on 9/15/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SearchViewController *searchViewController;
@property (strong, nonatomic) UISplitViewController *splitViewController;

@end

