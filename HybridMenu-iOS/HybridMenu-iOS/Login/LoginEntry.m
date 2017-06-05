//
//  LoginEntry.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/5/30.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "LoginEntry.h"
#import "UserDefaultUtility.h"
@implementation LoginEntry
+ (void)loginWithUserName:(NSString *)userName passworld:(NSString *)password withDictionaryParam:(NSDictionary *)paramDictionary{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userName forKey:@"userName"];
    [userDefaults setObject:password forKey:@"password"];
    
    
}

+ (void)loginoutWithParamArrayString:(NSArray *) paramArray{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"userName"];
    [userDefaults removeObjectForKey:@"password"];
    
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    [paramArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [userDefaults removeObjectForKey:obj];
    }];
    [lock unlock];
}


@end
