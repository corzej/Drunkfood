//
//  FullMapViewController.h
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/24/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapPin.h"

@interface FullMapViewController : UIViewController<MKAnnotation, MKMapViewDelegate>{
    CLLocationCoordinate2D zoomLocation;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) CLLocationCoordinate2D zoomLocation;
@property (nonatomic, assign) NSString * storeName;
@end
