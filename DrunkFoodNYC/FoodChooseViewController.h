//
//  FoodChooseViewController.h
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/3/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseTableViewController.h"
#import <iAd/iAd.h>

@interface FoodChooseViewController : UIViewController<CLLocationManagerDelegate,ADBannerViewDelegate>{

}

@property (nonatomic, strong) NSString *  selectedFood;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet ADBannerView *ad;

- (IBAction)Food1Btn:(id)sender;
- (IBAction)Food2Btn:(id)sender;
- (IBAction)Food3Btn:(id)sender;
- (IBAction)Food4Btn:(id)sender;
- (IBAction)Food5Btn:(id)sender;
- (IBAction)Food6Btn:(id)sender;
- (IBAction)Food7Btn:(id)sender;
- (IBAction)Food8Btn:(id)sender;
- (IBAction)Food9Btn:(id)sender;
- (IBAction)aboutUsBtn:(id)sender;

@end
