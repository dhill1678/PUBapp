//
//  UITabBarController+ChatTabBarController.m
//  PickUpBasketball
//
//  Created by DAVID HILL on 4/8/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//

#import "ChatTabBarController.h"


@implementation ChatTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Game Invitations";
}

- (IBAction)showMenu {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

@end
