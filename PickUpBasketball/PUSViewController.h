//
//  PUSViewController.h
//  PickUpStats
//
//  Created by Uzoma Orji on 8/26/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PUSCourt.h"

@interface PUSViewController : UIViewController <CourtDelegate> {
    NSString *ZoneNum;
    int chosenCourt;
}

// Passed from previous screen
@property (strong, nonatomic) NSString *PracticeType;

@property (weak, nonatomic) IBOutlet PUSCourt *court;
@property (weak, nonatomic) IBOutlet UIView *statsView;
@property (weak, nonatomic) IBOutlet UILabel *statsTitle;
//@property (weak, nonatomic) IBOutlet UILabel *statsDisplay;
@property (weak, nonatomic) IBOutlet UIButton *statsButton;

- (IBAction)onSegmentedControlValueChanged:(UISegmentedControl *)sender;
- (IBAction)onStatsButtonPressed:(id)sender;

@end
