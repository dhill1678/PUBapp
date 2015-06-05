//
//  UIViewController+StatsHomeViewController.m
//  PickUpBasketball
//
//  Created by DAVID HILL on 4/25/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//

#import "StatsHomeViewController.h"

@implementation StatsHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    CALayer *btnLayer1 = [_GameLog layer];
    [btnLayer1 setMasksToBounds:YES];
    [btnLayer1 setCornerRadius:10.0f];
     */
}

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)GoGameLog:(id)sender {
    [self performSegueWithIdentifier:@"SortableTable" sender:self];
}

@end
