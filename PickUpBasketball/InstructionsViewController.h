//
//  InstructionsViewController.h
//  PickUpBasketball
//
//  Created by DAVID HILL on 4/14/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface InstructionsViewController : UIViewController <ADBannerViewDelegate> {
    NSInteger madeNumber;
    NSInteger attemptedNumber;
    
    BOOL madeLit;
    BOOL attemptedLit;
    
    NSInteger directionControl;
}

- (IBAction)plus:(id)sender;
- (IBAction)minus:(id)sender;
- (IBAction)madeAction:(id)sender;
- (IBAction)attemptedAction:(id)sender;
- (IBAction)madeClosed:(id)sender;
- (IBAction)attemptedClosed:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *MadeAttemptedView;
@property (strong, nonatomic) IBOutlet UITextField *madeNum;
@property (strong, nonatomic) IBOutlet UITextField *attemptedNum;

@property (strong, nonatomic) IBOutlet UILabel *directionLabel;
@property (strong, nonatomic) IBOutlet UILabel *subLabel;

@end
