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
#import <iAd/iAd.h>

@interface ChooseTableViewController : UITableViewController <UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    NSMutableArray *entityArray;
	NSPredicate *entitySearchPredicate;
}
//tableview
@property (strong, nonatomic) IBOutlet UITableView *myTable;
//coreLocation
@property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic, strong) id  recieveInfo;
// CoreData
@property (nonatomic, strong) NSString * navTitle;
@property (nonatomic, retain) AppDelegate *app;
@property (strong, nonatomic) NSString *content;
@property (nonatomic, retain) NSMutableArray *entityArray;
@property (nonatomic, retain) NSPredicate *entitySearchPredicate;
//iad
@property (strong, nonatomic) IBOutlet ADBannerView *ad;

@end
