//
//  AppDelegate.h
//  Chaser
//
//  Created by Syo SASAKI on 2013/03/02.
//  Copyright (c) 2013年 Syo SASAKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterManager.h"
#import "CacheManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


// original property
@property TwitterManager *twitterManager;
@property CacheManager *cacheManager;

@end
