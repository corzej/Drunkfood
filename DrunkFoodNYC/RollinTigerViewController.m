//
//  RollinTigerViewController.m
//  DrunkFoodNYC
//
//  Created by Eung Jin Lee on 11/28/12.
//  Copyright (c) 2012 Eung Jin Lee. All rights reserved.
//

#import "RollinTigerViewController.h"

@interface RollinTigerViewController ()

@end

@implementation RollinTigerViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testBtnPress:(id)sender {
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"yeah" forKey:@"name"];
    [testObject save];
}
@end
