//
//  SearchResultsCell.m
//  StoreSearch
//
//  Created by Ekaterina on 9/15/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import "SearchResultCell.h"
#import "SearchResult.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation SearchResultCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectZero];
    selectedView.backgroundColor = [UIColor colorWithRed:20/255.0f green:160/255.0f blue:160/255.0f alpha:1.0f];
    self.selectedBackgroundView = selectedView;
}

- (void)configureForSearchResult:(SearchResult *)searchResult {
    
    self.nameLabel.text = searchResult.name;
    
    NSString *artistName = searchResult.artistName;
    if (artistName == nil) {
        artistName = @"Unknown";
    }
    
    NSString *kind = [searchResult kindForDisplay];
    self.artistNameLabel.text = [NSString stringWithFormat:@"%@ (%@)", artistName, kind];
    
    [self.artworkImageView setImageWithURL:[NSURL URLWithString:searchResult.artworkURL60] placeholderImage:[UIImage imageNamed:@"Placeholder"]];

  
}

- (void)prepareForReuse {

    [super prepareForReuse];
    [self.artworkImageView cancelImageRequestOperation];
    self.nameLabel.text = nil;
    self.artistNameLabel.text = nil;
    
    //NSLog(@"Triggerred the PrepareForReuse method");
}

@end
