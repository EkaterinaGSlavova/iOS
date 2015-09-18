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

- (NSString *)kindForDisplay {
    
    if ([self.kind isEqualToString:@"album"]) {
        return @"Album";
    } else if ([self.kind isEqualToString:@"audiobook"]) {
        return @"Audio Book";
    } else if ([self.kind isEqualToString:@"book"]) {
        return @"Book";
    } else if ([self.kind isEqualToString:@"ebook"]) {
        return @"E-Book";
    } else if ([self.kind isEqualToString:@"feature-movie"]) {
        return @"Movie";
    } else if  ([self.kind isEqualToString:@"music-video"]){
        return @"Music Video";
    } else if ([self.kind isEqualToString:@"podcast"]) {
        return @"Podcast";
    } else if ([self.kind isEqualToString: @"software"]) {
        return @"Software";
    } else if ([self.kind isEqualToString:@"song"]) {
        return @"Song";
    } else if ([self.kind isEqualToString:@"tv-episode"]) {
        return @"TV Episode";
    } else {
        return self.kind;
    }
}

@end
