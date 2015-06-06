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
    
    // Set Home and Menu Views
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];

}

@end
