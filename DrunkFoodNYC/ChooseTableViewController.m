//
//  ChooseTableViewController.m
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/3/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import "ChooseTableViewController.h"

@interface ChooseTableViewController ()
@end


@implementation ChooseTableViewController
//tableview
@synthesize myTable;
//corelocation
@synthesize locationManager;

@synthesize recieveInfo;
//coreData
@synthesize navTitle;
@synthesize content,entityArray,entitySearchPredicate;
@synthesize app;
@synthesize ad;
#define METERS_PER_MILE 1609.344


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"hey, %@", recieveInfo);
    if(locationManager ==nil){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 10 m
        [locationManager startUpdatingLocation];
    }
//to use core data
    app = [[UIApplication sharedApplication] delegate];

//load the data for coredata first to sort by distance
    [self loadDataWith:@"name"];
    [self calculateDisData];
    [self loadDataWith:@"distance"];

//name of kind of food
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
    titleLabel.textColor = [UIColor colorWithRed:181/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text =navTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:21]];
    [titleLabel sizeToFit];
    [self.navigationItem setTitleView:titleLabel];

// display iad
    self.tableView.tableFooterView = ad;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [entityArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //constructing Cell
    static NSString *CellIdentifier = @"myCell";
    myCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    tableView.separatorColor = [UIColor grayColor];
    //loading data
    NSManagedObject *object = (NSManagedObject *)[entityArray objectAtIndex:indexPath.row];

    //geting distance between me and store
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:[[object valueForKey:@"latitude"]doubleValue] longitude:[[object valueForKey:@"longitude"]doubleValue]];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
    double distance = ([location1 distanceFromLocation:location2]/1609.34);

//getting current time and day
    NSDate *now = [NSDate date];
    int openClose;
    int weekday = [self checkDay:now];

    switch (weekday) {
        case 1:
            openClose = [self checkWithYesterdayClose:[[object valueForKey:@"satC"]doubleValue] todayOpen:[[object valueForKey:@"sunO"]doubleValue] todayClose:[[object valueForKey:@"sunC"]doubleValue] currentTime:[self getCurrentTime:now]];
            break;
        case 2:
            openClose = [self checkWithYesterdayClose:[[object valueForKey:@"sunC"]doubleValue] todayOpen:[[object valueForKey:@"monO"]doubleValue] todayClose:[[object valueForKey:@"monC"]doubleValue] currentTime:[self getCurrentTime:now]];
            break;
        case 3:
            openClose = [self checkWithYesterdayClose:[[object valueForKey:@"monC"]doubleValue] todayOpen:[[object valueForKey:@"tueO"]doubleValue] todayClose:[[object valueForKey:@"tueC"]doubleValue] currentTime:[self getCurrentTime:now]];
            break;
        case 4:
            openClose = [self checkWithYesterdayClose:[[object valueForKey:@"tueC"]doubleValue] todayOpen:[[object valueForKey:@"wedO"]doubleValue] todayClose:[[object valueForKey:@"wedC"]doubleValue] currentTime:[self getCurrentTime:now]];
            break;
        case 5:
            openClose = [self checkWithYesterdayClose:[[object valueForKey:@"wedC"]doubleValue] todayOpen:[[object valueForKey:@"thuO"]doubleValue] todayClose:[[object valueForKey:@"thuC"]doubleValue] currentTime:[self getCurrentTime:now]];
            break;
        case 6:
            openClose = [self checkWithYesterdayClose:[[object valueForKey:@"thuC"]doubleValue] todayOpen:[[object valueForKey:@"friO"]doubleValue] todayClose:[[object valueForKey:@"friC"]doubleValue] currentTime:[self getCurrentTime:now]];
            break;
        case 7:
            openClose = [self checkWithYesterdayClose:[[object valueForKey:@"friC"]doubleValue] todayOpen:[[object valueForKey:@"satO"]doubleValue] todayClose:[[object valueForKey:@"satC"]doubleValue] currentTime:[self getCurrentTime:now]];
            break;
        default:
            break;
    }
    
//setting cell label values
    switch (openClose) {
        case 1:
            
            cell.openCloseLabel.textColor = [UIColor grayColor];
            cell.openCloseLabel.text = @"OPEN";
            cell.closeLabel.textColor = [UIColor redColor];
            cell.closeLabel.text =@"CLOSE";
            break;
        case 2:
            cell.openCloseLabel.textColor = [UIColor greenColor];
            cell.openCloseLabel.text = @"OPEN";
            cell.closeLabel.textColor = [UIColor grayColor];
            cell.closeLabel.text =@"CLOSE";
            break;
        case 3:

            cell.openCloseLabel.textColor = [UIColor colorWithRed:89.0/255.0 green:141.0/255.0 blue:191.0/255.0 alpha:1.0];
            cell.openCloseLabel.text = @"OPEN";
            cell.closeLabel.textColor = [UIColor colorWithRed:89.0/255.0 green:141.0/255.0 blue:191.0/255.0 alpha:1.0];
            cell.closeLabel.text =@"24 HRS";
            break;
        default:
            break;
    }
    cell.storeNameLabel.text = [object valueForKey:@"name"];
    cell.areaLabel.text = [object valueForKey:@"area"];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.1lf miles", distance];
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSManagedObject *object = (NSManagedObject *)[entityArray objectAtIndex:path.row];
    MapViewController *dvc = [[self storyboard] instantiateViewControllerWithIdentifier:@"toMap"];
    CLLocationCoordinate2D abc;
    abc.latitude = [[object valueForKey:@"latitude"] doubleValue];
    abc.longitude = [[object valueForKey:@"longitude"] doubleValue] ;
    
    dvc.zoomLocation =abc;
     */
}

#pragma mark - CLLocation

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    NSDate *eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if(abs(howRecent) <0.5){
        [manager stopUpdatingLocation];
    }


}

#pragma makr - nextview label
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MapViewController *detailViewController = [segue destinationViewController];
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSManagedObject *object = (NSManagedObject *)[entityArray objectAtIndex:path.row];
    
    CLLocationCoordinate2D abc;
    abc.latitude = [[object valueForKey:@"latitude"] doubleValue];
    abc.longitude = [[object valueForKey:@"longitude"] doubleValue] ;
    
    detailViewController.zoomLocation =abc;
    detailViewController.storeName = [object valueForKey:@"name"];
    detailViewController.storeTelNum = [object valueForKey:@"phoneNum"];
    detailViewController.areaName = [object valueForKey:@"area"];
    detailViewController.addr =[object valueForKey:@"physicalAdd"];

}

#pragma makr -scrollview
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect iAdFrame = ad.frame;
    CGFloat newOriginY =  myTable.contentOffset.y + myTable.frame.size.height - iAdFrame.size.height;
    CGRect newIAdFrame = CGRectMake(iAdFrame.origin.x, newOriginY, iAdFrame.size.width, iAdFrame.size.height);
    ad.frame = newIAdFrame;
}

#pragma makr- data methods

-(void) calculateDisData{
    for (int a = 0; a <[entityArray count]; a++) {
        NSManagedObject *object = (NSManagedObject *)[entityArray objectAtIndex:a];
        
        //geting distance between me and store
        CLLocation *location1 = [[CLLocation alloc] initWithLatitude:[[object valueForKey:@"latitude"]doubleValue] longitude:[[object valueForKey:@"longitude"]doubleValue]];
        CLLocation *location2 = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
        double distance = ([location1 distanceFromLocation:location2]/1609.34);
        [object setValue:[NSNumber numberWithDouble:distance] forKey:@"distance"];
        
    }
}

-(void) loadDataWith:(NSString *) sortName{
    NSManagedObjectContext *context = [app managedObjectContext];
    
	if(entitySearchPredicate == nil)
	{
		// Use the CoreDataHelper class to get all objects of the given
		// type sorted by the "Name" key
		NSMutableArray* mutableFetchResults = [CoreDateHelper getObjectsFromContext: recieveInfo :sortName :YES :context];
        
		self.entityArray = mutableFetchResults;
        
	}
	else
	{
		// Use the CoreDataHelper class to search for objects using
		// a given predicate, the result is sorted by the "Name" key
		NSMutableArray* mutableFetchResults = [CoreDateHelper searchObjectsInContext: recieveInfo :entitySearchPredicate :sortName :YES :context];
		self.entityArray = mutableFetchResults;
	}
    
}

#pragma -makr - check day and time

-(double) getCurrentTime:(NSDate *)now{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    int nowNumHr =[[dateFormatter stringFromDate:now]intValue];
    dateFormatter.dateFormat =@"mm";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    int nowNumMin =[[dateFormatter stringFromDate:now]intValue];
    
    return (double)(nowNumHr + (double)nowNumMin/60);
}
-(int) checkDay:(NSDate *)now{

    //getting day of week 1 =sunday
    int weekday = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:now] weekday];
    
    return weekday;
}
-(int) checkWithYesterdayClose:(double)yesCl todayOpen:(double)todayOp todayClose:(double)todayCl currentTime:(double)currentT{
//close =1 , open =2, 24open =3
    if(todayOp == 0){
        //24 hour open
        return 3;
    }
    else if(todayOp ==-1){
        //close
        return 1;
    }
    else if(0<=yesCl && yesCl <12 ){
        if (yesCl <= currentT && currentT<todayOp) {
            //close
            return 1;
        }
        
        else if( 12<=todayCl && todayCl <24){
            if (todayCl <=currentT) {
                return 1;
            }
            else{
                return 2;
            }
        }
        
        else{
            return 2;
        }
    }
    else if(yesCl <24 && todayOp >currentT){
        
        return 1;
    }
    else{
        return 2;
    }
}

@end
