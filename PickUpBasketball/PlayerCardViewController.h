//
//  PlayerCardViewController.h
//  PickUpStats
//
//  Created by DAVID HILL on 7/4/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "REFrostedViewController.h" //necessary for button actions

#import "MBProgressHUD.h"
MBProgressHUD *hud;

@interface PlayerCardViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,ADBannerViewDelegate> {
    
    IBOutlet UIImageView *CardPhoto;
    
    UIImagePickerController *picker;
    UIImage *image;
    
    //int checkImage;
}

- (IBAction)TakePhoto:(id)sender;
- (IBAction)ChoosePhoto:(id)sender;
- (IBAction)returnKeyButton:(id)sender;
//- (IBAction)pickStats:(id)sender;
- (IBAction)createTradingCard:(id)sender;
- (IBAction)resetButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *roundedButton2;
@property (strong, nonatomic) IBOutlet UIButton *roundedButton3;
@property (strong, nonatomic) IBOutlet UIButton *roundedButton4;
//@property (strong, nonatomic) IBOutlet UIButton *roundedButton5;

@property (strong, nonatomic) IBOutlet UITextField *NicknameField;

- (IBAction)showMenu;

- (void)saveImage: (UIImage*)image;
- (UIImage*)loadImage;

@end
