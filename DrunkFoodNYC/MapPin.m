//
//  MapPin.m
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/20/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:placeName description:description {
    self = [super init];
    if (self != nil) {
        coordinate = location;
        title = placeName;
        subtitle = description;
    }
    return self;
}


@end