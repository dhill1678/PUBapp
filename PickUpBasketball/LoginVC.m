/*==============================
 
 - WazzUp -
 
 Chat App Template made by FV iMAGINATION - 2015
 for codecanyon.net
 
 ===============================*/


#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "Configs.h"
#import "pushnotification.h"

#import "LoginVC.h"


@interface LoginVC()
@end



@implementation LoginVC

-(void)viewWillAppear:(BOOL)animated {
    //[self.navigationController.navigationBar setTintColor:[UIColor blueColor]];
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor blueColor]];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.title = @"Login";
    
    // necessary for textfield return methods to work
    _emailTxt.delegate = self;
    _passwordTxt.delegate = self;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    // Set email Txt field as first responder
	[_emailTxt becomeFirstResponder];
}


- (void)dismissKeyboard{
	[self.view endEditing:true];
}




#pragma mark - USER ACTIONS ===========================

- (IBAction)loginButt:(id)sender {
    
	NSString *email = [_emailTxt.text lowercaseString];
	NSString *password = _passwordTxt.text;

    if ([email length] == 0)	{
        [ProgressHUD showError:@"You forgot your Email Address"]; return;
    }
	if ([password length] == 0)	{
        [ProgressHUD showError:@"Password Please"]; return;
    }
    [ProgressHUD show:@"Logging in..." Interaction:NO];
	
    
    [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error) {
		if (user != nil) {
			ParsePushUserAssign();
			[ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
			//[self dismissViewControllerAnimated:YES completion:nil];
            [self performSegueWithIdentifier: @"fromLogin" sender: self];
		
        } else [ProgressHUD showError:error.userInfo[@"error"]];
	}];
}


- (IBAction)resetPassword:(id)sender {
    
    NSString *email = [_emailTxt.text lowercaseString];
    
    if ([email length] == 0)	{
        [ProgressHUD showError:@"Enter your Email Address"]; return;
    }
    
    if (![PFUser requestPasswordResetForEmail:email]) {
        [ProgressHUD showError:@"No Account exists for that Email Address"];
    } else {
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Email successfully sent to %@", _emailTxt.text]];
    }
}




#pragma mark - TEXTFIELD DELEGATE - ON RETURN BUTTON ===============================
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"return");
    
	if (textField == _emailTxt) {
		[_passwordTxt becomeFirstResponder];
	}
    
	if (textField == _passwordTxt) {
		[self loginButt:nil];
	}
    
	return true;
}

@end
