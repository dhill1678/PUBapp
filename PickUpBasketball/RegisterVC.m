/*==============================
 
 - WazzUp -
 
 Chat App Template made by FV iMAGINATION - 2015
 for codecanyon.net
 
 ===============================*/



#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "Configs.h"
#import "pushnotification.h"

#import "ContactsVC.h"
#import "RegisterVC.h"

@interface RegisterVC()

@end


@implementation RegisterVC


-(void)viewWillAppear:(BOOL)animated {
    //[self.navigationController.navigationBar setTintColor:[UIColor blueColor]];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.title = @"New Account";
    
    // necessary for textfield return methods to work
    _nameTxt.delegate = self;
    _phoneTxt.delegate = self;
    _emailTxt.delegate = self;
    _passwordTxt.delegate = self;
    _confirmPasswordTxt.delegate = self;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
	[_nameTxt becomeFirstResponder];
}

- (void)dismissKeyboard {
	[self.view endEditing: true];
}




#pragma mark - USER ACTIONS ======================================

- (IBAction)registerButt:(id)sender {
    
	NSString *name = _nameTxt.text;
	NSString *password = _passwordTxt.text;
    NSString *passwordConfirmation = _confirmPasswordTxt.text;
    NSString *email	= [_emailTxt.text lowercaseString];
    NSString *phoneNr	= _phoneTxt.text;

    if ([name length] == 0) {
        [ProgressHUD showError:@"Please type your Name"]; return;
    }
    if ([phoneNr length] == 0) {
        [ProgressHUD showError:@"Please type your Phone Number"]; return;
    }
    if ([email length] == 0) {
        [ProgressHUD showError:@"Please type your Email Address"]; return;
    }
	if ([password length] == 0)	{
        [ProgressHUD showError:@"Please type a Password"]; return;
    }
    if (![password isEqualToString:passwordConfirmation])	{
        [ProgressHUD showError:@"Password does not match Confirmation"]; return;
    }
    
    [ProgressHUD show:@"Registering..." Interaction: false];
    
    
    // Save the New Account (user) intp Parse database
	PFUser *user = [PFUser user];
	user.username = email;
	user.password = password;
    user.email = email;
    
    user[PF_USER_EMAILCOPY] = email;
    user[PF_USER_PHONE] = phoneNr;
    user[PF_USER_FULLNAME] = name;
    user[PF_USER_STATUS] = @"Tell me what's on your mind!!!"; // changed
	user[PF_USER_FULLNAME_LOWER] = [name lowercaseString];
	
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (error == nil) {
			ParsePushUserAssign();
			[ProgressHUD showSuccess:@"Account registered!"];
            
			//[self dismissViewControllerAnimated:true completion:nil];
            [self performSegueWithIdentifier: @"fromSignup" sender: self];
            
		} else [ProgressHUD showError:error.userInfo[@"error"]];
	}];
}



#pragma mark - UITextField delegate =======================
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	if (textField == _nameTxt) {
		[_phoneTxt becomeFirstResponder];
	}
    
    if (textField == _phoneTxt) {
        [_emailTxt becomeFirstResponder];
    }
    
    if (textField == _emailTxt) {
        [_passwordTxt becomeFirstResponder];
    }

    if (textField == _passwordTxt) {
		[_confirmPasswordTxt becomeFirstResponder];
	}
    
	if (textField == _confirmPasswordTxt) {
		[self registerButt:nil];
	}
    
	return true;
}


@end
