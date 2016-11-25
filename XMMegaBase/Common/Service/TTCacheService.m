
#import "TTCacheService.h"
#import "LevelDB.h"

#define LEVELDB_NAME @"ttcache.ldb"

@interface TTCacheService ()

@property(nonatomic, strong) NSMutableDictionary *memoryStorageDict;
@property(nonatomic, strong) LevelDB *levelDB;

@end

@implementation TTCacheService

+ (TTCacheService *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TTCacheService *service = nil;
    dispatch_once(&onceToken, ^{
        service = [[TTCacheService alloc] init];
    });
    return service;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.memoryStorageDict = [NSMutableDictionary dictionary];
        self.levelDB = [LevelDB databaseInLibraryWithName:LEVELDB_NAME];
    }
    return self;
}

#pragma mark - memory storage
+ (void)setObjectToMemory:(id)Object forKey:(NSString *)aKey
{
    if (aKey && Object) {
        [[self sharedInstance].memoryStorageDict setObject:Object forKey:aKey];
    }
}

+ (id)objectFromMemoryForKey:(NSString *)aKey
{
    return [[self sharedInstance].memoryStorageDict objectForKey:aKey];
}

+ (void)removeObjectFromMemoryForKey:(NSString *)aKey
{
    [[self sharedInstance].memoryStorageDict removeObjectForKey:aKey];
}

#pragma mark - local levelDB
+ (void)setObjectToLocalCache:(id)Object forKey:(NSString *)aKey
{
    [[self sharedInstance].levelDB setObject:Object forKey:aKey];
}

+ (id)objectFromLocalCacheForKey:(NSString *)aKey
{
    return [[self sharedInstance].levelDB objectForKey:aKey];
}

+ (void)removeObjectFromLocalCacheForKey:(NSString *)aKey
{
    [[self sharedInstance].levelDB removeObjectForKey:aKey];
}

//#pragma mark - local FMDatabase

@end
