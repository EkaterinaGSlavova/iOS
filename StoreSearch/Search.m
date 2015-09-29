//
//  Search.m
//  StoreSearch
//
//  Created by Ekaterina on 9/29/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "Search.h"
#import "SearchResult.h"

static NSOperationQueue *queue = nil;

@interface Search ()

@property (nonatomic, readwrite, strong) NSMutableArray *searchResults;

@end

@implementation Search

- (void)dealloc {
    
    NSLog(@"dealloc %@", self);
}

+ (void)initialize {
    if (self == [Search class]) {
        queue = [[NSOperationQueue alloc]init];
    }
}
- (void)performSearchForText:(NSString *)text category:(NSInteger)category completion:(SearcgBlock)block {
    
    if ([text length] > 0) {
        [queue cancelAllOperations];
        
        self.isLoading = YES;
        self.searchResults = [NSMutableArray arrayWithCapacity:10];
        
        NSURL *url = [self urlWithSearchText:text category:category];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self parseDictionary:responseObject];
            [self.searchResults sortUsingSelector:@selector(compareName:)];
            
            self.isLoading = NO;
            block(YES);
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (!operation.isCancelled) {
                self.isLoading = NO;
                block(NO);
            }
        }];
        [queue addOperation:operation];
    }
}

- (NSURL *)urlWithSearchText:(NSString *)searchText category:(NSInteger)category {
    
    NSString *categoryName;
    switch (category) {
        case 0:
            categoryName = @"";
            break;
        case 1:
            categoryName = @"musicTrack";
            break;
        case 2:
            categoryName = @"software";
            break;
        case 3:
            categoryName = @"ebook";
            break;
    }
    
    NSString *escapedSearchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@&limit=200&entity=%@", escapedSearchText, categoryName];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return url;
}


- (void)parseDictionary:(NSDictionary *)dictionary {
    
    NSArray *array = dictionary[@"results"];
    if (array == nil) {
        NSLog(@"Expected 'results' array");
        return;
    }
    for (NSDictionary *resultDict in array) {
        
        SearchResult *searchResult;
        
        NSString *wrapperType = resultDict[@"wrapperType"];
        NSString *kind = resultDict[@"kind"];
        
        if ([wrapperType isEqualToString:@"track"]) {
            searchResult = [self parseTrack:resultDict];
        } else if ([wrapperType isEqualToString:@"audiobook"]) {
            searchResult = [self parseAudioBook:resultDict];
        } else if ([wrapperType isEqualToString:@"software"]) {
            searchResult = [self parseSoftware:resultDict];
        } else if ([kind isEqualToString:@"ebook"]) {
            searchResult = [self parseEBook:resultDict];
        }
        if (searchResult != nil) {
            [self.searchResults addObject:searchResult];
        }
        NSLog(@"wrapperType: %@, kind: %@", resultDict[@"wrapperTupe"], resultDict[@"kind"]);
    }
}
- (SearchResult *)parseTrack:(NSDictionary *)dictionary {
    
    SearchResult *searchResult = [[SearchResult alloc] init];
    
    searchResult.name = dictionary[@"trackName"];
    searchResult.artistName = dictionary[@"artistName"];
    searchResult.artworkURL60 = dictionary[@"artworkUrl60"];
    searchResult.artworkURL100 = dictionary[@"artworkUrl100"];
    searchResult.storeURL = dictionary[@"trackViewUrl"];
    searchResult.kind = dictionary[@"kind"];
    searchResult.price = dictionary[@"trackPrice"];
    searchResult.currency = dictionary[@"currency"];
    searchResult.genre = dictionary[@"primaryGenreName"];
    return searchResult;
}

- (SearchResult *)parseAudioBook:(NSDictionary *)dictionary {
    
    SearchResult *searchResult = [[SearchResult alloc] init];
    
    searchResult.name = dictionary[@"colletionName"];
    searchResult.artistName = dictionary[@"artistName"];
    searchResult.artworkURL60 = dictionary[@"artworkUrl60"];
    searchResult.artworkURL100 = dictionary[@"artworkUrl100"];
    searchResult.storeURL = dictionary[@"collectionViewUrl"];
    searchResult.kind = @"audiobook";
    searchResult.price = dictionary[@"collectionPrice"];
    searchResult.currency = dictionary[@"currency"];
    searchResult.genre = dictionary[@"primaryGenreName"];
    
    return searchResult;
}

- (SearchResult *)parseSoftware:(NSDictionary *)dictionary {
    
    SearchResult *searchResult = [[SearchResult alloc] init];
    
    searchResult.name = dictionary[@"colletionName"];
    searchResult.artistName = dictionary[@"artistName"];
    searchResult.artworkURL60 = dictionary[@"artworkUrl60"];
    searchResult.artworkURL100 = dictionary[@"artworkUrl100"];
    searchResult.storeURL = dictionary[@"collectionViewUrl"];
    searchResult.kind = dictionary[@"kind"];
    searchResult.price = dictionary[@"collectionPrice"];
    searchResult.currency = dictionary[@"currency"];
    searchResult.genre = dictionary[@"primaryGenreName"];
    
    return searchResult;
}

- (SearchResult *)parseEBook:(NSDictionary *)dictionary {
    
    SearchResult *searchResult = [[SearchResult alloc] init];
    
    searchResult.name = dictionary[@"colletionName"];
    searchResult.artistName = dictionary[@"artistName"];
    searchResult.artworkURL60 = dictionary[@"artworkUrl60"];
    searchResult.artworkURL100 = dictionary[@"artworkUrl100"];
    searchResult.storeURL = dictionary[@"collectionViewUrl"];
    searchResult.kind = dictionary[@"kind"];
    searchResult.price = dictionary[@"collectionPrice"];
    searchResult.currency = dictionary[@"currency"];
    searchResult.genre = [(NSArray *)dictionary[@"genres"] componentsJoinedByString:@", "];
    
    return searchResult;
}

@end
