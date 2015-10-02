//
//  UISplitViewControllerDelegateService.m
//  StoreSearch
//
//  Created by Ekaterina on 10/1/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import "UISplitViewControllerDelegateService.h"
#import "DetailViewController.h"
#import "SearchViewController.h"

@interface UISplitViewControllerDelegateService () <UISplitViewControllerDelegate>

@property (nonatomic, weak) UISplitViewController *splitViewController;

@end

@implementation UISplitViewControllerDelegateService

- (id)initWithSplitViewController:(UISplitViewController *)controller {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.splitViewController = controller;
    controller.delegate = self;
    return self;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(DetailViewController *)detailViewController ontoPrimaryViewController:(SearchViewController *)searchViewController {
    
    if ([detailViewController isKindOfClass:[UINavigationController class]]
        && [[(UINavigationController *)detailViewController topViewController] isKindOfClass:[DetailViewController class]])
        /*&& ((DetailViewController *)[(UINavigationController *)detailViewController topViewController] == nil))*/ {
        // If the detail controller doesn't have an item, display the primary view controller instead
        return YES;
    }
    
    return NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
