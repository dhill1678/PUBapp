//
//  SeasonViewController.m
//  PickUpStats
//
//  Created by DAVID HILL on 7/30/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import "SeasonViewController.h"
#import "HTHorizontalSelectionList.h"
#import "ProgressHUD.h"

#import <Parse/Parse.h>
#import "Configs.h"

@interface SeasonViewController () <HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource>

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSArray *statTypes;

@end

@implementation SeasonViewController

@synthesize gameInfo, finalScore, shootingView, offenseView, defenseView;

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
    
    NSLog(@"%@",_HELP);
    
    //self.title = @"Example App";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 160, 0, 320, 40)];
    self.selectionList.delegate = self;
    self.selectionList.dataSource = self;
    
    self.statTypes = @[@"Game Info",
                       @"Final Score",
                       @"Shooting",
                       @"Offense",
                       @"Defense"];
    
    [self.view addSubview:self.selectionList];
    
    [self showScreen:self.selectionList.selectedButtonIndex];
    
    // clear all checkboxes
    checkedGameWinner = NO;
    
    // Initialize Stat Entry
    currentLit = nil;
    newLit = nil;
    yourScoreLit = NO;
    oppScoreLit = NO;
    twoPtMadeLit = NO;
    twoPtAttLit = NO;
    threePtMadeLit = NO;
    threePtAttLit = NO;
    freePtMadeLit = NO;
    freePtAttLit = NO;
    assistsLit = NO;
    turnoversLit = NO;
    stealsLit = NO;
    blocksLit = NO;
    OffReboundLit = NO;
    DefReboundLit = NO;
    TotReboundLit = NO;
    
    // Initialize Stat Numbers
    yourScoreNumber = 0;
    oppScoreNumber = 0;
    twoPtMadeNumber = 0;
    twoPtAttNumber = 0;
    threePtMadeNumber = 0;
    threePtAttNumber = 0;
    freePtMadeNumber = 0;
    freePtAttNumber = 0;
    assistsNumber = 0;
    turnoversNumber = 0;
    stealsNumber = 0;
    blocksNumber = 0;
    OffReboundNumber = 0;
    DefReboundNumber = 0;
    TotReboundNumber = 0;

    CALayer *btnLayer1 = [_gameWinnerOut layer];
    [btnLayer1 setMasksToBounds:YES];
    [btnLayer1 setCornerRadius:10.0f];
    
    // control help
    toolbarCounter = 0;
    mainHelpCounter = 0;
    _mainHelp.hidden = YES;
    if ([_HELP isEqualToString:@"YES"]) {
        _toolbarHelpText.text = @"Use Headings To Navigate";
        _toolbarHelp.hidden = NO;
        _toolbarHelp.layer.zPosition = 100; // bring to front
        
        _mainHelp.layer.zPosition = 101; // bring to front
    } else {
        _toolbarHelp.hidden = YES;
    }
    
    NSLog(@"%f", _viewHeight.constant);
    if (self.view.frame.size.height < 600) {
        _finalScoreVertAlign.constant = 25;
        [UIView animateWithDuration:0.3 animations:^{
            [finalScore layoutIfNeeded];
        }];
        _shootingVertAlign.constant = 25;
        [UIView animateWithDuration:0.3 animations:^{
            [shootingView layoutIfNeeded];
        }];
    } else if (self.view.frame.size.height < 900) {
        
        _shootingVertAlign.constant = 25;
        [UIView animateWithDuration:0.3 animations:^{
            [shootingView layoutIfNeeded];
        }];
    
        //self.viewHeight.constant = 300;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.statTypes.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.statTypes[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    //Select = index;
    
    [self showScreen:index];
}

- (void)showScreen:(NSInteger)index {
    if (index == 0) {
        gameInfo.hidden = NO;
        finalScore.hidden = YES;
        shootingView.hidden = YES;
        offenseView.hidden = YES;
        defenseView.hidden = YES;
    } else if (index == 1) {
        gameInfo.hidden = YES;
        finalScore.hidden = NO;
        shootingView.hidden = YES;
        offenseView.hidden = YES;
        defenseView.hidden = YES;
        
        if ([_HELP isEqualToString:@"YES"]) {
            if (mainHelpCounter == 0) {
                _mainHelp.hidden = NO;
                mainHelpCounter++;
            }
        }
    } else if (index == 2) {
        gameInfo.hidden = YES;
        finalScore.hidden = YES;
        shootingView.hidden = NO;
        offenseView.hidden = YES;
        defenseView.hidden = YES;
        
        if ([_HELP isEqualToString:@"YES"]) {
            if (mainHelpCounter == 0) {
                _mainHelp.hidden = NO;
                mainHelpCounter++;
            }
        }
    } else if (index == 3) {
        gameInfo.hidden = YES;
        finalScore.hidden = YES;
        shootingView.hidden = YES;
        offenseView.hidden = NO;
        defenseView.hidden = YES;
        
        if ([_HELP isEqualToString:@"YES"]) {
            if (toolbarCounter == 0) {
                _toolbarHelpText.text = @"Keep Scrolling for Defense";
                _toolbarHelp.hidden = NO;
                toolbarCounter++;
            }
            if (mainHelpCounter == 0) {
                _mainHelp.hidden = NO;
                mainHelpCounter++;
            }
        }
    } else if (index == 4) {
        gameInfo.hidden = YES;
        finalScore.hidden = YES;
        shootingView.hidden = YES;
        offenseView.hidden = YES;
        defenseView.hidden = NO;
        
        if ([_HELP isEqualToString:@"YES"]) {
            if (mainHelpCounter == 0) {
                _mainHelp.hidden = NO;
                mainHelpCounter++;
            }
        }
    } else {
        NSLog(@"There is a Problem");
    }
}

// dismiss keyboard on scroll
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //[self.yourScoreField resignFirstResponder];
}

// dismiss keyboard on tap - FINALLY WORKS
- (void) tapped {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField) {
        [textField resignFirstResponder];
    }
    
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)saveStats:(id)sender {
    
    if ([_yourScoreOut.text isEqualToString:@"-"] || [_opponentScoreOut.text isEqualToString:@"-"]) {
        
        [ProgressHUD showError:@"Please Enter the game's Final Score"];
        return;
        
    }
    
    PFUser *user = [PFUser currentUser];
    PFObject *pickup = [PFObject objectWithClassName:@"Game"];
    [pickup setObject:user forKey:@"user"];
    [pickup setObject:@"Season" forKey:@"type"];
    [pickup setObject:_seasonIDText.text forKey:@"seasonid"];
    [pickup setObject:_yourScoreOut.text forKey:@"yourscore"];
    [pickup setObject:_opponentScoreOut.text forKey:@"opponentscore"];
    
    if ([_yourScoreOut.text integerValue] > [_opponentScoreOut.text integerValue]) {
        [pickup setObject:@"YES" forKey:@"win"];
        [pickup setObject:[NSString stringWithFormat:@"%s", checkedGameWinner ? "YES" : "NO"] forKey:@"gamewinner"];
    } else {
        [pickup setObject:@"NO" forKey:@"win"];
        if (checkedGameWinner) {
            [ProgressHUD showError:@"Game Winners Not Allowed For Loses"];
            return;
        } else {
            [pickup setObject:[NSString stringWithFormat:@"%s", checkedGameWinner ? "YES" : "NO"] forKey:@"gamewinner"];
        }
    }
    
    if (![_twoPtMadeOut.text isEqualToString:@"-"]) {
        [pickup setObject:_twoPtMadeOut.text forKey:@"twoptmade"];
    }
    if (![_twoPtAttOut.text isEqualToString:@"-"]) {
        if ([_twoPtAttOut.text integerValue] >= [_twoPtMadeOut.text integerValue]) {
            [pickup setObject:_twoPtAttOut.text forKey:@"twoptattempted"];
        } else {
            [ProgressHUD showError:@"You Cannot Make More Two Pointers Than You Attempt"];
            return;
        }
    }
    if (![_threePtMadeOut.text isEqualToString:@"-"]) {
        [pickup setObject:_threePtMadeOut.text forKey:@"threeptmade"];
    }
    if (![_threePtAttOut.text isEqualToString:@"-"]) {
        if ([_threePtAttOut.text integerValue] >= [_threePtMadeOut.text integerValue]) {
            [pickup setObject:_threePtAttOut.text forKey:@"threeptattempted"];
        } else {
            [ProgressHUD showError:@"You Cannot Make More Three Pointers Than You Attempt"];
            return;
        }
    }
    if (![_freeMadeOut.text isEqualToString:@"-"]) {
        [pickup setObject:_freeMadeOut.text forKey:@"freethrowmade"];
    }
    if (![_freeAttOut.text isEqualToString:@"-"]) {
        if ([_freeAttOut.text integerValue] >= [_freeMadeOut.text integerValue]) {
            [pickup setObject:_freeAttOut.text forKey:@"freethrowattempted"];
        } else {
            [ProgressHUD showError:@"You Cannot Make More Free Throws Than You Attempt"];
            return;
        }
    }
    if (![_assistsOut.text isEqualToString:@"-"]) {
        [pickup setObject:_assistsOut.text forKey:@"assists"];
    }
    if (![_turnoversOut.text isEqualToString:@"-"]) {
        [pickup setObject:_turnoversOut.text forKey:@"turnovers"];
    }
    if (![_offReboundOut.text isEqualToString:@"-"]) {
        [pickup setObject:_offReboundOut.text forKey:@"offrebounds"];
    }
    if (![_stealsOut.text isEqualToString:@"-"]) {
        [pickup setObject:_stealsOut.text forKey:@"steals"];
    }
    if (![_blocksOut.text isEqualToString:@"-"]) {
        [pickup setObject:_blocksOut.text forKey:@"blocks"];
    }
    if (![_DefReboundOut.text isEqualToString:@"-"]) {
        [pickup setObject:_DefReboundOut.text forKey:@"defrebounds"];
    }
    if (![_TotReboundOut.text isEqualToString:@"-"]) {
        if (([_DefReboundOut.text integerValue] + [_offReboundOut.text integerValue]) <= [_TotReboundOut.text integerValue]) {
            [pickup setObject:_TotReboundOut.text forKey:@"totalrebounds"];
        } else {
            [ProgressHUD showError:@"You Cannot Have More Offensive & Defensive Rebounds Than Total Rebounds"];
            return;
        }
        
    }
    
    [pickup saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error == nil)
        {
            [ProgressHUD showSuccess:@"Saved."];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else [ProgressHUD showError:@"Network error."];
    }];
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

- (IBAction)gameWinnerAct:(id)sender {
    
    if (!checkedGameWinner) {
        checkedGameWinner = YES;
        
        _gameWinnerOut.backgroundColor = [UIColor colorWithRed:0/255.0f green:31/255.0f blue:112/255.0f alpha:1.0f];
        [_gameWinnerOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        checkedGameWinner = NO;
        
        _gameWinnerOut.backgroundColor = [UIColor clearColor];
        [_gameWinnerOut setTitleColor:[UIColor colorWithRed:0/255.0f green:31/255.0f blue:112/255.0f alpha:1.0f] forState:UIControlStateNormal];
    }
}

- (void)ToggleTextFields:(NSString*)NEW from:(NSString*)OLD {
    if ([NEW isEqualToString:@"yourScoreLit"]) {
        yourScoreLit = YES;
        [_yourScoreOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_yourScoreOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"yourScoreLit"]) {
        yourScoreLit = NO;
        [_yourScoreOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_yourScoreOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"oppScoreLit"]) {
        oppScoreLit = YES;
        [_opponentScoreOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_opponentScoreOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"oppScoreLit"]) {
        oppScoreLit = NO;
        [_opponentScoreOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_opponentScoreOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"twoPtMadeLit"]) {
        twoPtMadeLit = YES;
        [_twoPtMadeOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_twoPtMadeOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"twoPtMadeLit"]) {
        twoPtMadeLit = NO;
        [_twoPtMadeOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_twoPtMadeOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"twoPtAttLit"]) {
        twoPtAttLit = YES;
        [_twoPtAttOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_twoPtAttOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"twoPtAttLit"]) {
        twoPtAttLit = NO;
        [_twoPtAttOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_twoPtAttOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"threePtMadeLit"]) {
        threePtMadeLit = YES;
        [_threePtMadeOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_threePtMadeOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"threePtMadeLit"]) {
        threePtMadeLit = NO;
        [_threePtMadeOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_threePtMadeOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"threePtAttLit"]) {
        threePtAttLit = YES;
        [_threePtAttOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_threePtAttOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"threePtAttLit"]) {
        threePtAttLit = NO;
        [_threePtAttOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_threePtAttOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"freePtMadeLit"]) {
        freePtMadeLit = YES;
        [_freeMadeOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_freeMadeOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"freePtMadeLit"]) {
        freePtMadeLit = NO;
        [_freeMadeOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_freeMadeOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"freePtAttLit"]) {
        freePtAttLit = YES;
        [_freeAttOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_freeAttOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"freePtAttLit"]) {
        freePtAttLit = NO;
        [_freeAttOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_freeAttOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"assistsLit"]) {
        assistsLit = YES;
        [_assistsOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_assistsOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"assistsLit"]) {
        assistsLit = NO;
        [_assistsOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_assistsOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"turnoversLit"]) {
        turnoversLit = YES;
        [_turnoversOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_turnoversOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"turnoversLit"]) {
        turnoversLit = NO;
        [_turnoversOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_turnoversOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"stealsLit"]) {
        stealsLit = YES;
        [_stealsOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_stealsOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"stealsLit"]) {
        stealsLit = NO;
        [_stealsOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_stealsOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"blocksLit"]) {
        blocksLit = YES;
        [_blocksOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_blocksOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"blocksLit"]) {
        blocksLit = NO;
        [_blocksOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_blocksOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"OffReboundLit"]) {
        OffReboundLit = YES;
        [_offReboundOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_offReboundOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"OffReboundLit"]) {
        OffReboundLit = NO;
        [_offReboundOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_offReboundOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"DefReboundLit"]) {
        DefReboundLit = YES;
        [_DefReboundOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_DefReboundOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"DefReboundLit"]) {
        DefReboundLit = NO;
        [_DefReboundOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_DefReboundOut setTextColor:[UIColor blackColor]];
    }
    if ([NEW isEqualToString:@"TotReboundLit"]) {
        TotReboundLit = YES;
        [_TotReboundOut setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_TotReboundOut setTextColor:[UIColor whiteColor]];
    }
    if ([OLD isEqualToString:@"TotReboundLit"]) {
        TotReboundLit = NO;
        [_TotReboundOut setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_TotReboundOut setTextColor:[UIColor blackColor]];
    }
}

- (IBAction)freeMadeClick:(id)sender {
    if (!freePtMadeLit) {
        newLit = @"freePtMadeLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"freePtMadeLit";
    } else {
        [_freeMadeOut becomeFirstResponder];
    }
}

- (IBAction)freeAttClick:(id)sender {
    if (!freePtAttLit) {
        newLit = @"freePtAttLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"freePtAttLit";
    } else {
        [_freeAttOut becomeFirstResponder];
    }
}

- (IBAction)twoMadeEdit:(id)sender {
    if ([_twoPtMadeOut.text integerValue] > 0) {
        twoPtMadeNumber = [_twoPtMadeOut.text integerValue];
        _twoPtMadeOut.text = [NSString stringWithFormat:@"%ld",(long)[_twoPtMadeOut.text integerValue]];
    } else if ([_twoPtMadeOut.text isEqualToString:@"0"]) {
        twoPtMadeNumber = [_twoPtMadeOut.text integerValue];
        _twoPtMadeOut.text = [NSString stringWithFormat:@"%ld",(long)[_twoPtMadeOut.text integerValue]];
    } else {
        _twoPtMadeOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)twoAttEdit:(id)sender {
    if ([_twoPtAttOut.text integerValue] > 0) {
        twoPtAttNumber = [_twoPtAttOut.text integerValue];
        _twoPtAttOut.text = [NSString stringWithFormat:@"%ld",(long)[_twoPtAttOut.text integerValue]];
    } else if ([_twoPtAttOut.text isEqualToString:@"0"]) {
        twoPtAttNumber = [_twoPtAttOut.text integerValue];
        _twoPtAttOut.text = [NSString stringWithFormat:@"%ld",(long)[_twoPtAttOut.text integerValue]];
    } else {
        _twoPtAttOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)offReboundAct:(id)sender {
    if (!OffReboundLit) {
        newLit = @"OffReboundLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"OffReboundLit";
    } else {
        [_offReboundOut becomeFirstResponder];
    }
}

- (IBAction)assistsEdit:(id)sender {
    if ([_assistsOut.text integerValue] > 0) {
        assistsNumber = [_assistsOut.text integerValue];
        _assistsOut.text = [NSString stringWithFormat:@"%ld",(long)[_assistsOut.text integerValue]];
    } else if ([_assistsOut.text isEqualToString:@"0"]) {
        assistsNumber = [_assistsOut.text integerValue];
        _assistsOut.text = [NSString stringWithFormat:@"%ld",(long)[_assistsOut.text integerValue]];
    } else {
        _assistsOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)turnoversEdit:(id)sender {
    if ([_turnoversOut.text integerValue] > 0) {
        turnoversNumber = [_turnoversOut.text integerValue];
        _turnoversOut.text = [NSString stringWithFormat:@"%ld",(long)[_turnoversOut.text integerValue]];
    } else if ([_turnoversOut.text isEqualToString:@"0"]) {
        turnoversNumber = [_turnoversOut.text integerValue];
        _turnoversOut.text = [NSString stringWithFormat:@"%ld",(long)[_turnoversOut.text integerValue]];
    } else {
        _turnoversOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)offRebEdit:(id)sender {
    if ([_offReboundOut.text integerValue] > 0) {
        OffReboundNumber = [_offReboundOut.text integerValue];
        _offReboundOut.text = [NSString stringWithFormat:@"%ld",(long)[_offReboundOut.text integerValue]];
    } else if ([_offReboundOut.text isEqualToString:@"0"]) {
        OffReboundNumber = [_offReboundOut.text integerValue];
        _offReboundOut.text = [NSString stringWithFormat:@"%ld",(long)[_offReboundOut.text integerValue]];
    } else {
        _offReboundOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)threeMadeEdit:(id)sender {
    if ([_threePtMadeOut.text integerValue] > 0) {
        threePtMadeNumber = [_threePtMadeOut.text integerValue];
        _threePtMadeOut.text = [NSString stringWithFormat:@"%ld",(long)[_threePtMadeOut.text integerValue]];
    } else if ([_threePtMadeOut.text isEqualToString:@"0"]) {
        threePtMadeNumber = [_threePtMadeOut.text integerValue];
        _threePtMadeOut.text = [NSString stringWithFormat:@"%ld",(long)[_threePtMadeOut.text integerValue]];
    } else {
        _threePtMadeOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)threeAttEdit:(id)sender {
    if ([_threePtAttOut.text integerValue] > 0) {
        threePtAttNumber = [_threePtAttOut.text integerValue];
        _threePtAttOut.text = [NSString stringWithFormat:@"%ld",(long)[_threePtAttOut.text integerValue]];
    } else if ([_threePtAttOut.text isEqualToString:@"0"]) {
        threePtAttNumber = [_threePtAttOut.text integerValue];
        _threePtAttOut.text = [NSString stringWithFormat:@"%ld",(long)[_threePtAttOut.text integerValue]];
    } else {
        _threePtAttOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)freeMadeEdit:(id)sender {
    if ([_freeMadeOut.text integerValue] > 0) {
        freePtMadeNumber = [_freeMadeOut.text integerValue];
        _freeMadeOut.text = [NSString stringWithFormat:@"%ld",(long)[_freeMadeOut.text integerValue]];
    } else if ([_freeMadeOut.text isEqualToString:@"0"]) {
        freePtMadeNumber = [_freeMadeOut.text integerValue];
        _freeMadeOut.text = [NSString stringWithFormat:@"%ld",(long)[_freeMadeOut.text integerValue]];
    } else {
        _freeMadeOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)freeAttEdit:(id)sender {
    if ([_freeAttOut.text integerValue] > 0) {
        freePtAttNumber = [_freeAttOut.text integerValue];
        _freeAttOut.text = [NSString stringWithFormat:@"%ld",(long)[_freeAttOut.text integerValue]];
    } else if ([_freeAttOut.text isEqualToString:@"0"]) {
        freePtAttNumber = [_freeAttOut.text integerValue];
        _freeAttOut.text = [NSString stringWithFormat:@"%ld",(long)[_freeAttOut.text integerValue]];
    } else {
        _freeAttOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)stealsEdit:(id)sender {
    if ([_stealsOut.text integerValue] > 0) {
        stealsNumber = [_stealsOut.text integerValue];
        _stealsOut.text = [NSString stringWithFormat:@"%ld",(long)[_stealsOut.text integerValue]];
    } else if ([_stealsOut.text isEqualToString:@"0"]) {
        stealsNumber = [_stealsOut.text integerValue];
        _stealsOut.text = [NSString stringWithFormat:@"%ld",(long)[_stealsOut.text integerValue]];
    } else {
        _stealsOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)blocksEdit:(id)sender {
    if ([_blocksOut.text integerValue] > 0) {
        blocksNumber = [_blocksOut.text integerValue];
        _blocksOut.text = [NSString stringWithFormat:@"%ld",(long)[_blocksOut.text integerValue]];
    } else if ([_blocksOut.text isEqualToString:@"0"]) {
        blocksNumber = [_blocksOut.text integerValue];
        _blocksOut.text = [NSString stringWithFormat:@"%ld",(long)[_blocksOut.text integerValue]];
    } else {
        _blocksOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)DefReboundAct:(id)sender {
    if (!DefReboundLit) {
        newLit = @"DefReboundLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"DefReboundLit";
    } else {
        [_DefReboundOut becomeFirstResponder];
    }
}

- (IBAction)TotReboundAct:(id)sender {
    if (!TotReboundLit) {
        newLit = @"TotReboundLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"TotReboundLit";
    } else {
        [_TotReboundOut becomeFirstResponder];
    }
}

- (IBAction)defRebEdit:(id)sender {
    if ([_DefReboundOut.text integerValue] > 0) {
        DefReboundNumber = [_DefReboundOut.text integerValue];
        _DefReboundOut.text = [NSString stringWithFormat:@"%ld",(long)[_DefReboundOut.text integerValue]];
    } else if ([_DefReboundOut.text isEqualToString:@"0"]) {
        DefReboundNumber = [_DefReboundOut.text integerValue];
        _DefReboundOut.text = [NSString stringWithFormat:@"%ld",(long)[_DefReboundOut.text integerValue]];
    } else {
        _DefReboundOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)totRebEdit:(id)sender {
    if ([_TotReboundOut.text integerValue] > 0) {
        TotReboundNumber = [_TotReboundOut.text integerValue];
        _TotReboundOut.text = [NSString stringWithFormat:@"%ld",(long)[_TotReboundOut.text integerValue]];
    } else if ([_TotReboundOut.text isEqualToString:@"0"]) {
        TotReboundNumber = [_TotReboundOut.text integerValue];
        _TotReboundOut.text = [NSString stringWithFormat:@"%ld",(long)[_TotReboundOut.text integerValue]];
    } else {
        _TotReboundOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)yourScoreAct:(id)sender {
    if (!yourScoreLit) {
        newLit = @"yourScoreLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"yourScoreLit";
    } else {
        [_yourScoreOut becomeFirstResponder];
    }
}

- (IBAction)opponentScoreAct:(id)sender {
    if (!oppScoreLit) {
        newLit = @"oppScoreLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"oppScoreLit";
    } else {
        [_opponentScoreOut becomeFirstResponder];
    }
}

- (IBAction)yourScoreEdit:(id)sender {
    if ([_yourScoreOut.text integerValue] > 0) {
        yourScoreNumber = [_yourScoreOut.text integerValue];
        _yourScoreOut.text = [NSString stringWithFormat:@"%ld",(long)[_yourScoreOut.text integerValue]];
    } else if ([_yourScoreOut.text isEqualToString:@"0"]) {
        yourScoreNumber = [_yourScoreOut.text integerValue];
        _yourScoreOut.text = [NSString stringWithFormat:@"%ld",(long)[_yourScoreOut.text integerValue]];
    } else {
        _yourScoreOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)oppScoreEdit:(id)sender {
    if ([_opponentScoreOut.text integerValue] > 0) {
        oppScoreNumber = [_opponentScoreOut.text integerValue];
        _opponentScoreOut.text = [NSString stringWithFormat:@"%ld",(long)[_opponentScoreOut.text integerValue]];
    } else if ([_opponentScoreOut.text isEqualToString:@"0"]) {
        oppScoreNumber = [_opponentScoreOut.text integerValue];
        _opponentScoreOut.text = [NSString stringWithFormat:@"%ld",(long)[_opponentScoreOut.text integerValue]];
    } else {
        _opponentScoreOut.text = [NSString stringWithFormat:@"-"];
    }
}

- (IBAction)twoPtMadeClick:(id)sender {
    if (!twoPtMadeLit) {
        newLit = @"twoPtMadeLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"twoPtMadeLit";
    } else {
        [_twoPtMadeOut becomeFirstResponder];
    }
}

- (IBAction)twoPtAttClick:(id)sender {
    if (!twoPtAttLit) {
        newLit = @"twoPtAttLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"twoPtAttLit";
    } else {
        [_twoPtAttOut becomeFirstResponder];
    }
}

- (IBAction)threePtMadeClick:(id)sender {
    if (!threePtMadeLit) {
        newLit = @"threePtMadeLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"threePtMadeLit";
    } else {
        [_threePtMadeOut becomeFirstResponder];
    }
}

- (IBAction)threePtAttClick:(id)sender {
    if (!threePtAttLit) {
        newLit = @"threePtAttLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"threePtAttLit";
    } else {
        [_threePtAttOut becomeFirstResponder];
    }
}

- (IBAction)assistsAct:(id)sender {
    if (!assistsLit) {
        newLit = @"assistsLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"assistsLit";
    } else {
        [_assistsOut becomeFirstResponder];
    }
}

- (IBAction)turnoversAct:(id)sender {
    if (!turnoversLit) {
        newLit = @"turnoversLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"turnoversLit";
    } else {
        [_turnoversOut becomeFirstResponder];
    }
}

- (IBAction)stealsAct:(id)sender {
    if (!stealsLit) {
        newLit = @"stealsLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"stealsLit";
    } else {
        [_stealsOut becomeFirstResponder];
    }
}

- (IBAction)blocksAct:(id)sender {
    if (!blocksLit) {
        newLit = @"blocksLit";
        [self ToggleTextFields:newLit from:currentLit];
        currentLit = @"blocksLit";
    } else {
        [_blocksOut becomeFirstResponder];
    }
}


- (IBAction)plus:(id)sender {
    if (!finalScore.hidden) {
        if (yourScoreLit) {
            yourScoreNumber = [_yourScoreOut.text integerValue];
            yourScoreNumber++;
            _yourScoreOut.text = [NSString stringWithFormat:@"%ld",(long)yourScoreNumber];
        } else if (oppScoreLit) {
            oppScoreNumber = [_opponentScoreOut.text integerValue];
            oppScoreNumber++;
            _opponentScoreOut.text = [NSString stringWithFormat:@"%ld",(long)oppScoreNumber];
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    } else if (!shootingView.hidden) {
        if (twoPtMadeLit) {
            twoPtMadeNumber = [_twoPtMadeOut.text integerValue];
            twoPtMadeNumber++;
            _twoPtMadeOut.text = [NSString stringWithFormat:@"%ld",(long)twoPtMadeNumber];
        } else if (twoPtAttLit) {
            twoPtAttNumber = [_twoPtAttOut.text integerValue];
            twoPtAttNumber++;
            _twoPtAttOut.text = [NSString stringWithFormat:@"%ld",(long)twoPtAttNumber];
        } else if (threePtMadeLit) {
            threePtMadeNumber = [_threePtMadeOut.text integerValue];
            threePtMadeNumber++;
            _threePtMadeOut.text = [NSString stringWithFormat:@"%ld",(long)threePtMadeNumber];
        } else if (threePtAttLit) {
            threePtAttNumber = [_threePtAttOut.text integerValue];
            threePtAttNumber++;
            _threePtAttOut.text = [NSString stringWithFormat:@"%ld",(long)threePtAttNumber];
        } else if (freePtMadeLit) {
            freePtMadeNumber = [_freeMadeOut.text integerValue];
            freePtMadeNumber++;
            _freeMadeOut.text = [NSString stringWithFormat:@"%ld",(long)freePtMadeNumber];
        } else if (freePtAttLit) {
            freePtAttNumber = [_freeAttOut.text integerValue];
            freePtAttNumber++;
            _freeAttOut.text = [NSString stringWithFormat:@"%ld",(long)freePtAttNumber];
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    } else if (!offenseView.hidden) {
        if (assistsLit) {
            assistsNumber = [_assistsOut.text integerValue];
            assistsNumber++;
            _assistsOut.text = [NSString stringWithFormat:@"%ld",(long)assistsNumber];
        } else if (turnoversLit) {
            turnoversNumber = [_turnoversOut.text integerValue];
            turnoversNumber++;
            _turnoversOut.text = [NSString stringWithFormat:@"%ld",(long)turnoversNumber];
        } else if (OffReboundLit) {
            OffReboundNumber = [_offReboundOut.text integerValue];
            OffReboundNumber++;
            _offReboundOut.text = [NSString stringWithFormat:@"%ld",(long)OffReboundNumber];
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    } else if (!defenseView.hidden) {
        if (stealsLit) {
            stealsNumber = [_stealsOut.text integerValue];
            stealsNumber++;
            _stealsOut.text = [NSString stringWithFormat:@"%ld",(long)stealsNumber];
        } else if (blocksLit) {
            blocksNumber = [_blocksOut.text integerValue];
            blocksNumber++;
            _blocksOut.text = [NSString stringWithFormat:@"%ld",(long)blocksNumber];
        } else if (DefReboundLit) {
            DefReboundNumber = [_DefReboundOut.text integerValue];
            DefReboundNumber++;
            _DefReboundOut.text = [NSString stringWithFormat:@"%ld",(long)DefReboundNumber];
        } else if (TotReboundLit) {
            TotReboundNumber = [_TotReboundOut.text integerValue];
            TotReboundNumber++;
            _TotReboundOut.text = [NSString stringWithFormat:@"%ld",(long)TotReboundNumber];
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    }
}

- (IBAction)minus:(id)sender {
    if (!finalScore.hidden) {
        if (yourScoreLit) {
            if (yourScoreNumber > 0) {
                yourScoreNumber = [_yourScoreOut.text integerValue];
                yourScoreNumber--;
                _yourScoreOut.text = [NSString stringWithFormat:@"%ld",(long)yourScoreNumber];
            } else {
                _yourScoreOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (oppScoreLit) {
            if (oppScoreNumber > 0) {
                oppScoreNumber = [_opponentScoreOut.text integerValue];
                oppScoreNumber--;
                _opponentScoreOut.text = [NSString stringWithFormat:@"%ld",(long)oppScoreNumber];
            } else {
                _opponentScoreOut.text = [NSString stringWithFormat:@"-"];
            }
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    } else if (!shootingView.hidden) {
        if (twoPtMadeLit) {
            if (twoPtMadeNumber > 0) {
                twoPtMadeNumber = [_twoPtMadeOut.text integerValue];
                twoPtMadeNumber--;
                _twoPtMadeOut.text = [NSString stringWithFormat:@"%ld",(long)twoPtMadeNumber];
            } else {
                _twoPtMadeOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (twoPtAttLit) {
            if (twoPtAttNumber > 0) {
                twoPtAttNumber = [_twoPtAttOut.text integerValue];
                twoPtAttNumber--;
                _twoPtAttOut.text = [NSString stringWithFormat:@"%ld",(long)twoPtAttNumber];
            } else {
                _twoPtAttOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (threePtMadeLit) {
            if (threePtMadeNumber > 0) {
                threePtMadeNumber = [_threePtMadeOut.text integerValue];
                threePtMadeNumber--;
                _threePtMadeOut.text = [NSString stringWithFormat:@"%ld",(long)threePtMadeNumber];
            } else {
                _threePtMadeOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (threePtAttLit) {
            if (threePtAttNumber > 0) {
                threePtAttNumber = [_threePtAttOut.text integerValue];
                threePtAttNumber--;
                _threePtAttOut.text = [NSString stringWithFormat:@"%ld",(long)threePtAttNumber];
            } else {
                _threePtAttOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (freePtMadeLit) {
            if (freePtMadeNumber > 0) {
                freePtMadeNumber = [_freeMadeOut.text integerValue];
                freePtMadeNumber--;
                _freeMadeOut.text = [NSString stringWithFormat:@"%ld",(long)freePtMadeNumber];
            } else {
                _freeMadeOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (freePtAttLit) {
            if (freePtAttNumber > 0) {
                freePtAttNumber = [_freeAttOut.text integerValue];
                freePtAttNumber--;
                _freeAttOut.text = [NSString stringWithFormat:@"%ld",(long)freePtAttNumber];
            } else {
                _freeAttOut.text = [NSString stringWithFormat:@"-"];
            }
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    } else if (!offenseView.hidden) {
        if (assistsLit) {
            if (assistsNumber > 0) {
                assistsNumber = [_assistsOut.text integerValue];
                assistsNumber--;
                _assistsOut.text = [NSString stringWithFormat:@"%ld",(long)assistsNumber];
            } else {
                _assistsOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (turnoversLit) {
            if (turnoversNumber > 0) {
                turnoversNumber = [_turnoversOut.text integerValue];
                turnoversNumber--;
                _turnoversOut.text = [NSString stringWithFormat:@"%ld",(long)turnoversNumber];
            } else {
                _turnoversOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (OffReboundLit) {
            if (OffReboundNumber > 0) {
                OffReboundNumber = [_offReboundOut.text integerValue];
                OffReboundNumber--;
                _offReboundOut.text = [NSString stringWithFormat:@"%ld",(long)OffReboundNumber];
            } else {
                _offReboundOut.text = [NSString stringWithFormat:@"-"];
            }
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    } else if (!defenseView.hidden) {
        if (stealsLit) {
            if (stealsNumber > 0) {
                stealsNumber = [_stealsOut.text integerValue];
                stealsNumber--;
                _stealsOut.text = [NSString stringWithFormat:@"%ld",(long)stealsNumber];
            } else {
                _stealsOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (blocksLit) {
            if (blocksNumber > 0) {
                blocksNumber = [_blocksOut.text integerValue];
                blocksNumber--;
                _blocksOut.text = [NSString stringWithFormat:@"%ld",(long)blocksNumber];
            } else {
                _blocksOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (DefReboundLit) {
            if (DefReboundNumber > 0) {
                DefReboundNumber = [_DefReboundOut.text integerValue];
                DefReboundNumber--;
                _DefReboundOut.text = [NSString stringWithFormat:@"%ld",(long)DefReboundNumber];
            } else {
                _DefReboundOut.text = [NSString stringWithFormat:@"-"];
            }
        } else if (TotReboundLit) {
            if (TotReboundNumber > 0) {
                TotReboundNumber = [_TotReboundOut.text integerValue];
                TotReboundNumber--;
                _TotReboundOut.text = [NSString stringWithFormat:@"%ld",(long)TotReboundNumber];
            } else {
                _TotReboundOut.text = [NSString stringWithFormat:@"-"];
            }
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    }
}

- (IBAction)toolbarClose:(id)sender {
    _toolbarHelp.hidden = YES;
}

- (IBAction)mainHelpClose:(id)sender {
    _mainHelp.hidden = YES;
}

@end
