//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Nick Meinhold on 3/04/2014.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

+(instancetype)sharedStore
{
    static BNRImageStore *sharedStore = nil;
    
    if(!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
        
    }
    
    return sharedStore;
}

// no-one should call init
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use: +[ENSImageStore sharedStore]" userInfo:nil];
    
    return nil;
}

// secret designated iitialiser
-(instancetype)initPrivate
{
    self = [super init];
    if(self)
    {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)setImage:(UIImage*)image forKey:(NSString*)key
{
    self.dictionary[key] = image;
}

-(UIImage*)imageForKey:(NSString*)key
{
    return self.dictionary[key];
}

-(void)deleteImageForKey:(NSString*)key
{
    if(!key)
    {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}

@end
