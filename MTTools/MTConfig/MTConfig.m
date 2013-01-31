//
//  MTConfig.m
//  WeiChuanV3
//
//  Created by jacksonpan on 13-1-21.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTConfig.h"
#import "FMDatabase.h"

#define MTCONFIG_DATABASE_NAME                      @"MTConfig.db"
#define MTCONFIG_TABLE_NAME                         @"config"

@interface MTConfig ()
{
    __strong FMDatabase* dbPointer;
    __strong NSDictionary* defaultValue;
}
@end

@implementation MTConfig
static MTConfig* static_config = nil;
+ (MTConfig*)current
{
    @synchronized(self)
    {
        if(static_config == nil)
        {
            static_config = [[MTConfig alloc] init];
        }
        return static_config;
    }
}

- (void)initForDB
{
    //	NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray* rs = [MTCONFIG_DATABASE_NAME componentsSeparatedByString:@"."];
    NSString *realPath = [documentPath stringByAppendingPathComponent:MTCONFIG_DATABASE_NAME];
    
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:[rs objectAtIndex:0] ofType:[rs objectAtIndex:1]];
    
    //NSLog(@"realPath:%@",realPath);
    //NSLog(@"sourcePath:%@", sourcePath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:realPath])
        //	[fileManager removeItemAtPath:realPath error:nil];
    {
        NSError *error;
        if (![fileManager copyItemAtPath:sourcePath toPath:realPath error:&error]) {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    
    //NSLog(@"复制sqlite到路径：%@成功。",realPath);
    
    dbPointer = [FMDatabase databaseWithPath:realPath];
    //dbPointer.traceExecution = YES;
}

- (void)open
{
    [dbPointer open];
}

- (void)close
{
    [dbPointer close];
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initForDB];
    }
    return self;
}

- (BOOL)checkExist:(NSString *)defaultName
{
    NSString* ret = [self stringForKey:defaultName];
    return ret?YES:NO;
}

- (NSString*)stringForKey:(NSString *)defaultName
{
    NSString* sql = [NSString stringWithFormat:@"select * from %@ where key = '%@'", MTCONFIG_TABLE_NAME, defaultName];
    [self open];
    NSString *ret = nil;
    FMResultSet* rs = [dbPointer executeQuery:sql];
    while ([rs next]) {
        ret = [rs objectForColumnIndex:1];
    }
    [self close];
    return ret;
}

- (NSInteger)intForKey:(NSString *)defaultName
{
    NSString* ret = [self stringForKey:defaultName];
    return ret?[ret integerValue]:0;
}

- (BOOL)boolForKey:(NSString *)defaultName
{
    NSString* ret = [self stringForKey:defaultName];
    return ret?[ret boolValue]:NO;
}

- (BOOL)setObject:(id)value forKey:(NSString *)defaultName
{
    NSString* sql = @"";
    NSString* isNameAlreadyExist = [self stringForKey:defaultName];
    if(isNameAlreadyExist)
    {
        sql = [NSString stringWithFormat:@"update %@ set value = '%@' WHERE key = '%@'", MTCONFIG_TABLE_NAME, value, defaultName];
    }
    else
    {
        sql = [NSString stringWithFormat:@"insert into %@ (key, value) VALUES ('%@','%@')", MTCONFIG_TABLE_NAME, defaultName, value];
    }
    
    [self open];
    BOOL ret = [dbPointer executeUpdate:sql];
    [self close];
    return ret;
}

- (BOOL)setInt:(NSInteger)value forKey:(NSString *)defaultName
{
    return [self setObject:[NSString stringWithFormat:@"%d", value] forKey:defaultName];
}

- (BOOL)setBOOL:(BOOL)value forKey:(NSString *)defaultName
{
    return [self setObject:[NSString stringWithFormat:@"%d", value] forKey:defaultName];
}

- (BOOL)removeObjectForKey:(NSString *)defaultName
{
    NSString* sql = [NSString stringWithFormat:@"delete from %@ where key = '%@'", MTCONFIG_TABLE_NAME, defaultName];
    [self open];
    BOOL ret = [dbPointer executeUpdate:sql];
    [self close];
    return ret;
}

- (void)cpDBToDesktop
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *realPath = [documentPath stringByAppendingPathComponent:MTCONFIG_DATABASE_NAME];
    NSFileManager* fm = [NSFileManager defaultManager];
    NSError* er = nil;
    NSString* dst = [NSString stringWithFormat:@"/Users/jacksonpan/Desktop/%@", MTCONFIG_DATABASE_NAME];
    if([fm fileExistsAtPath:dst])
    {
        [fm removeItemAtPath:dst error:&er];
        if(er)
        {
            NSLog(@"err:%@", er);
        }
    }
    [fm copyItemAtPath:realPath toPath:dst error:&er];
}
@end
