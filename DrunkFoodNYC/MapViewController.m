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
@synthesize mapView, zoomLocation;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
        
    [mapView setRegion:viewRegion animated:YES];

    [mapView setDelegate:self];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
