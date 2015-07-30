//
//  PickUpViewController.h
//  PickUpStats
//
//  Created by DAVID HILL on 7/29/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface PickUpViewController : UIViewController <ADBannerViewDelegate> {
    
    NSInteger teamSize;
    BOOL checkedfull;
    NSInteger scoringStyle;
    
    BOOL checkedGameWinner;

    NSInteger teamSizeCount;
    NSInteger pointStyleCount;
    
    // Stat Entry
    NSString *currentLit;
    NSString *newLit;
    BOOL yourScoreLit;
    BOOL oppScoreLit;
    BOOL twoPtMadeLit;
    BOOL twoPtAttLit;
    BOOL threePtMadeLit;
    BOOL threePtAttLit;
    BOOL assistsLit;
    BOOL turnoversLit;
    BOOL stealsLit;
    BOOL blocksLit;
    BOOL ReboundLit;
    
    // Stat Integers
    NSInteger yourScoreNumber;
    NSInteger oppScoreNumber;
    NSInteger twoPtMadeNumber;
    NSInteger twoPtAttNumber;
    NSInteger threePtMadeNumber;
    NSInteger threePtAttNumber;
    NSInteger assistsNumber;
    NSInteger turnoversNumber;
    NSInteger stealsNumber;
    NSInteger blocksNumber;
    NSInteger ReboundNumber;
    
    // help counters
    NSInteger toolbarCounter;
    NSInteger mainHelpCounter;

}

// for help
@property (strong, nonatomic) NSString *HELP;
@property (strong, nonatomic) IBOutlet UIView *toolbarHelp;
@property (strong, nonatomic) IBOutlet UILabel *toolbarHelpText;
- (IBAction)toolbarClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mainHelp;
- (IBAction)mainHelpClose:(id)sender;

// Game Info View
@property (strong, nonatomic) IBOutlet UIView *gameInfo;
@property (strong, nonatomic) IBOutlet UIButton *fullCourtOut;
@property (strong, nonatomic) IBOutlet UIButton *halfCourtOut;
@property (strong, nonatomic) IBOutlet UIButton *one1Out;
@property (strong, nonatomic) IBOutlet UIButton *two2Out;
@property (strong, nonatomic) IBOutlet UIButton *three3Out;
@property (strong, nonatomic) IBOutlet UIButton *four4Out;
@property (strong, nonatomic) IBOutlet UIButton *five5Out;
@property (strong, nonatomic) IBOutlet UIButton *one1PointOut;
@property (strong, nonatomic) IBOutlet UIButton *one2PointOut;
@property (strong, nonatomic) IBOutlet UIButton *two3PointOut;
- (IBAction)fullCourtAct:(id)sender;
- (IBAction)halfCourtAct:(id)sender;
- (IBAction)one1Act:(id)sender;
- (IBAction)two2Act:(id)sender;
- (IBAction)three3Act:(id)sender;
- (IBAction)four4Act:(id)sender;
- (IBAction)five5Act:(id)sender;
- (IBAction)one1PointAct:(id)sender;
- (IBAction)one2PointAct:(id)sender;
- (IBAction)two3PointAct:(id)sender;

// Final Score View
@property (strong, nonatomic) IBOutlet UIView *finalScore;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *finalScoreVertAlign;
@property (strong, nonatomic) IBOutlet UITextField *yourScoreOut;
@property (strong, nonatomic) IBOutlet UITextField *opponentScoreOut;
@property (strong, nonatomic) IBOutlet UIButton *gameWinnerOut;
- (IBAction)yourScoreAct:(id)sender;
- (IBAction)opponentScoreAct:(id)sender;
- (IBAction)gameWinnerAct:(id)sender;
- (IBAction)yourScoreEdit:(id)sender;
- (IBAction)oppScoreEdit:(id)sender;

// Shooting View
@property (strong, nonatomic) IBOutlet UIView *shootingView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shootingVertAlign;
@property (strong, nonatomic) IBOutlet UITextField *twoPtMadeOut;
@property (strong, nonatomic) IBOutlet UITextField *twoPtAttOut;
@property (strong, nonatomic) IBOutlet UITextField *threePtMadeOut;
@property (strong, nonatomic) IBOutlet UITextField *threePtAttOut;
- (IBAction)twoPtMadeClick:(id)sender;
- (IBAction)twoPtAttClick:(id)sender;
- (IBAction)threePtMadeClick:(id)sender;
- (IBAction)threePtAttClick:(id)sender;
- (IBAction)twoMadeEdit:(id)sender;
- (IBAction)twoAttEdit:(id)sender;
- (IBAction)threeMadeEdit:(id)sender;
- (IBAction)threeAttEdit:(id)sender;

// Offense View
@property (strong, nonatomic) IBOutlet UIView *offenseView;
@property (strong, nonatomic) IBOutlet UITextField *assistsOut;
@property (strong, nonatomic) IBOutlet UITextField *turnoversOut;
- (IBAction)assistsAct:(id)sender;
- (IBAction)turnoversAct:(id)sender;
- (IBAction)assistsEdit:(id)sender;
- (IBAction)turnoversEdit:(id)sender;

// Defense View
@property (strong, nonatomic) IBOutlet UIView *defenseView;
@property (strong, nonatomic) IBOutlet UITextField *stealsOut;
@property (strong, nonatomic) IBOutlet UITextField *blocksOut;
@property (strong, nonatomic) IBOutlet UITextField *ReboundOut;
- (IBAction)stealsAct:(id)sender;
- (IBAction)blocksAct:(id)sender;
- (IBAction)ReboundAct:(id)sender;
- (IBAction)stealsEdit:(id)sender;
- (IBAction)blocksEdit:(id)sender;
- (IBAction)reboundsEdit:(id)sender;

- (IBAction)saveStats:(id)sender;
- (IBAction)plus:(id)sender;
- (IBAction)minus:(id)sender;

@end
