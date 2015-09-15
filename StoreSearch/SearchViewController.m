//
//  SearchViewController.m
//  StoreSearch
//
//  Created by Ekaterina on 9/15/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResult.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation SearchViewController {
    
    NSMutableArray *_searchBarResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_searchBarResults == nil) {
        return 0;
    }else if ([_searchBarResults count] == 0) {
        return 1;
    } else {
        return [_searchBarResults count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SearchResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if ([_searchBarResults count] == 0) {
        cell.textLabel.text = @"(Nothing Found)";
        cell.detailTextLabel.text = @"";
    } else {
    SearchResult *searchResult = _searchBarResults[indexPath.row];
    cell.textLabel.text = searchResult.name;
    cell.detailTextLabel.text = searchResult.artistName;
    }
    return cell;
}
#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    _searchBarResults = [NSMutableArray arrayWithCapacity:10];
    
    if (![searchBar.text isEqualToString:@"justin bieber"]) {
    for (int i = 0; i < 3; i++) {
        
        SearchResult *searchResult = [[SearchResult alloc] init];
        searchResult.name = [NSString stringWithFormat:@"Fake Result %d for", i];
        searchResult.artistName = searchBar.text;
        [_searchBarResults addObject:searchResult];
    }
}
    [self.tableView reloadData];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    
    return UIBarPositionTopAttached;
}

#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_searchBarResults count] == 0) {
        return nil;
    } else {
        return indexPath;
    }
}
@end
