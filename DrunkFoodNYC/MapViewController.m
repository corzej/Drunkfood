//
//  MapViewController.m
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/14/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end
#define METERS_PER_MILE 1609.344

@implementation MapViewController
@synthesize mapView, zoomLocation,storeName, storeTelNum, addr, areaName;
@synthesize locationManager;
@synthesize storeNmaeLabel, telNumbBtn, addrLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setLocation];
}

-(void)setLocation {
    //current
    if(locationManager ==nil){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 10 m
        [locationManager startUpdatingLocation];
    }

    //geting distance between me and store
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:zoomLocation.latitude longitude:zoomLocation.longitude];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
    double distance = [location1 distanceFromLocation:location2];
    MapPin *pin = [[MapPin alloc] initWithCoordinates:zoomLocation placeName:storeName description:areaName];
    zoomLocation.latitude = (location1.coordinate.latitude +location2.coordinate.latitude)/2;
    zoomLocation.longitude = (location1.coordinate.longitude +location2.coordinate.longitude)/2;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, distance, distance);

    
    [mapView addAnnotation:pin];
    [mapView setRegion:viewRegion animated:YES];
    [mapView setDelegate:self];
}
- (void)viewWillAppear:(BOOL)animated {


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//setting the label.
    storeNmaeLabel.text = storeName;
    [telNumbBtn setTitle:storeTelNum forState:UIControlStateNormal];

    addrLabel.text = addr;
  
//draw a line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(13, 269, 295, 0.5)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(13, 245, 295, 0.5)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];

    //name of kind of food
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
    titleLabel.textColor = [UIColor colorWithRed:181/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text =storeName;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:21]];
    [titleLabel sizeToFit];
    [self.navigationItem setTitleView:titleLabel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma makr - nextview
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MapViewController *detailViewController = [segue destinationViewController];
    
    CLLocationCoordinate2D abc;
    abc.latitude = zoomLocation.latitude;
    abc.longitude = zoomLocation.longitude;
    
    detailViewController.zoomLocation =abc;
    detailViewController.storeName =storeName;
    
}
- (void)viewDidUnload {
    [self setStoreNmaeLabel:nil];
    [self setAddrLabel:nil];
    [self setTelNumbBtn:nil];
    [super viewDidUnload];
}
- (IBAction)touchBtn:(id)sender {
    NSString *cleanedString = [[telNumbBtn.titleLabel.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", cleanedString]]];


}
@end
