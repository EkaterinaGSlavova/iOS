//
//  LandscapeViewController.h
//  StoreSearch
//
//  Created by Ekaterina on 9/28/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Search;

@interface LandscapeViewController : UIViewController

@property (nonatomic, strong) Search *search;

- (void)searchResultsReceived;

@end
