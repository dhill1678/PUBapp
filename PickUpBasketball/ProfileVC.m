/*==============================
 
 - WazzUp -
 
 Chat App Template made by FV iMAGINATION - 2015
 for codecanyon.net
 
 ===============================*/


#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "ProgressHUD.h"

#import "Configs.h"
#import "Camera.h"
#import "pushnotification.h"
#import "Utilities.h"

#import "ProfileVC.h"
#import "WelcomeVC.h"
#import "NavigationController.h"

#import "IQDropDownTextField.h"


@interface ProfileVC()

@end


@implementation ProfileVC

@synthesize birthdateTxt, positionTxt, homeStateTxt, heightTxt;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self)
	{
	}
	return self;
}

-(void)viewWillAppear:(BOOL)animated {
    //[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}


- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.title = @"Player Profile";
    
    // nel ViewDidLoad, inizializza la ScrollView
    //_wallpScrollView.delegate = self;
    //_mainView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //_scroller.delegate = self;
    //_scrollView.delegate = self;
    [_scroller setScrollEnabled:YES];
    _scroller.contentSize = CGSizeMake(self.view.frame.size.width, 515);
    //CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 814);
    //_scrollView.frame = frame;
    
    // necessary for textfield return methods to work
    _firstNameTxt.delegate = self;
    _homeCityTxt.delegate = self;
    _weightNameTxt.delegate = self;
    _schoolTxt.delegate = self;
    _statusTxt.delegate = self;
    //_OLDpasswordTxt.delegate = self;
    //_NEWpasswordTxt.delegate = self;
    //_passwordConfirmationTxt.delegate = self;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];

    _userImage.layer.cornerRadius = _userImage.frame.size.width / 2;
    
    positionTxt.itemList = @[@"PG",@"SG",@"SF",@"PF",@"C"];
    birthdateTxt.dropDownMode = IQDropDownModeDatePicker;
    homeStateTxt.itemList = @[@"AL", @"AK", @"AZ", @"AR", @"CA", @"CO", @"CT", @"DE", @"FL",
     @"GA", @"HI", @"ID", @"IL", @"IN", @"IA", @"KS", @"KY", @"LA", @"ME", @"MD", @"MA", @"MI", @"MN",
     @"MS", @"MO", @"MT", @"NE", @"NV", @"NH", @"NJ", @"NM", @"NY", @"NC", @"ND", @"OH", @"OK", @"OR",
     @"PA", @"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VT", @"VA", @"WA", @"WV", @"WI", @"WY"];
    heightTxt.itemList = @[@"3' 00\"",@"3' 01\"",@"3' 02\"",@"3' 03\"",@"3' 04\"",@"3' 05\"",@"3' 06\"",@"3' 07\"",@"3' 08\"",@"3' 09\"",@"3' 10\"",@"3' 11\"",@"4' 00\"",@"4' 01\"",@"4' 02\"",@"4' 03\"",@"4' 04\"",@"4' 05\"",@"4' 06\"",@"4' 07\"",@"4' 08\"",@"4' 09\"",@"4' 10\"",@"4' 11\"",@"5' 00\"",@"5' 01\"",@"5' 02\"",@"5' 03\"",@"5' 04\"",@"5' 05\"",@"5' 06\"",@"5' 07\"",@"5' 08\"",@"5' 09\"",@"5' 10\"",@"5' 11\"",@"6' 00\"",@"6' 01\"",@"6' 02\"",@"6' 03\"",@"6' 04\"",@"6' 05\"",@"6' 06\"",@"6' 07\"",@"6' 08\"",@"6' 09\"",@"6' 10\"",@"6' 11\"",@"7' 00\"",@"7' 01\"",@"7' 02\"",@"7' 03\"",@"7' 04\"",@"7' 05\"",@"7' 06\"",@"7' 07\"",@"7' 08\"",@"7' 09\"",@"7' 10\"",@"7' 11\""];
    
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

    if ([PFUser currentUser] != nil) {
    [self loadUser];
        
	} else {
        WelcomeVC *welcomeVC =[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeVC"];
        [self.navigationController pushViewController: welcomeVC animated:true];
    }
}


- (void)dismissKeyboard {
	[self.view endEditing: true];
}




#pragma mark - PARSE BACKEND METHODS =================

- (void)loadUser {
    
	PFUser *user = [PFUser currentUser];

	[_userImage setFile:user[PF_USER_PICTURE]];
	[_userImage loadInBackground];

	_firstNameTxt.text = user[PF_USER_FULLNAME];
    _homeCityTxt.text = user[PF_USER_HOMECITY];
    homeStateTxt.text = user[PF_USER_HOMESTATE];
    heightTxt.text = user[PF_USER_HEIGHT];
    _weightNameTxt.text = user[PF_USER_WEIGHT];
    birthdateTxt.text = user[PF_USER_BIRTHDAY];
    positionTxt.text = user[PF_USER_POSITION];
    _schoolTxt.text = user[PF_USER_SCHOOL];
    _statusTxt.text = user[PF_USER_STATUS];
}


- (void)saveUser {
    
    PFUser *user = [PFUser currentUser];
            
    if ([_firstNameTxt.text length] != 0) {
        
        
        //PFUser *user = [PFUser currentUser];
        user[PF_USER_FULLNAME] = _firstNameTxt.text;
        user[PF_USER_HOMECITY] = _homeCityTxt.text;
        user[PF_USER_HOMESTATE] = homeStateTxt.text;
        user[PF_USER_HEIGHT] = heightTxt.text;
        user[PF_USER_WEIGHT] = _weightNameTxt.text;
        user[PF_USER_BIRTHDAY] = birthdateTxt.text;
        user[PF_USER_POSITION] = positionTxt.text;
        user[PF_USER_SCHOOL] = _schoolTxt.text;
        user[PF_USER_STATUS] = _statusTxt.text;
        user[PF_USER_FULLNAME_LOWER] = [_firstNameTxt.text lowercaseString];
        
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error == nil)
            {
                [ProgressHUD showSuccess:@"Saved."];
            }
            else [ProgressHUD showError:@"Network error."];
        }];
        
    } else {
        [ProgressHUD showError:@"Please Add Your Name"];
    }
}

/*
- (void)cleanup {
	_userImage.image = [UIImage imageNamed:@"profile_blank"];
    _firstNameTxt.text = nil;
    _statusTxt.text = nil;
}

#pragma mark - LOG OUT =============================

- (IBAction)logoutButt:(id)sender {
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
        otherButtonTitles:@"Logout", nil];
	[action showFromTabBar:[[self tabBarController] tabBar]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
	if (buttonIndex != actionSheet.cancelButtonIndex) {
		[PFUser logOut];
		ParsePushUserResign();
		PostNotification(NOTIFICATION_USER_LOGGED_OUT);
		[self cleanup];
        
        // Open the Login VC again
        WelcomeVC *welcomeVC =[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeVC"];
        [self.navigationController pushViewController: welcomeVC animated:true];
    }
    
}
*/

#pragma mark - PHOTO BUTTON =============================
- (IBAction)photoButt:(id)sender {
	ShouldStartPhotoLibrary(self, true);
}

#pragma mark - SAVE PROFILE INFO BUTTON =============================
- (IBAction)saveButt:(id)sender {
	[self dismissKeyboard];
	[self saveUser];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
	UIImage *image = info[UIImagePickerControllerEditedImage];
	
    if (image.size.width > 140) image = ResizeImage(image, 140, 140);

    PFFile *filePicture = [PFFile fileWithName:@"picture.jpg" data:UIImageJPEGRepresentation(image, 0.6)];
	[filePicture saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil) [ProgressHUD showError:@"Network error."];
	}];

    _userImage.image = image;

    
	if (image.size.width > 30) image = ResizeImage(image, 30, 30);

    PFFile *fileThumbnail = [PFFile fileWithName:@"thumbnail.jpg" data:UIImageJPEGRepresentation(image, 0.6)];
	[fileThumbnail saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil) [ProgressHUD showError:@"Network error."];
	}];

    
    PFUser *user = [PFUser currentUser];
	user[PF_USER_PICTURE] = filePicture;
	user[PF_USER_THUMBNAIL] = fileThumbnail;
	[user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil) [ProgressHUD showError:@"Network error."];
	}];

    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TEXTFIELD DELEGATE - ON RETURN BUTTON ===============================
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _firstNameTxt) {
        [self dismissKeyboard];
    }
    if (textField == _homeCityTxt) {
        [self dismissKeyboard];
    }
    if (textField == _weightNameTxt) {
        [self dismissKeyboard];
    }
    if (textField == _schoolTxt) {
        [self dismissKeyboard];
    }
    if (textField == _statusTxt) {
        [self dismissKeyboard];
    }
    
    return true;
}
 
- (IBAction)resetPassword:(id)sender {
    PFUser *user = [PFUser currentUser];
    if (![PFUser requestPasswordResetForEmail:user[PF_USER_EMAIL]]) {
        [ProgressHUD showError:@"No Account exists for that Email Address"];
    } else {
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Email successfully sent to %@", user[PF_USER_EMAIL]]];
    }
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


@end
