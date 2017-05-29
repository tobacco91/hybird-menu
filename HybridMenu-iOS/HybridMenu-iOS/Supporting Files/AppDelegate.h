//
//  AppDelegate.h
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/5/29.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

