//
//  myCustomCell.h
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/5/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *openCloseLabel;
@property (weak, nonatomic) IBOutlet UILabel *closeLabel;

@end
