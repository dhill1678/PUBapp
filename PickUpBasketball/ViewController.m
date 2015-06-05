//
//  ViewController.m
//  PickUpBasketball
//
//  Created by DAVID HILL on 3/8/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)awakeFromNib {
    
    //if ([PFUser currentUser] != nil) {
        
        self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
        self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
       /*
    } else {
        self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
        self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    }
    */
}

@end
