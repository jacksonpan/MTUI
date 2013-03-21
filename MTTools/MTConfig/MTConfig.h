//
//  MTConfig.h
//  MicroTransfer
//
//  Created by jacksonpan on 13-1-21.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTConfig : NSObject
+ (MTConfig*)current;

- (BOOL)existObjectForKey:(NSString*)defaultName;

- (id)objectForKey:(NSString *)defaultName;
- (void)setObject:(id)value forKey:(NSString *)defaultName;
- (void)removeObjectForKey:(NSString *)defaultName;

- (NSString *)stringForKey:(NSString *)defaultName;
- (NSInteger)integerForKey:(NSString *)defaultName;
- (int)intForKey:(NSString *)defaultName;
- (float)floatForKey:(NSString *)defaultName;
- (BOOL)boolForKey:(NSString *)defaultName;

- (void)setString:(NSString*)value forKey:(NSString *)defaultName;
- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;
- (void)setInt:(int)value forKey:(NSString *)defaultName;
- (void)setFloat:(float)value forKey:(NSString *)defaultName;
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

- (void)clear;

- (void)cpDBToDesktop;//for test
@end
