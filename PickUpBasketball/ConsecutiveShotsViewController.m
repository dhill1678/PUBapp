//
//  ConsecutiveShotsViewController.m
//  PickUpStats
//
//  Created by DAVID HILL on 8/9/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import "ConsecutiveShotsViewController.h"
#import "ProgressHUD.h"

#import <Parse/Parse.h>
#import "Configs.h"

@interface ConsecutiveShotsViewController ()

@end

@implementation ConsecutiveShotsViewController

@synthesize PracticeType, Zone;

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
    
    self.title = PracticeType;
    NSLog(@"%@", Zone);
    
    madeNumber = 0;
    attemptedNumber = 0;
    madeLit = NO;
    attemptedLit = NO;
    
    if ([PracticeType isEqualToString:@"Shot Chart"]) {
        _subLabel.hidden = NO;
        _ConsecutiveView.hidden = YES;
        _MadeAttemptedView.hidden = NO;
        _freeThrowView.hidden = YES;
        _ButtonStart.hidden = YES;
        _timerLabel.hidden = YES;
        _startingLabel.hidden = YES;
    } else if ([PracticeType isEqualToString:@"Heat Check"]) {
        _subLabel.hidden = YES;
        _ConsecutiveView.hidden = NO;
        _MadeAttemptedView.hidden = YES;
        _freeThrowView.hidden = YES;
        _ButtonStart.hidden = YES;
        _timerLabel.hidden = YES;
        _startingLabel.hidden = YES;
    } else if ([PracticeType isEqualToString:@"Quick Release"]) {
        _subLabel.hidden = NO;
        _ConsecutiveView.hidden = YES;
        _MadeAttemptedView.hidden = NO;
        _freeThrowView.hidden = YES;
        _ButtonStart.hidden = NO;
        quickReleaseStarted = NO;
        _timerLabel.hidden = YES;
        _startingLabel.hidden = YES;
        
        timerCount = 66;
        
        // timer label stuff
        //_timerLabel.font = [UIFont fontWithName:@"scoreboard.ttf" size:50];
        _startingLabel.layer.zPosition = 100; // bring to front
        
        ClockFinished = 0;
        
    } else if ([PracticeType isEqualToString:@"Free Throws"]) {
        _subLabel.hidden = NO;
        _ConsecutiveView.hidden = YES;
        _MadeAttemptedView.hidden = NO;
        _freeThrowView.hidden = NO;
        _ButtonStart.hidden = YES;
        _timerLabel.hidden = YES;
        _startingLabel.hidden = YES;
    } else if ([PracticeType isEqualToString:@"Alternate Hand Layups"]) {
        _subLabel.hidden = YES;
        _ConsecutiveView.hidden = NO;
        _MadeAttemptedView.hidden = YES;
        _freeThrowView.hidden = YES;
        _ButtonStart.hidden = YES;
        _timerLabel.hidden = YES;
        _startingLabel.hidden = YES;
    } else {
        NSLog(@"There's a Problem");
    }
    
    // round corners on buttons
    CALayer *btnLayer1 = [_consecutiveButtonOut layer];
    [btnLayer1 setMasksToBounds:YES];
    [btnLayer1 setCornerRadius:10.0f];
    CALayer *btnLayer2 = [_percentageButtonOut layer];
    [btnLayer2 setMasksToBounds:YES];
    [btnLayer2 setCornerRadius:10.0f];
    CALayer *btnLayer3 = [_ButtonStart layer];
    [btnLayer3 setMasksToBounds:YES];
    [btnLayer3 setCornerRadius:10.0f];
    
    if ([PracticeType isEqualToString:@"Free Throws"]) {
        percentageView = YES;
        [self toggleFreeThrowStyle:percentageView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self.numberText resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField) {
        //[textField resignFirstResponder];
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

- (void)toggleFreeThrowStyle:(BOOL)clickedStyle {
    switch(clickedStyle) {
        case YES:
            _percentageButtonOut.backgroundColor = [UIColor colorWithRed:0/255.0f green:31/255.0f blue:112/255.0f alpha:1.0f];
            [_percentageButtonOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _consecutiveButtonOut.backgroundColor = [UIColor clearColor];
            [_consecutiveButtonOut setTitleColor:[UIColor colorWithRed:0/255.0f green:31/255.0f blue:112/255.0f alpha:1.0f] forState:UIControlStateNormal];
            
            _subLabel.hidden = NO;
            _ConsecutiveView.hidden = YES;
            _MadeAttemptedView.hidden = NO;
            break;
        case NO:
            _consecutiveButtonOut.backgroundColor = [UIColor colorWithRed:0/255.0f green:31/255.0f blue:112/255.0f alpha:1.0f];
            [_consecutiveButtonOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _percentageButtonOut.backgroundColor = [UIColor clearColor];
            [_percentageButtonOut setTitleColor:[UIColor colorWithRed:0/255.0f green:31/255.0f blue:112/255.0f alpha:1.0f] forState:UIControlStateNormal];
            
            _subLabel.hidden = YES;
            _ConsecutiveView.hidden = NO;
            _MadeAttemptedView.hidden = YES;
            break;
        default:
            NSLog(@"There's a Problem");
            break;
    }
}

- (IBAction)save:(id)sender {
    PFUser *user = [PFUser currentUser];
    
    if ([PracticeType isEqualToString:@"Shot Chart"]) {
        
        if (![_madeNum.text isEqualToString:@"-"] && ![_attemptedNum.text isEqualToString:@"-"]) {
            
            PFObject *shotchart = [PFObject objectWithClassName:@"Practice"];
            [shotchart setObject:user forKey:@"user"];
            [shotchart setObject:PracticeType forKey:@"type"];
            [shotchart setObject:Zone forKey:@"zone"];
            [shotchart setObject:_CourtStyle forKey:@"courtstyle"];
            [shotchart setObject:_madeNum.text forKey:@"makes"];
            [shotchart setObject:_attemptedNum.text forKey:@"attempts"];
            //[shotchart setObject:[NSDate date] forKey:@"createdAt"];
            
            [shotchart saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error == nil)
                {
                    [ProgressHUD showSuccess:@"Saved."];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else [ProgressHUD showError:@"Network error."];
            }];
            
        } else {
            [ProgressHUD showError:@"Please Enter Stats"];
        }
        
    } else if ([PracticeType isEqualToString:@"Heat Check"]) {
        
        if (![_consecutiveNum.text isEqualToString:@"-"]) {
            
            PFObject *shotchart = [PFObject objectWithClassName:@"Practice"];
            [shotchart setObject:user forKey:@"user"];
            [shotchart setObject:PracticeType forKey:@"type"];
            [shotchart setObject:Zone forKey:@"zone"];
            [shotchart setObject:_CourtStyle forKey:@"courtstyle"];
            [shotchart setObject:_consecutiveNum.text forKey:@"consecutive"];
            
            [shotchart saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error == nil)
                {
                    [ProgressHUD showSuccess:@"Saved."];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else [ProgressHUD showError:@"Network error."];
            }];
            
        } else {
            [ProgressHUD showError:@"Please Enter Stats"];
        }
        
    } else if ([PracticeType isEqualToString:@"Quick Release"]) {
        
        if (ClockFinished > 0) {
            if (![_madeNum.text isEqualToString:@"-"] && ![_attemptedNum.text isEqualToString:@"-"]) {
                
                PFObject *shotchart = [PFObject objectWithClassName:@"Practice"];
                [shotchart setObject:user forKey:@"user"];
                [shotchart setObject:PracticeType forKey:@"type"];
                [shotchart setObject:Zone forKey:@"zone"];
                [shotchart setObject:_CourtStyle forKey:@"courtstyle"];
                [shotchart setObject:_madeNum.text forKey:@"makes"];
                [shotchart setObject:_attemptedNum.text forKey:@"attempts"];
                //[shotchart setObject:[NSDate date] forKey:@"createdAt"];
                
                [shotchart saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error == nil)
                    {
                        [ProgressHUD showSuccess:@"Saved."];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else [ProgressHUD showError:@"Network error."];
                }];
                
            } else {
                [ProgressHUD showError:@"Please Enter Stats"];
            }

        } else {
            [ProgressHUD showError:@"You Must Complete The Drill At Least Once Before Saving"];
        }
        
    } else if ([PracticeType isEqualToString:@"Free Throws"]) {
        
        if (percentageView) {
            if (![_madeNum.text isEqualToString:@"-"] && ![_attemptedNum.text isEqualToString:@"-"]) {
                
                PFObject *shotchart = [PFObject objectWithClassName:@"Practice"];
                [shotchart setObject:user forKey:@"user"];
                [shotchart setObject:PracticeType forKey:@"type"];
                [shotchart setObject:_madeNum.text forKey:@"makes"];
                [shotchart setObject:_attemptedNum.text forKey:@"attempts"];
                //[shotchart setObject:[NSDate date] forKey:@"createdAt"];
                
                [shotchart saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error == nil)
                    {
                        [ProgressHUD showSuccess:@"Saved."];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else [ProgressHUD showError:@"Network error."];
                }];
                
            } else {
                [ProgressHUD showError:@"Please Enter Stats"];
            }
        } else {
            if (![_consecutiveNum.text isEqualToString:@"-"]) {
                
                PFObject *shotchart = [PFObject objectWithClassName:@"Practice"];
                [shotchart setObject:user forKey:@"user"];
                [shotchart setObject:PracticeType forKey:@"type"];
                [shotchart setObject:_consecutiveNum.text forKey:@"consecutive"];
                
                [shotchart saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error == nil)
                    {
                        [ProgressHUD showSuccess:@"Saved."];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else [ProgressHUD showError:@"Network error."];
                }];
                
            } else {
                [ProgressHUD showError:@"Please Enter Stats"];
            }
        }
        
    } else if ([PracticeType isEqualToString:@"Alternate Hand Layups"]) {
        
        if (![_consecutiveNum.text isEqualToString:@"-"]) {
            
            PFObject *shotchart = [PFObject objectWithClassName:@"Practice"];
            [shotchart setObject:user forKey:@"user"];
            [shotchart setObject:PracticeType forKey:@"type"];
            [shotchart setObject:_consecutiveNum.text forKey:@"consecutive"];
            
            [shotchart saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error == nil)
                {
                    [ProgressHUD showSuccess:@"Saved."];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else [ProgressHUD showError:@"Network error."];
            }];
            
        } else {
            [ProgressHUD showError:@"Please Enter Stats"];
        }
        
    } else {
        NSLog(@"There's a Problem");
    }
    
}

- (IBAction)plus:(id)sender {
    if (_ConsecutiveView.hidden) {
        madeNumber = [_madeNum.text integerValue];
        attemptedNumber = [_attemptedNum.text integerValue];
        if (attemptedNumber < madeNumber) {
            attemptedNumber = madeNumber;
            _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
        }
        
        if (madeLit) {
            madeNumber++;
            attemptedNumber++;
            
            _madeNum.text = [NSString stringWithFormat:@"%ld",(long)madeNumber];
            _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
        } else if (attemptedLit) {
            attemptedNumber++;
            _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    } else {
        consecutiveNumber = [_consecutiveNum.text integerValue];
        
        if (consecutiveLit) {
            consecutiveNumber++;
            
            _consecutiveNum.text = [NSString stringWithFormat:@"%ld",(long)consecutiveNumber];
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    }
}

- (IBAction)minus:(id)sender {
    if (_ConsecutiveView.hidden) {
        madeNumber = [_madeNum.text integerValue];
        attemptedNumber = [_attemptedNum.text integerValue];
        if (attemptedNumber < madeNumber) {
            attemptedNumber = madeNumber;
            _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
        }
        
        if (madeLit) {
            if (madeNumber > 0) {
                madeNumber--;
                _madeNum.text = [NSString stringWithFormat:@"%ld",(long)madeNumber];
            } else {
                _madeNum.text = [NSString stringWithFormat:@"-"];
            }
        } else if (attemptedLit) {
            if (attemptedNumber > 0 && attemptedNumber > madeNumber) {
                attemptedNumber--;
                _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
            } else if (attemptedNumber <= 0 && attemptedNumber >= madeNumber) {
                _attemptedNum.text = [NSString stringWithFormat:@"-"];
            }
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    } else {
        consecutiveNumber = [_consecutiveNum.text integerValue];
        
        if (consecutiveLit) {
            if (consecutiveNumber > 0) {
                consecutiveNumber--;
                _consecutiveNum.text = [NSString stringWithFormat:@"%ld",(long)consecutiveNumber];
            } else {
                _consecutiveNum.text = [NSString stringWithFormat:@"-"];
            }
        } else {
            [ProgressHUD showError:@"Please Select Stat To Edit"];
        }
    }
}

- (IBAction)ConsecutiveAction:(id)sender {
    if (_ConsecutiveView) {
        if (!consecutiveLit) {
            consecutiveLit = YES;
            
            madeLit = NO;
            attemptedLit = NO;
            
            [_consecutiveNum setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
            [_consecutiveNum setTextColor:[UIColor whiteColor]];
            
            [_madeNum setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
            [_madeNum setTextColor:[UIColor blackColor]];
            [_attemptedNum setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
            [_attemptedNum setTextColor:[UIColor blackColor]];
        } else {
            [_consecutiveNum becomeFirstResponder];
        }
    }
}

- (IBAction)madeAction:(id)sender {
    if (_MadeAttemptedView) {
        if (!madeLit) {
            madeLit = YES;
            attemptedLit = NO;
            
            consecutiveLit = NO;
            
            [_madeNum setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
            [_madeNum setTextColor:[UIColor whiteColor]];
            [_attemptedNum setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
            [_attemptedNum setTextColor:[UIColor blackColor]];
            
            [_consecutiveNum setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
            [_consecutiveNum setTextColor:[UIColor blackColor]];
        } else {
            [_madeNum becomeFirstResponder];
        }
    }
}

- (IBAction)attemptedAction:(id)sender {
    if (_MadeAttemptedView) {
        if (!attemptedLit) {
            madeLit = NO;
            attemptedLit = YES;
            
            consecutiveLit = NO;
            
            [_attemptedNum setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
            [_attemptedNum setTextColor:[UIColor whiteColor]];
            [_madeNum setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
            [_madeNum setTextColor:[UIColor blackColor]];
            
            [_consecutiveNum setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
            [_consecutiveNum setTextColor:[UIColor blackColor]];
        } else {
            [_attemptedNum becomeFirstResponder];
        }
    }
}

- (IBAction)madeClosed:(id)sender {
    if (_MadeAttemptedView) {
        if ([_madeNum.text integerValue] > 0) {
            madeNumber = [_madeNum.text integerValue];
            _madeNum.text = [NSString stringWithFormat:@"%ld",(long)[_madeNum.text integerValue]];
        } else if ([_madeNum.text isEqualToString:@"0"]) {
            madeNumber = [_madeNum.text integerValue];
            _madeNum.text = [NSString stringWithFormat:@"%ld",(long)[_madeNum.text integerValue]];
        } else {
            _madeNum.text = [NSString stringWithFormat:@"-"];
        }
    }
    
    if (attemptedNumber < madeNumber) {
        attemptedNumber = madeNumber;
        _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
    }
}

- (IBAction)attemptedClosed:(id)sender {
    if (_MadeAttemptedView) {
        if ([_attemptedNum.text integerValue] > 0) {
            attemptedNumber = [_attemptedNum.text integerValue];
            _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)[_attemptedNum.text integerValue]];
        } else if ([_attemptedNum.text isEqualToString:@"0"]) {
            attemptedNumber = [_attemptedNum.text integerValue];
            _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)[_attemptedNum.text integerValue]];
        } else {
            _attemptedNum.text = [NSString stringWithFormat:@"-"];
        }
    }
    
    if (attemptedNumber < madeNumber) {
        attemptedNumber = madeNumber;
        _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
    }
}

- (IBAction)consecutiveClosed:(id)sender {
    if (_ConsecutiveView) {
        if ([_consecutiveNum.text integerValue] > 0) {
             consecutiveNumber = [_consecutiveNum.text integerValue];
            _consecutiveNum.text = [NSString stringWithFormat:@"%ld",(long)[_consecutiveNum.text integerValue]];
        } else if ([_consecutiveNum.text isEqualToString:@"0"]) {
            consecutiveNumber = [_consecutiveNum.text integerValue];
            _consecutiveNum.text = [NSString stringWithFormat:@"%ld",(long)[_consecutiveNum.text integerValue]];
        } else {
            _consecutiveNum.text = [NSString stringWithFormat:@"-"];
        }
    }
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

- (IBAction)consecutiveButtonAct:(id)sender {
    percentageView = NO;
    [self toggleFreeThrowStyle:percentageView];
}

- (IBAction)percentageButtonAct:(id)sender {
    percentageView = YES;
    [self toggleFreeThrowStyle:percentageView];
}
- (IBAction)StartButton:(id)sender {
    if (!quickReleaseStarted) {
        NSLog(@"Started");
        quickReleaseStarted = YES;
        [sender setTitle:@"STOP" forState:UIControlStateNormal];
        //_ButtonStart.titleLabel.text = @"STOP";
        [sender setTitleColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f] forState:UIControlStateNormal];
        //_ButtonStart.titleLabel.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
        
        queryTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerControl) userInfo:nil repeats:YES];
    } else {
        NSLog(@"Stopped");
        quickReleaseStarted = NO;
        [sender setTitle:@"START" forState:UIControlStateNormal];
        //_ButtonStart.titleLabel.text = @"START";
        [sender setTitleColor:[UIColor colorWithRed:115/255.0f green:153/255.0f blue:198/255.0f alpha:1.0f] forState:UIControlStateNormal];
        //_ButtonStart.titleLabel.textColor = [UIColor colorWithRed:115/255.0f green:153/255.0f blue:198/255.0f alpha:1.0f];
        
        [self stopTimer];
    }
}

// start timer
- (void) timerControl {
    timerCount--;
    NSLog(@"%ld",(long)timerCount);
    
    if (timerCount == 65) {
        [self startTimer];
        
        _startingLabel.text = [NSString stringWithFormat:@"Starting In: %d",timerCount-60];
    } else if (timerCount > 60) {
        _startingLabel.text = [NSString stringWithFormat:@"Starting In: %d",timerCount-60];
    } else if (timerCount == 60) {
        _startingLabel.hidden = YES;
        _timerLabel.text = [NSString stringWithFormat:@"%ld",(long)timerCount];
    } else if (timerCount >= 0) {
        _timerLabel.text = [NSString stringWithFormat:@"%ld",(long)timerCount];
    } else if (timerCount < 0) {
        [self stopTimer];
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"DONE! How'd You Do?"]];
        
        [_ButtonStart setTitle:@"START" forState:UIControlStateNormal];
        [_ButtonStart setTitleColor:[UIColor colorWithRed:115/255.0f green:153/255.0f blue:198/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        ClockFinished = 1;
    }
}

// start timer
- (void) startTimer {
    _timerLabel.hidden = NO;
    _startingLabel.hidden = NO;
    
    _subLabel.hidden = YES;
    _mainLabel.hidden = YES;
}

// stop timer in background
- (void) stopTimer {
    [queryTimer invalidate],
    queryTimer = nil;
    
    _timerLabel.hidden = YES;
    _startingLabel.hidden = YES;
    timerCount = 66;
    _timerLabel.text = [NSString stringWithFormat:@"%d",60];
    
    _subLabel.hidden = NO;
    _mainLabel.hidden = NO;
    
    quickReleaseStarted = NO;
}

@end
