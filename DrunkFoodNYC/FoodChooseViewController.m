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
@synthesize ad;

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

   // self.navigationController.navigationBar.tintColor =[UIColor blackColor];
    
    
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
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.textColor = [UIColor colorWithRed:181/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text =@"DRUNK FOOD";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:21]];
    [titleLabel sizeToFit];

    [self.navigationItem setTitleView:titleLabel];
    
    ad.delegate =self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (!([segue.identifier isEqualToString:@"toRT"] || [segue.identifier isEqualToString:@"toLogin"])) {
        ChooseTableViewController *detailViewController = [segue destinationViewController];
        detailViewController.recieveInfo = selectedFood;
        detailViewController.navTitle = selectedFood;
    }
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
    selectedFood = @"Fastfood";
}
- (IBAction)Food5Btn:(id)sender {
    selectedFood = @"Asian";
}
- (IBAction)Food6Btn:(id)sender {
    selectedFood = @"Falafel";
}
- (IBAction)Food7Btn:(id)sender {
    selectedFood= @"Diner";
}
- (IBAction)Food8Btn:(id)sender {
    selectedFood = @"Friedchicken";
}
- (IBAction)Food9Btn:(id)sender {
    selectedFood = @"Halal";
}

- (IBAction)aboutUsBtn:(id)sender {
}

- (IBAction)loginBtnAction:(id)sender {
}


@end
