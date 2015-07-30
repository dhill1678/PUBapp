//
//  DEMOHomeViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOHomeViewController.h"
#import "WelcomeVC.h"
#import <Parse/Parse.h>


@interface DEMOHomeViewController ()

@end

@implementation DEMOHomeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([PFUser currentUser] == nil) {
        WelcomeVC *welcomeVC =[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeVC"];
//        self.navigationItem.hidesBackButton = YES;//change
        welcomeVC.navigationItem.hidesBackButton=YES;
        [self.navigationController pushViewController: welcomeVC animated:true];
    }
    
    //NSLog(@"%f",self.view.frame.size.height);
    if (self.view.frame.size.height < 600) {
        CGRect oldFrame = _logo.frame;
        CGRect newFrame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y + 20, oldFrame.size.width, oldFrame.size.height);
        _logo.frame = newFrame;
    }
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

@end
