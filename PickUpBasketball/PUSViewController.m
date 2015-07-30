//
//  PUSViewController.m
//  PickUpStats
//
//  Created by Uzoma Orji on 8/26/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import "PUSViewController.h"
#import "PUSCourt.h"
#import "PUSZone.h"
#import "ConsecutiveShotsViewController.h"

@interface PUSViewController ()
@end

@implementation PUSViewController

@synthesize court;
@synthesize statsView;
@synthesize statsTitle;
//@synthesize statsDisplay;
@synthesize statsButton;

PUSZone* currentZone;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Pick Zone";
    //self.title = _PracticeType;
    
    chosenCourt = 1;
    
    [court setDelegate:self];
    [statsView setAlpha:0.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onZoneSelected:(PUSZone *)zone {
    currentZone = zone;
    ZoneNum = [NSString stringWithFormat:@"%d", currentZone.mZoneNumber];
    [statsView setAlpha:1.0];
    if ([currentZone hasStats]) {
        //[statsButton setTitle:@"Update Stats" forState:UIControlStateNormal];
        //[statsTitle setText:[NSString stringWithFormat:@"Stats For Zone %d", currentZone.mZoneNumber]];
        [statsButton setTitle:@"Start Session" forState:UIControlStateNormal];
        [statsTitle setText:[NSString stringWithFormat:@"Zone %d", currentZone.mZoneNumber]];
        //[statsDisplay setText:[NSString stringWithFormat:@"%d/%d", currentZone.mFGM, currentZone.mFGA]];
        //[statsDisplay setAlpha:1.0];
    } else {
        //[statsButton setTitle:@"Enter Stats" forState:UIControlStateNormal];
        //[statsTitle setText:[NSString stringWithFormat:@"No Stats For Zone %d", currentZone.mZoneNumber]];
        [statsButton setTitle:@"Start Session" forState:UIControlStateNormal];
        [statsTitle setText:[NSString stringWithFormat:@"Zone %d", currentZone.mZoneNumber]];
        //[statsDisplay setAlpha:0.0];
    }
}

- (IBAction)onSegmentedControlValueChanged:(UISegmentedControl *)sender {
    [statsView setAlpha:0.0];
    int index = sender.selectedSegmentIndex;
    chosenCourt = index;
    [court setStyle:2*index];
}

- (IBAction)onStatsButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"ConsecutiveShots" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"ConsecutiveShots"])
    {
        // Get reference to the destination view controller
        ConsecutiveShotsViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.PracticeType = _PracticeType;
        vc.Zone = ZoneNum;
        if (chosenCourt == 0) {
            vc.CourtStyle = @"NBA";
        } else if (chosenCourt == 1) {
            vc.CourtStyle = @"NCAA";
        }
        
    }
}

@end
