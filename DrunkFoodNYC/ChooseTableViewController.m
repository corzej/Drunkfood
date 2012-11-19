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
@synthesize app,content,entityArray,entitySearchPredicate;
@synthesize recieveInfo,locationManager;
@synthesize navTitle;
#define METERS_PER_MILE 1609.344


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
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
 

-(void) loadData{
    NSManagedObjectContext *context = [app managedObjectContext];
    
	if(entitySearchPredicate == nil)
	{
		// Use the CoreDataHelper class to get all objects of the given
		// type sorted by the "Name" key
		NSMutableArray* mutableFetchResults = [CoreDateHelper getObjectsFromContext: recieveInfo :@"name" :YES :context];
        
		self.entityArray = mutableFetchResults;
        
	}
	else
	{
		// Use the CoreDataHelper class to search for objects using
		// a given predicate, the result is sorted by the "Name" key
		NSMutableArray* mutableFetchResults = [CoreDateHelper searchObjectsInContext: recieveInfo :entitySearchPredicate :@"name" :YES :context];
		self.entityArray = mutableFetchResults;
	}
    
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
    app = [[UIApplication sharedApplication] delegate];

    
    [self loadData];
    [self loadDataWith:@"name"];
    [self calculateDisData];
    [self loadDataWith:@"distance"];
    

    //UINavigationController *navCon  = (UINavigationController*) [self.navigationController.viewControllers objectAtIndex:1];
    //navCon.navigationItem.title = navTitle;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text =navTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:21]];
    [titleLabel sizeToFit];
    [self.navigationItem setTitleView:titleLabel];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    
    //getting current time
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    int nowNum =[[dateFormatter stringFromDate:now]intValue];
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
    
    //getting day of week 1 =sunday
    int weekday = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:now] weekday];
    //getting data with day
    int open, close;
    switch (weekday) {
        case 1:
            open = [[object valueForKey:@"sunO"]intValue];
            close =[[object valueForKey:@"sunC"]intValue];
            break;
        case 2:
            open = [[object valueForKey:@"monO"]intValue];
            close =[[object valueForKey:@"monC"]intValue];
            break;
        case 3:
            open = [[object valueForKey:@"tueO"]intValue];
            close =[[object valueForKey:@"tueC"]intValue];
            break;
        case 4:
            open = [[object valueForKey:@"wedO"]intValue];
            close =[[object valueForKey:@"wedC"]intValue];
            break;
        case 5:
            open = [[object valueForKey:@"thuO"]intValue];
            close =[[object valueForKey:@"thuC"]intValue];
            break;
        case 6:
            open = [[object valueForKey:@"friO"]intValue];
            close =[[object valueForKey:@"friC"]intValue];
            break;
        case 7:
            open = [[object valueForKey:@"satO"]intValue];
            close =[[object valueForKey:@"satC"]intValue];
            break;
        default:
            break;
    }
    
    if (open ==0 && close ==0) {
        cell.openCloseLabel.text =@"Open 24Hours";
    }
    else if(open >nowNum){
        cell.openCloseLabel.text =[NSString stringWithFormat:@"close. will open in %i",(open-nowNum)];
    }
    else if (open <=nowNum){
        cell.openCloseLabel.text =@"Open";
    }
    //setting cell label values
    cell.storeNameLabel.text = [object valueForKey:@"name"];
    cell.areaLabel.text = [object valueForKey:@"area"];

    cell.distanceLabel.text = [NSString stringWithFormat:@"%.1lf miles", distance];
    return cell;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // NSManagedObject *object = (NSManagedObject *)[entityArray objectAtIndex:indexPath.row];
    
    // Navigation logic may go here. Create and push another view controller.
    
     //MapViewController *detailViewController = [[MapViewController alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     //[self.navigationController pushViewController:detailViewController animated:YES];
    
  //  MapViewController *detailViewController = [segue destinationViewController];
  //  detailViewController.recieveInfo = selectedFood;
}



#pragma mark - CLLocation

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    NSDate *eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if(abs(howRecent) <0.5){
        [manager stopUpdatingLocation];
    }


}



#pragma makr - nextview
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSManagedObject *object = (NSManagedObject *)[entityArray objectAtIndex:path.row];
    
    MapViewController *detailViewController = [segue destinationViewController];
    CLLocationCoordinate2D abc;
    abc.latitude = [[object valueForKey:@"latitude"] doubleValue];
    abc.longitude = [[object valueForKey:@"longitude"] doubleValue] ;

    detailViewController.zoomLocation =abc;

}

@end
