//
//  Search.h
//  StoreSearch
//
//  Created by Ekaterina on 9/29/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void (^SearchBlock)(BOOL success);

@interface Search : NSObject

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, readonly, strong) NSMutableArray *searchResults;

- (void)performSearchForText:(NSString *)text category:(NSInteger)category completion:(SearchBlock)block;

@end
