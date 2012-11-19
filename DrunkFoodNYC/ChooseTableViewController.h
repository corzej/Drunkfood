//
//  ChooseTableViewController.h
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/3/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "AppDelegate.h"
#import "Pizza.h"
#import "CoreDateHelper.h"
#import "myCustomCell.h"

#import "MapViewController.h"


@interface ChooseTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    NSMutableArray *entityArray;
	NSPredicate *entitySearchPredicate;
}
@property (nonatomic, strong) id  recieveInfo;
@property (nonatomic, retain) CLLocationManager *locationManager;  
// CoreData
@property (nonatomic, strong) NSString * navTitle;
@property (nonatomic, retain) AppDelegate *app;
@property (strong, nonatomic) NSString *content;
@property (nonatomic, retain) NSMutableArray *entityArray;
@property (nonatomic, retain) NSPredicate *entitySearchPredicate;


-(void) recordIt;

@end
