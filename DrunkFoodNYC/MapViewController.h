//
//  MapViewController.h
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/14/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapPin.h"

@interface MapViewController : UIViewController<MKAnnotation, MKMapViewDelegate>{
     CLLocationCoordinate2D zoomLocation;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) CLLocationCoordinate2D zoomLocation;
@property (nonatomic, assign) NSString * storeName;
@property (nonatomic, assign) NSString * areaName;
@property (nonatomic, assign) NSString * storeTelNum;
@property (nonatomic, assign) NSString * addr;


@property (weak, nonatomic) IBOutlet UIButton *telNumbBtn;
@property (weak, nonatomic) IBOutlet UILabel *storeNmaeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
- (IBAction)touchBtn:(id)sender;

@end
