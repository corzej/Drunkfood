//
//  FoodChooseViewController.m
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/3/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import "FoodChooseViewController.h"

@interface FoodChooseViewController ()

@end

@implementation FoodChooseViewController
@synthesize selectedFood, locationManager;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor =[UIColor blackColor];
    
    
    if(locationManager ==nil){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 10 m
        [locationManager startUpdatingLocation];
    }
    //[UIColor colorWithRed:201.0/256.0 green:0/256.0 blue:0/256.0 alpha:1.0];
	// Do any additional setup after loading the view.
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 30)];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text =@"Drunk Food";
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {


        ChooseTableViewController *detailViewController = [segue destinationViewController];
        detailViewController.recieveInfo = selectedFood;
        detailViewController.navTitle = selectedFood;
    
}



- (IBAction)Food1Btn:(id)sender {
    selectedFood = @"Pizza";
}
- (IBAction)Food2Btn:(id)sender {
    selectedFood = @"Hfh";
}
- (IBAction)Food3Btn:(id)sender {
    selectedFood = @"Taco";
}
- (IBAction)Food4Btn:(id)sender {
    
}
- (IBAction)Food5Btn:(id)sender {
}
- (IBAction)Food6Btn:(id)sender {
}
- (IBAction)Food7Btn:(id)sender {
}
- (IBAction)Food8Btn:(id)sender {
    selectedFood = @"Korean";
}
- (IBAction)Food9Btn:(id)sender {
}


@end
