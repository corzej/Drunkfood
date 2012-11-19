//
//  myCustomCell.m
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/5/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import "myCustomCell.h"

@implementation myCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
