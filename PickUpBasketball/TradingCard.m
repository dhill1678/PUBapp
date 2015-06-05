//
//  TradingCard.m
//  PickUpStats
//
//  Created by DAVID HILL on 7/10/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import "TradingCard.h"
#import "Configs.h"
#import <Parse/Parse.h>

@interface TradingCard ()

@end

@implementation TradingCard

@synthesize NicknameLabel, BallerStatusLabel;
@synthesize Emblem1, Emblem2, Emblem3;

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
    
    // Get the stored data before the view loads
    //NSUserDefaults *card = [NSUserDefaults standardUserDefaults];
    //NicknameLabel.text = [card objectForKey:@"nickname"];
    NicknameLabel.text = _Nickname;
    
    // load card image from previous screen
    image = [self loadImage];
    if (image != nil) {
        // images must be rotated - orientation switched upon save for some unknown reason
        UIImage *newImage = [UIImage imageWithCGImage:[image CGImage]
                                                scale:[image scale]
                                          orientation:UIImageOrientationRight];
        
        [CardPhoto setImage:newImage];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    // Necessary for Tap Gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHideNavbar:)];
    [self.view addGestureRecognizer:tapGesture];
    // hide the Navigation Bar
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

// Tap Gesture Method
-(void) showHideNavbar:(id) sender
{
    // write code to show/hide nav bar here
    // check if the Navigation Bar is shown
    if (self.navigationController.navigationBar.hidden == NO)
    {
        // hide the Navigation Bar
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    // if Navigation Bar is already hidden
    else if (self.navigationController.navigationBar.hidden == YES)
    {
        // Show the Navigation Bar
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (UIImage*)loadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:
                      @"cardPhoto.png" ];
    UIImage *cardImage = [UIImage imageWithContentsOfFile:path];
    return cardImage;
}

- (IBAction)ShareButton:(id)sender {
    
    // Take screenshot of trading card
    UIGraphicsBeginImageContext(CardPhoto.frame.size);
	[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	//UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil); // save to photo album - useful for debugging
    
    // Load Player name from profile
    // Get the stored data before the view loads
    //NSUserDefaults *profile = [NSUserDefaults standardUserDefaults];
    PFUser *user = [PFUser currentUser];
    
    // this code controls sharing menu
    NSArray *ActItems;
    ActItems = @[[NSString stringWithFormat:@"Check out %@'s Basketball Card. Powered by the Pickup Stats App", user[PF_USER_FULLNAME]], viewImage];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:ActItems applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:NULL];
}

@end
