//
//  PracticeViewController.m
//  PickUpStats
//
//  Created by DAVID HILL on 8/9/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import "PracticeViewController.h"
#import "ConsecutiveShotsViewController.h"
#import "PUSViewController.h"

@interface PracticeViewController ()

@end

@implementation PracticeViewController

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
    
    NSLog(@"Main View: %f",[[UIScreen mainScreen] bounds].size.height);
    NSLog(@"Self View: %f",self.view.frame.size.height);
    
    if ([[UIScreen mainScreen] bounds].size.height < 500) {
        //[_practiceLabel setFont:[UIFont systemFontOfSize:24]];
        _topLabelConstraint.constant = 5;
        [UIView animateWithDuration:0.3 animations:^{
            [_practiceLabel layoutIfNeeded];
        }];
    }
    
    _practiceLabel.text = [NSString stringWithFormat:@"Pick A Practice Mode Below"];
    _descriptionLabel.hidden = YES;
    _startPractice.hidden = YES;
    _backOut.hidden = YES;
    
    _shotChart.hidden = NO;
    _heatCheck.hidden = NO;
    _freeThrows.hidden = NO;
    _altHandLayups.hidden = NO;
    _quickRelease.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/////////////////
// Ad Handling //
/////////////////

#pragma mark - iAD Delegate Methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

- (IBAction)shotChartButton:(id)sender {
    //_shotChart.hidden = YES;
    _heatCheck.hidden = YES;
    _freeThrows.hidden = YES;
    _altHandLayups.hidden = YES;
    _quickRelease.hidden = YES;
    
    [UIView transitionWithView:_shotChart
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    _shotChart.hidden = YES;
    
    _practiceLabel.text = [NSString stringWithFormat:@"Shot Chart"];
    _descriptionLabel.text = [NSString stringWithFormat:@"Know Your Hot Spots! Track Shooting Stats Across The Floor"];
    _descriptionLabel.hidden = NO;
    _startPractice.hidden = NO;
    _backOut.hidden = NO;
}

- (IBAction)heatCheckButton:(id)sender {
    _shotChart.hidden = YES;
    //_heatCheck.hidden = YES;
    _freeThrows.hidden = YES;
    _altHandLayups.hidden = YES;
    _quickRelease.hidden = YES;
    
    [UIView transitionWithView:_heatCheck
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    _heatCheck.hidden = YES;
    
    _practiceLabel.text = [NSString stringWithFormat:@"Heat Check"];
    _descriptionLabel.text = [NSString stringWithFormat:@"How Many Shots Can You Make In A Row? Try To Beat Your Own Records"];
    _descriptionLabel.hidden = NO;
    _startPractice.hidden = NO;
    _backOut.hidden = NO;
}

- (IBAction)freeThrowButton:(id)sender {
    _shotChart.hidden = YES;
    _heatCheck.hidden = YES;
    //_freeThrows.hidden = YES;
    _altHandLayups.hidden = YES;
    _quickRelease.hidden = YES;
    
    [UIView transitionWithView:_freeThrows
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    _freeThrows.hidden = YES;
    
    _practiceLabel.text = [NSString stringWithFormat:@"Free Throws"];
    _descriptionLabel.text = [NSString stringWithFormat:@"Clutch Begins At The Free Throw Line! How Do You Measure Up?"];
    _descriptionLabel.hidden = NO;
    _startPractice.hidden = NO;
    _backOut.hidden = NO;
}

- (IBAction)layupButton:(id)sender {
    _shotChart.hidden = YES;
    _heatCheck.hidden = YES;
    _freeThrows.hidden = YES;
    //_altHandLayups.hidden = YES;
    _quickRelease.hidden = YES;
    
    [UIView transitionWithView:_altHandLayups
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    _altHandLayups.hidden = YES;
    
    _practiceLabel.text = [NSString stringWithFormat:@"Alternate Hand Layups"];
    _descriptionLabel.text = [NSString stringWithFormat:@"The Greats Finish With Both Hands! What's Your Conversion Rate? Make As Many Consecutive Alternating Hand Layups As Possible"];
    _descriptionLabel.hidden = NO;
    _startPractice.hidden = NO;
    _backOut.hidden = NO;
}

- (IBAction)quickReleaseButton:(id)sender {
    _shotChart.hidden = YES;
    _heatCheck.hidden = YES;
    _freeThrows.hidden = YES;
    _altHandLayups.hidden = YES;
    //_quickRelease.hidden = YES;
    
    [UIView transitionWithView:_quickRelease
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    _quickRelease.hidden = YES;
    
    _practiceLabel.text = [NSString stringWithFormat:@"Quick Release"];
    _descriptionLabel.text = [NSString stringWithFormat:@"Get Off As Many Shots As You Can In Under 1 Minute!"];
    _descriptionLabel.hidden = NO;
    _startPractice.hidden = NO;
    _backOut.hidden = NO;
}

- (IBAction)startPractice:(id)sender {
    if ([_practiceLabel.text isEqualToString:@"Shot Chart"]) {
        [self performSegueWithIdentifier:@"ShotChart" sender:self];
    } else if ([_practiceLabel.text isEqualToString:@"Heat Check"]) {
        [self performSegueWithIdentifier:@"ShotChart" sender:self];
    } else if ([_practiceLabel.text isEqualToString:@"Quick Release"]) {
        [self performSegueWithIdentifier:@"ShotChart" sender:self];
    } else if ([_practiceLabel.text isEqualToString:@"Free Throws"]) {
        [self performSegueWithIdentifier:@"ConsecutiveShots" sender:self];
    } else if ([_practiceLabel.text isEqualToString:@"Alternate Hand Layups"]) {
        [self performSegueWithIdentifier:@"ConsecutiveShots" sender:self];
    } else {
        NSLog(@"There's a Problem");
    }
}

- (IBAction)backButton:(id)sender {
    _practiceLabel.text = [NSString stringWithFormat:@"Pick A Practice Mode Below"];
    _descriptionLabel.hidden = YES;
    _startPractice.hidden = YES;
    _backOut.hidden = YES;
    
    _shotChart.hidden = NO;
    _heatCheck.hidden = NO;
    _freeThrows.hidden = NO;
    _altHandLayups.hidden = NO;
    _quickRelease.hidden = NO;
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

- (IBAction)instructions:(id)sender {
    [self performSegueWithIdentifier:@"showInstructions" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"ShotChart"])
    {
        // Get reference to the destination view controller
        PUSViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.PracticeType = _practiceLabel.text;
        //[vc setMyObjectHere:_practiceLabel.text];
    } else if ([[segue identifier] isEqualToString:@"ConsecutiveShots"])
    {
        // Get reference to the destination view controller
        ConsecutiveShotsViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.PracticeType = _practiceLabel.text;
        //[vc setMyObjectHere:_practiceLabel.text];
    }
}

@end
