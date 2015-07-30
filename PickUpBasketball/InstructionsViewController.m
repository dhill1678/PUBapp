//
//  InstructionsViewController.m
//  PickUpBasketball
//
//  Created by DAVID HILL on 4/14/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//

#import "InstructionsViewController.h"
#import "ProgressHUD.h"

@interface InstructionsViewController ()

@end

@implementation InstructionsViewController

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
    
    //_madeNum.delegate = self;
    //_attemptedNum.delegate = self;
    
    madeNumber = 0;
    attemptedNumber = 0;
    madeLit = NO;
    attemptedLit = NO;
    
    _directionLabel.text = @"Tap Either Stat Entry Box Below To Highlight & Edit It";
    
    directionControl = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)dismissKeyboard {
    [self.view endEditing: true];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self.numberText resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField) {
        //[textField resignFirstResponder];
        [self dismissKeyboard];
    }
    
    return NO;
}
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)plus:(id)sender {
    madeNumber = [_madeNum.text integerValue];
    attemptedNumber = [_attemptedNum.text integerValue];
    if (attemptedNumber < madeNumber) {
        attemptedNumber = madeNumber;
        _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
    }
    
    if (madeLit) {
        if (directionControl == 1) {
            _directionLabel.text = @"Double Tap Stat Entry Box To Display Keyboard";
            directionControl++;
        }
        
        madeNumber++;
        attemptedNumber++;
        
        _madeNum.text = [NSString stringWithFormat:@"%ld",(long)madeNumber];
        _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
    } else if (attemptedLit) {
        if (directionControl == 1) {
            _directionLabel.text = @"Double Tap Stat Entry Box To Display Keyboard";
            directionControl++;
        }
        
        attemptedNumber++;
        _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
    } else {
        [ProgressHUD showError:@"Please Select Stat To Edit"];
    }
}

- (IBAction)minus:(id)sender {
    madeNumber = [_madeNum.text integerValue];
    attemptedNumber = [_attemptedNum.text integerValue];
    if (attemptedNumber < madeNumber) {
        attemptedNumber = madeNumber;
        _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
    }
    
    if (madeLit) {
        if (directionControl == 1) {
            _directionLabel.text = @"Double Tap Stat Entry Box To Display Keyboard";
            directionControl++;
        }
        
        if (madeNumber > 0) {
            madeNumber--;
            _madeNum.text = [NSString stringWithFormat:@"%ld",(long)madeNumber];
        } else {
            _madeNum.text = [NSString stringWithFormat:@"-"];
        }
    } else if (attemptedLit) {
        if (directionControl == 1) {
            _directionLabel.text = @"Double Tap Stat Entry Box To Display Keyboard";
            directionControl++;
        }
        
        if (attemptedNumber > 0 && attemptedNumber > madeNumber) {
            attemptedNumber--;
            _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
        } else if (attemptedNumber <= 0 && attemptedNumber >= madeNumber) {
            _attemptedNum.text = [NSString stringWithFormat:@"-"];
        }
    } else {
        [ProgressHUD showError:@"Please Select Stat To Edit"];
    }
}

- (IBAction)madeAction:(id)sender {
    if (!madeLit) {
        if (directionControl == 0) {
            _directionLabel.text = @"Use The +/- Keys At The Bottom Of The Screen To Alter Stat";
            directionControl++;
        }
        
        madeLit = YES;
        attemptedLit = NO;
        
        [_madeNum setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_madeNum setTextColor:[UIColor whiteColor]];
        [_attemptedNum setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_attemptedNum setTextColor:[UIColor blackColor]];
    } else {
        if (directionControl == 2) {
            _directionLabel.text = @"Type Stat";
            directionControl++;
        }
        
        [_madeNum becomeFirstResponder];
    }
    
}

- (IBAction)attemptedAction:(id)sender {
    if (!attemptedLit) {
        if (directionControl == 0) {
            _directionLabel.text = @"Use The +/- Keys At The Bottom Of The Screen To Alter Stat";
            directionControl++;
        }
        
        madeLit = NO;
        attemptedLit = YES;
        
        [_attemptedNum setBackground:[UIImage imageNamed:@"DarkTextBack.png"]];
        [_attemptedNum setTextColor:[UIColor whiteColor]];
        [_madeNum setBackground:[UIImage imageNamed:@"lightTextBack.png"]];
        [_madeNum setTextColor:[UIColor blackColor]];
    } else {
        if (directionControl == 2) {
            _directionLabel.text = @"Type Stat";
            directionControl++;
        }
        
        [_attemptedNum becomeFirstResponder];
    }
    
}

- (IBAction)madeClosed:(id)sender {
    if (directionControl == 3) {
        _directionLabel.text = @"DONE! Use +/- or Keyboard To Update Stats. Your Choice.";
        directionControl++;
    }
    
    if ([_madeNum.text integerValue] > 0) {
        madeNumber = [_madeNum.text integerValue];
        _madeNum.text = [NSString stringWithFormat:@"%ld",(long)[_madeNum.text integerValue]];
    } else if ([_madeNum.text isEqualToString:@"0"]) {
        madeNumber = [_madeNum.text integerValue];
        _madeNum.text = [NSString stringWithFormat:@"%ld",(long)[_madeNum.text integerValue]];
    } else {
        _madeNum.text = [NSString stringWithFormat:@"-"];
    }
    
    if (attemptedNumber < madeNumber) {
        attemptedNumber = madeNumber;
        _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
    }
}

- (IBAction)attemptedClosed:(id)sender {
    if (directionControl == 3) {
        _directionLabel.text = @"DONE! Use +/- or Keyboard To Update Stats. Your Choice.";
        directionControl++;
    }
    
    if ([_attemptedNum.text integerValue] > 0) {
        attemptedNumber = [_attemptedNum.text integerValue];
        _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)[_attemptedNum.text integerValue]];
    } else if ([_attemptedNum.text isEqualToString:@"0"]) {
        attemptedNumber = [_attemptedNum.text integerValue];
        _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)
                              [_attemptedNum.text integerValue]];
    } else {
        _attemptedNum.text = [NSString stringWithFormat:@"-"];
    }
    
    if (attemptedNumber < madeNumber) {
        attemptedNumber = madeNumber;
        _attemptedNum.text = [NSString stringWithFormat:@"%ld",(long)attemptedNumber];
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

@end
