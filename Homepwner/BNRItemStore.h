//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Nicholas Meinhold on 29/03/2014.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

// notice that this is a class method and so is prefixed with a + rather than a -
+(instancetype)sharedStore;
-(BNRItem *)createItem;



@end
