//
//  SeasonViewController.h
//  PickUpStats
//
//  Created by DAVID HILL on 7/30/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface SeasonViewController : UIViewController <ADBannerViewDelegate> {

    BOOL checkedGameWinner;
    
    // Stat Entry
    NSString *currentLit;
    NSString *newLit;
    BOOL yourScoreLit;
    BOOL oppScoreLit;
    BOOL twoPtMadeLit;
    BOOL twoPtAttLit;
    BOOL threePtMadeLit;
    BOOL threePtAttLit;
    BOOL freePtMadeLit;
    BOOL freePtAttLit;
    BOOL assistsLit;
    BOOL turnoversLit;
    BOOL stealsLit;
    BOOL blocksLit;
    BOOL OffReboundLit;
    BOOL DefReboundLit;
    BOOL TotReboundLit;
    
    // Stat Integers
    NSInteger yourScoreNumber;
    NSInteger oppScoreNumber;
    NSInteger twoPtMadeNumber;
    NSInteger twoPtAttNumber;
    NSInteger threePtMadeNumber;
    NSInteger threePtAttNumber;
    NSInteger freePtMadeNumber;
    NSInteger freePtAttNumber;
    NSInteger assistsNumber;
    NSInteger turnoversNumber;
    NSInteger stealsNumber;
    NSInteger blocksNumber;
    NSInteger OffReboundNumber;
    NSInteger DefReboundNumber;
    NSInteger TotReboundNumber;
    
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
@property (strong, nonatomic) IBOutlet UITextField *seasonIDText;

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

- (IBAction)saveStats:(id)sender;

// Shooting View
@property (strong, nonatomic) IBOutlet UIView *shootingView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shootingVertAlign;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet UITextField *twoPtMadeOut;
@property (strong, nonatomic) IBOutlet UITextField *twoPtAttOut;
@property (strong, nonatomic) IBOutlet UITextField *threePtMadeOut;
@property (strong, nonatomic) IBOutlet UITextField *threePtAttOut;
@property (strong, nonatomic) IBOutlet UITextField *freeMadeOut;
@property (strong, nonatomic) IBOutlet UITextField *freeAttOut;
- (IBAction)twoPtMadeClick:(id)sender;
- (IBAction)twoPtAttClick:(id)sender;
- (IBAction)threePtMadeClick:(id)sender;
- (IBAction)threePtAttClick:(id)sender;
- (IBAction)freeMadeClick:(id)sender;
- (IBAction)freeAttClick:(id)sender;
- (IBAction)twoMadeEdit:(id)sender;
- (IBAction)twoAttEdit:(id)sender;

// Offense View
@property (strong, nonatomic) IBOutlet UIView *offenseView;
@property (strong, nonatomic) IBOutlet UITextField *assistsOut;
@property (strong, nonatomic) IBOutlet UITextField *turnoversOut;
@property (strong, nonatomic) IBOutlet UITextField *offReboundOut;
- (IBAction)assistsAct:(id)sender;
- (IBAction)turnoversAct:(id)sender;
- (IBAction)offReboundAct:(id)sender;
- (IBAction)assistsEdit:(id)sender;
- (IBAction)turnoversEdit:(id)sender;
- (IBAction)offRebEdit:(id)sender;
- (IBAction)threeMadeEdit:(id)sender;
- (IBAction)threeAttEdit:(id)sender;
- (IBAction)freeMadeEdit:(id)sender;
- (IBAction)freeAttEdit:(id)sender;

// Defense View
@property (strong, nonatomic) IBOutlet UIView *defenseView;
@property (strong, nonatomic) IBOutlet UITextField *stealsOut;
@property (strong, nonatomic) IBOutlet UITextField *blocksOut;
@property (strong, nonatomic) IBOutlet UITextField *DefReboundOut;
@property (strong, nonatomic) IBOutlet UITextField *TotReboundOut;
- (IBAction)stealsAct:(id)sender;
- (IBAction)blocksAct:(id)sender;
- (IBAction)DefReboundAct:(id)sender;
- (IBAction)TotReboundAct:(id)sender;
- (IBAction)stealsEdit:(id)sender;
- (IBAction)blocksEdit:(id)sender;
- (IBAction)defRebEdit:(id)sender;
- (IBAction)totRebEdit:(id)sender;

- (IBAction)plus:(id)sender;
- (IBAction)minus:(id)sender;

@end
