//
//  DataCenter.m
//  ADImageViewDemo
//
//  Created by liuzhihui on 14-7-1.
//  Copyright (c) 2014年 liuzhihui. All rights reserved.
//

#import "DataCenter.h"
#import "AllDefine.h"

static NSString *kLocalAddress = @"http://127.0.0.1:8000";
static NSString *kServerAddress = @"10.167.145.101";
static NSString *kAPIPath = @"dede";

static NSString *kServerDataFileName = @"server_data.plist";

static NSString *kPhotoPath = @"mobile/index.php?url=article/ad";

@interface DataCenter ()
{
    MKNetworkEngine *_netEngine;
    HJObjManager *_objManager;
    
    NSMutableDictionary *_infoCacheDic;
    NSMutableDictionary *_requestDic;
}

- (void)cancelRequest:(NSString *)aKey;
- (void)photoRequestInfo:(NSString*)aPath onComplete:(CompleteBlock)handleComplete onError:(ErrorBlock)handleError;

@end

@implementation DataCenter

+ (DataCenter *)sharedCenter
{
    static dispatch_once_t once;
    static DataCenter *sharedCenter;
    dispatch_once(&once, ^ { sharedCenter = [[DataCenter alloc] init]; });
    return sharedCenter;
}

#pragma mark - Class life cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        _netEngine = [[MKNetworkEngine alloc] initWithHostName: kServerAddress];
        _netEngine.apiPath = kAPIPath;
        
        _objManager = [[HJObjManager alloc] init];
        NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
        HJMOFileCache *fileCache = [[HJMOFileCache alloc] initWithRootPath: cacheDirectory];
        _objManager.fileCache = fileCache;
        
        NSFileManager *fm = [NSFileManager defaultManager];
        
        NSString *serverDataFilePath = [[_netEngine cacheDirectoryName] stringByAppendingPathComponent: kServerDataFileName];
        NSLog(@"%@",serverDataFilePath);
        if ([fm fileExistsAtPath: serverDataFilePath])
        {
            NSLog(@"initwith cache");
            _infoCacheDic = [[NSMutableDictionary alloc] initWithContentsOfFile: serverDataFilePath];
        }
        else
        {
            [fm createDirectoryAtPath:[_netEngine cacheDirectoryName] withIntermediateDirectories:YES attributes:nil error:nil];
           BOOL result =  [fm createFileAtPath: serverDataFilePath contents: nil attributes: nil];
            NSLog(@"%d",result);
            _infoCacheDic = [[NSMutableDictionary alloc] init];
            
            [_infoCacheDic writeToFile: serverDataFilePath atomically: YES];
        }
        
        _requestDic = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)cacheData
{
    NSString *serverDataFilePath = [[_netEngine cacheDirectoryName] stringByAppendingPathComponent: kServerDataFileName];
    [_infoCacheDic writeToFile: serverDataFilePath atomically: YES];
}

#pragma mark - Public methods

- (NSUInteger)cacheSize
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *readyDirectory = [_netEngine cacheDirectoryName];
    NSString *loadingDirectory = [readyDirectory stringByReplacingOccurrencesOfString: MKNETWORKCACHE_DEFAULT_DIRECTORY withString: @"loading"];
    unsigned long long readySize = [[fm attributesOfItemAtPath: readyDirectory error: nil] fileSize];
    unsigned long long loadingSize = [[fm attributesOfItemAtPath: loadingDirectory error: nil] fileSize];
    
    NSUInteger result = (NSUInteger)(readySize + loadingSize) - 136; // 此处假设两个文件夹中没有二级目录，则，两个文件夹所占大小为136；
    
    return result;
}

- (void)cleanCache
{
    [_objManager cancelLoadingObjects];
    [_objManager.fileCache emptyCache];
}

- (void)managedObject:(id<HJMOUser>)aObject
{
    [_objManager performSelectorOnMainThread: @selector(manage:) withObject: aObject waitUntilDone: YES];
}

- (NSArray*)getADPhotoList:(CompleteBlock)handleComplete onError:(ErrorBlock)handleError
{
    NSString *path = kPhotoPath;
    
    [self photoRequestInfo:path onComplete: handleComplete onError: handleError];

    return nil;
}


- (NSString*)getCacheImagePath:(NSString*)url
{
    NSString *result = [_objManager.fileCache readyFilePathForOid: url];
    if ([[NSFileManager defaultManager] fileExistsAtPath: result])
    {
        return result;
    }
    else
    {
        return nil;
    }
}

#pragma mark - Private methods
- (void)cancelRequest:(NSString *)aKey
{
    NSArray *array = [_requestDic objectForKey: aKey];
    if (array)
    {
        if (array.count != 0)
        {
            [array makeObjectsPerformSelector: @selector(cancel)];
        }
        [_requestDic removeObjectForKey: aKey];
    }
}

- (void)photoRequestInfo:(NSString*)path onComplete:(CompleteBlock)handleComplete onError:(ErrorBlock)handleError
{
    MKNetworkOperation *op= [_netEngine operationWithPath: path];
    
    [op addCompletionHandler: ^(MKNetworkOperation *operation){
        
        NSLog(@"Get photo successed");
        NSArray *resultArray;
        NSDictionary *dic = [[operation responseJSON] objectForKey:@"data"];
        [_infoCacheDic setValue: [dic objectForKey: @"news"] forKey: @"news"];
        resultArray = [dic objectForKey: @"news"];
        handleComplete(resultArray);
        
    }errorHandler: ^(MKNetworkOperation *completedOperation, NSError *error){
        NSLog(@"Get photo failed");
        handleError(error);
    }];
    
    [_netEngine enqueueOperation: op];
}


@end
