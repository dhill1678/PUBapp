//
//  ConsecutiveShotsViewController.h
//  PickUpStats
//
//  Created by DAVID HILL on 8/9/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ConsecutiveShotsViewController : UIViewController <ADBannerViewDelegate> {
    NSInteger madeNumber;
    NSInteger attemptedNumber;
    
    NSInteger consecutiveNumber;
    
    NSInteger ClockFinished;
    
    BOOL madeLit;
    BOOL attemptedLit;
    
    BOOL consecutiveLit;
    
    BOOL percentageView;
    
    BOOL quickReleaseStarted;
    // for timer
    NSTimer *queryTimer;
    NSInteger timerCount;
}

// Quick Release
- (IBAction)StartButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *ButtonStart;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UILabel *startingLabel;


// Passed from previous screen
@property (strong, nonatomic) NSString *PracticeType;
@property (strong, nonatomic) NSString *Zone;
@property (strong, nonatomic) NSString *CourtStyle;

- (IBAction)save:(id)sender;

- (IBAction)plus:(id)sender;
- (IBAction)minus:(id)sender;
- (IBAction)ConsecutiveAction:(id)sender;
- (IBAction)madeAction:(id)sender;
- (IBAction)attemptedAction:(id)sender;
- (IBAction)madeClosed:(id)sender;
- (IBAction)attemptedClosed:(id)sender;
- (IBAction)consecutiveClosed:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *MadeAttemptedView;
@property (strong, nonatomic) IBOutlet UITextField *madeNum;
@property (strong, nonatomic) IBOutlet UITextField *attemptedNum;

@property (strong, nonatomic) IBOutlet UIView *ConsecutiveView;
@property (strong, nonatomic) IBOutlet UITextField *consecutiveNum;

@property (strong, nonatomic) IBOutlet UIView *freeThrowView;
@property (strong, nonatomic) IBOutlet UIButton *consecutiveButtonOut;
@property (strong, nonatomic) IBOutlet UIButton *percentageButtonOut;
- (IBAction)consecutiveButtonAct:(id)sender;
- (IBAction)percentageButtonAct:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *mainLabel;
@property (strong, nonatomic) IBOutlet UILabel *subLabel;

@end
