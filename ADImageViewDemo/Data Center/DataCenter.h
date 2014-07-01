//
//  DataCenter.h
//  ADImageViewDemo
//
//  Created by liuzhihui on 14-7-1.
//  Copyright (c) 2014年 liuzhihui. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"
#import "HJObjManager.h"

typedef void (^CompleteBlock)(NSArray *);
typedef MKNKErrorBlock ErrorBlock;

@interface DataCenter : NSObject

+ (DataCenter*)sharedCenter;

- (NSUInteger)cacheSize;
- (void)cacheData;
- (void)cleanCache;

- (void)managedObject:(id<HJMOUser>)aObject;

- (NSArray*)getADPhotoList:(CompleteBlock)handleComplete onError:(ErrorBlock)handleError;
- (NSString*)getCacheImagePath:(NSString*)url;

@end
