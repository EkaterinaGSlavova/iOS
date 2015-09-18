//
//  DetailViewController.h
//  StoreSearch
//
//  Created by Ekaterina on 9/18/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResult;

@interface DetailViewController : UIViewController

@property (nonatomic, strong) SearchResult *searchResult;

@end
