//
//  PlayerCardViewController.m
//  PickUpStats
//
//  Created by DAVID HILL on 7/4/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import "PlayerCardViewController.h"
#import "ProgressHUD.h"

#import <Parse/Parse.h>
//#import <ParseUI/ParseUI.h>
#import "Configs.h"

#import "TradingCard.h"


@interface PlayerCardViewController ()

@end

@implementation PlayerCardViewController

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
    
    CALayer *btnLayer2 = [_roundedButton2 layer];
    [btnLayer2 setMasksToBounds:YES];
    [btnLayer2 setCornerRadius:10.0f];
    CALayer *btnLayer3 = [_roundedButton3 layer];
    [btnLayer3 setMasksToBounds:YES];
    [btnLayer3 setCornerRadius:10.0f];
    CALayer *btnLayer4 = [_roundedButton4 layer];
    [btnLayer4 setMasksToBounds:YES];
    [btnLayer4 setCornerRadius:10.0f];
    //CALayer *btnLayer5 = [_roundedButton5 layer];
    //[btnLayer5 setMasksToBounds:YES];
    //[btnLayer5 setCornerRadius:10.0f];
    
    // Get the stored data before the view loads
    //NSUserDefaults *card = [NSUserDefaults standardUserDefaults];
    //_NicknameField.text = [card objectForKey:@"nickname"];
    PFUser *user = [PFUser currentUser];
    _NicknameField.text = user[PF_USER_NICKNAME];
    
    CardPhoto.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    CardPhoto.image = [UIImage imageNamed:@"ballercard.png"];
    CardPhoto.layer.masksToBounds = YES;
    CardPhoto.layer.cornerRadius = 75.0;
    CardPhoto.layer.borderColor = [UIColor colorWithRed:115/255.0f green:153/255.0f blue:198/255.0f alpha:1.0f].CGColor;
    CardPhoto.layer.borderWidth = 3.0f;
    CardPhoto.layer.rasterizationScale = [UIScreen mainScreen].scale;
    CardPhoto.layer.shouldRasterize = YES;
    CardPhoto.clipsToBounds = YES;
    
    //checkImage = 0;
    
    image = [self loadImage];
    
    if (image != nil) {
        //checkImage = 1;
        
        // images must be rotated - orientation switched upon save for some unknown reason
        UIImage *newImage = [UIImage imageWithCGImage:[image CGImage]
                                                scale:[image scale]
                                          orientation:UIImageOrientationRight];
        
        [CardPhoto setImage:newImage];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"createCard"])
    {
        // Get reference to the destination view controller
        TradingCard *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.Nickname = _NicknameField.text;
        //[vc setMyObjectHere:_practiceLabel.text];
    }
}

- (IBAction)TakePhoto:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
    
    //NSUserDefaults *card = [NSUserDefaults standardUserDefaults];
    //[card setObject:_NicknameField.text forKey:@"nickname"];
    //[card synchronize];
    [self saveName];
}

- (IBAction)ChoosePhoto:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    [self presentViewController:picker animated:YES completion:NULL];
    
    //NSUserDefaults *card = [NSUserDefaults standardUserDefaults];
    //[card setObject:_NicknameField.text forKey:@"nickname"];
    //[card synchronize];
    [self saveName];
}

- (IBAction)returnKeyButton:(id)sender {
    //NSUserDefaults *card = [NSUserDefaults standardUserDefaults];
    //[card setObject:_NicknameField.text forKey:@"nickname"];
    //[card synchronize];
    [self saveName];
    
    [sender resignFirstResponder];
}

- (IBAction)pickStats:(id)sender {
    //NSUserDefaults *card = [NSUserDefaults standardUserDefaults];
    //[card setObject:_NicknameField.text forKey:@"nickname"];
    //[card synchronize];
    [self saveName];
}

- (IBAction)createTradingCard:(id)sender {
    if (_NicknameField.text.length > 0 && image != nil) {
        [ProgressHUD showSuccess:@"Success! Tap Card to Leave Full Screen"];
        
        //NSUserDefaults *card = [NSUserDefaults standardUserDefaults];
        //[card setObject:_NicknameField.text forKey:@"nickname"];
        //[card synchronize];
        [self saveName];
        
        [self performSegueWithIdentifier:@"createCard" sender:self];
    } else if (_NicknameField.text.length == 0) {
        [ProgressHUD showError:@"Please Add A Nickname"]; return;
    } else if (image == nil) {
        [ProgressHUD showError:@"Add A Photo"]; return;
    } else {
        [ProgressHUD showError:@"Error Creating Card"]; return;
    }
}

- (IBAction)resetButton:(id)sender {
    [self deleteImage];
    
    image = nil;
    
    CardPhoto.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    CardPhoto.image = [UIImage imageNamed:@"ballercard.png"];
    CardPhoto.layer.masksToBounds = YES;
    CardPhoto.layer.cornerRadius = 75.0;
    CardPhoto.layer.borderColor = [UIColor colorWithRed:115/255.0f green:153/255.0f blue:198/255.0f alpha:1.0f].CGColor;
    CardPhoto.layer.borderWidth = 3.0f;
    CardPhoto.layer.rasterizationScale = [UIScreen mainScreen].scale;
    CardPhoto.layer.shouldRasterize = YES;
    CardPhoto.clipsToBounds = YES;
    
    _NicknameField.text = @"";
    NSUserDefaults *card = [NSUserDefaults standardUserDefaults];
    [card setObject:_NicknameField.text forKey:@"nickname"];
    [card synchronize];
}

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [CardPhoto setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
    //[self presentViewController:imagePickerController animated:YES completion:^{....}]; //found online but never tried
    
    //I do this in the didFinishPickingImage:(UIImage *)img method
    //NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
    
    //save to the default 100Apple(Camera Roll) folder.
    //[imageData writeToFile:@"/private/var/mobile/Media/DCIM/100APPLE/PlayerCardPhoto.jpg" atomically:NO];
    
    [self saveImage:image];
}


- (void)saveImage: (UIImage*)cardImage
{
    if (cardImage != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:
                          @"cardPhoto.png" ];
        NSData* data = UIImagePNGRepresentation(cardImage);
        [data writeToFile:path atomically:YES];
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

- (UIImage*)deleteImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"cardPhoto.png"];
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])		//Does file exist?
    {
        if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error])	//Delete it
        {
            NSLog(@"Delete file error: %@", error);
        }
    }
    return 0;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.NicknameField resignFirstResponder];
}

-(void)saveName {
    PFUser *user = [PFUser currentUser];
    
    user[PF_USER_NICKNAME] = _NicknameField.text;
        
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error == nil)
        {
            //[ProgressHUD showSuccess:@"Saved."];
        }
        else [ProgressHUD showError:@"Autosave Failed"];
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
@end
