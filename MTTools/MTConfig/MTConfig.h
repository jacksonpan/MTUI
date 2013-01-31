//
//  MTConfig.h
//  WeiChuanV3
//
//  Created by jacksonpan on 13-1-21.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTConfig : NSObject
+ (MTConfig*)current;

- (BOOL)checkExist:(NSString *)defaultName;

- (NSString*)stringForKey:(NSString *)defaultName;
- (NSInteger)intForKey:(NSString *)defaultName;
- (BOOL)boolForKey:(NSString *)defaultName;

- (BOOL)setObject:(id)value forKey:(NSString *)defaultName;
- (BOOL)setInt:(NSInteger)value forKey:(NSString *)defaultName;
- (BOOL)setBOOL:(BOOL)value forKey:(NSString *)defaultName;

- (BOOL)removeObjectForKey:(NSString *)defaultName;

- (void)cpDBToDesktop;
@end
