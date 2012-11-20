//
//  AppDelegate.h
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/2/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// TO save what kind of Food you Choose
@property (strong, nonatomic) NSString * kindOfFood;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
