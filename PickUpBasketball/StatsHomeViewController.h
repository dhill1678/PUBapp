//
//  UIViewController+StatsHomeViewController.h
//  PickUpBasketball
//
//  Created by DAVID HILL on 4/25/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface StatsHomeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *GameLog;
- (IBAction)showMenu;
- (IBAction)GoGameLog:(id)sender;
- (IBAction)GoChart:(id)sender;
- (IBAction)GoAverages:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *Chart;
- (IBAction)goAnalytics:(id)sender;
@end
