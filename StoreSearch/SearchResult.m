//
//  SearchResult.m
//  StoreSearch
//
//  Created by Ekaterina on 9/15/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

- (NSComparisonResult)compareName:(SearchResult *)other {
    
    return [self.artistName localizedStandardCompare:other.artistName];
}
@end
