//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Nicholas Meinhold on 29/03/2014.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRImageStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray* privateItems;

@end

@implementation BNRItemStore

+(instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    
    // do I need to create the singleton?
    if(!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// if a programmer calls [[BNRItemStore alloc] init] let him know the error of his ways!
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use: +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

// here so the real (secret) initializer
-(instancetype)initPrivate
{
    self = [super init];
    if(self)
    {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if(fromIndex == toIndex)
    {
        return;
    }
    
    // get pointer to object being moved so you can re-insert it
    BNRItem *item = self.privateItems[fromIndex];
    
    // remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex]; 
}

-(NSArray *)allItems
{
    return _privateItems;
}

-(BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    
    return item; 
}

@end
