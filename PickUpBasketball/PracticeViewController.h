//
//  PracticeViewController.h
//  PickUpStats
//
//  Created by DAVID HILL on 8/9/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "REFrostedViewController.h"

@interface PracticeViewController : UIViewController <ADBannerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *practiceLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topLabelConstraint;


- (IBAction)shotChartButton:(id)sender;
- (IBAction)heatCheckButton:(id)sender;
- (IBAction)freeThrowButton:(id)sender;
- (IBAction)layupButton:(id)sender;
- (IBAction)quickReleaseButton:(id)sender;

- (IBAction)startPractice:(id)sender;
- (IBAction)backButton:(id)sender;

- (IBAction)showMenu;
- (IBAction)instructions:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *shotChart;
@property (strong, nonatomic) IBOutlet UIButton *heatCheck;
@property (strong, nonatomic) IBOutlet UIButton *freeThrows;
@property (strong, nonatomic) IBOutlet UIButton *altHandLayups;
@property (strong, nonatomic) IBOutlet UIButton *quickRelease;
@property (strong, nonatomic) IBOutlet UIButton *startPractice;
@property (strong, nonatomic) IBOutlet UIButton *backOut;

@end
