//
//  LoginEntry.h
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/5/30.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginEntry : NSObject

+ (BOOL)loginWithUserName:(NSString *)userName
          passworld:(NSString *)password
withDictionaryParam:(NSDictionary *)paramDictionary;

+ (BOOL)loginoutWithParamArrayString:(NSArray *) paramArray;

+ (BOOL)saveByUserdefaultWithDictionary:(NSDictionary *)paramDictionary;

+ (BOOL)saveByUserdefaultWithUserID:(NSString *)user_id;

+ (id)getByUserdefaultWithKey:(NSString *)key;

@end
