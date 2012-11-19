//
//  CoreDateHelper.h
//  DoneIt
//
//  Created by Eung Jin Lee on 9/20/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface CoreDateHelper : NSObject{
    
}

+(NSMutableArray *) getObjectsFromContext: (NSString*) entityName : (NSString*) sortKey : (BOOL) sortAscending : (NSManagedObjectContext *) managedObjectContext;
+(NSMutableArray *) searchObjectsInContext: (NSString*) entityName : (NSPredicate *) predicate : (NSString*) sortKey : (BOOL) sortAscending : (NSManagedObjectContext *) managedObjectContext;

@end
