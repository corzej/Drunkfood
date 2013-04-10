//
//  OnOffViewController.h
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/28/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface OnOffViewController : UIViewController<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>{
}

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@end
