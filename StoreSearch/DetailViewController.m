//
//  DetailViewController.m
//  StoreSearch
//
//  Created by Ekaterina on 9/18/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
}
- (void)dealloc {
    
    NSLog(@"dealloc %@", self);
}
@end
