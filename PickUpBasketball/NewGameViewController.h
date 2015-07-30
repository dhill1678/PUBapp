//
//  ViewController.h
//  HTHorizontalSelectionList Example
//
//  Created by Erik Ackermann on 9/14/14.
//  Copyright (c) 2014 Hightower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "REFrostedViewController.h" //necessary for button actions

@interface NewGameViewController : UIViewController <ADBannerViewDelegate> {
    
    NSInteger Select;
    
    BOOL helpON;
}

@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UISwitch *helpSwitch;
- (IBAction)switchAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *gameDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *gameLabel;

- (IBAction)showMenu;
- (IBAction)startGame:(id)sender;
- (IBAction)instructions:(id)sender;

@end
