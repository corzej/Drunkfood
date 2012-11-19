//
//  MapViewController.h
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/14/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController<MKAnnotation, MKMapViewDelegate>{
     CLLocationCoordinate2D zoomLocation;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) CLLocationCoordinate2D zoomLocation;

@end
