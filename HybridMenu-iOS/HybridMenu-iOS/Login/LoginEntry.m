//
//  LoginEntry.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/5/30.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "LoginEntry.h"

@implementation LoginEntry
+ (BOOL)loginWithUserName:(NSString *)userName passworld:(NSString *)password withDictionaryParam:(NSDictionary *)paramDictionary{
    
//    NSDate *futureTime = [NSDate dateWithTimeIntervalSinceNow:60*60*24*15];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userName forKey:@"userName"];
    [userDefaults setObject:password forKey:@"password"];
//    [userDefaults setObject:futureTime forKey:@"time"];
    
    if ([LoginEntry saveByUserdefaultWithDictionary:paramDictionary]) {
        return [userDefaults synchronize];
    }else{
        return NO;
    }
    
}

+ (BOOL)loginoutWithParamArrayString:(NSArray *) paramArray{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"stuNum"];
    [userDefaults removeObjectForKey:@"idNum"];
    [userDefaults removeObjectForKey:@"time"];
    
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    [paramArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [userDefaults removeObjectForKey:obj];
    }];
    [lock unlock];
    
    if([userDefaults synchronize]){
        return YES;
    }else{
        return NO;
    }
}


+ (BOOL)saveByUserdefaultWithDictionary:(NSDictionary *)paramDictionary{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    [paramDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [userDefaults setObject:obj forKey:key];
    }];
    [lock unlock];
    
    if([userDefaults synchronize]){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)saveByUserdefaultWithUserID:(NSString *)user_id{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    [userDefaults setObject:user_id forKey:@"user_id"];
    [lock unlock];
    
    if([userDefaults synchronize]){
        return YES;
    }else{
        return NO;
    }
}


+ (id)getByUserdefaultWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

@end
