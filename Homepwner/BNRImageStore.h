//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Nick Meinhold on 3/04/2014.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+(instancetype)sharedStore;

-(void)setImage:(UIImage*)image forKey:(NSString*)key;
-(UIImage*)imageForKey:(NSString*)key;
-(void)deleteImageForKey:(NSString*)key;


@end
