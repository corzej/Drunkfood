//
//  OnOffViewController.m
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/28/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import "OnOffViewController.h"

@interface OnOffViewController ()

@end

@implementation OnOffViewController

@synthesize userNameLabel, ownerLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[PFUser currentUser]refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
    }];
    //getting data from parse.com
    NSLog(@"hey : %d",[[[PFUser currentUser] objectForKey:@"storeOwner" ]boolValue]);
    if([[[PFUser currentUser]objectForKey:@"storeOwner"]boolValue]){
        ownerLabel.text = @"approve";
    }
    else{
        ownerLabel.text = @"not approved";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self viewDidLoad];
}
- (void)viewDidUnload {
    [self setUserNameLabel:nil];
    [self setOwnerLabel:nil];
    [super viewDidUnload];
}
@end
