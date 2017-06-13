//
//  UserDefaultUtility.h
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultUtility : NSObject
+(void)saveValue:(id) value forKey:(NSString *)key;

+(id)valueWithKey:(NSString *)key;

+(BOOL)boolValueWithKey:(NSString *)key;

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

+(void)saveParameter:(NSDictionary *)paramterDic;

+(void)print;

+(NSString *)getUserID;
+(void)saveUserID:(NSString *)user_id;
@end
