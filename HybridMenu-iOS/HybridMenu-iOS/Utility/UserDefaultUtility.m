//
//  UserDefaultUtility.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "UserDefaultUtility.h"

@implementation UserDefaultUtility

+(void)saveValue:(id) value forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

+(id)valueWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

+(BOOL)boolValueWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

+ (void)saveParameter:(NSDictionary *)paramterDic{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    [paramterDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [userDefaults setObject:obj forKey:key];
    }];
    [lock unlock];
}

+(void)print{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    DLog(@"%@",dic);
}
@end
