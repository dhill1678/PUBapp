/*==============================
 
 - WazzUp -
 
 Chat App Template made by FV iMAGINATION - 2015
 for codecanyon.net
 
 ===============================*/

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "REFrostedViewController.h"

#import "IQDropDownTextField.h"


@interface ProfileVC : UIViewController
<
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UITextFieldDelegate,
UIScrollViewDelegate
>

@property (weak, nonatomic) IBOutlet PFImageView *userImage;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTxt;
//@property (weak, nonatomic) IBOutlet UITextField *lastNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *homeCityTxt;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *homeStateTxt;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *heightTxt;
@property (weak, nonatomic) IBOutlet UITextField *weightNameTxt;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *birthdateTxt;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *positionTxt;
@property (weak, nonatomic) IBOutlet UITextField *schoolTxt;
@property (weak, nonatomic) IBOutlet UITextField *statusTxt;
//@property (strong, nonatomic) IBOutlet UITextField *OLDpasswordTxt;
//@property (strong, nonatomic) IBOutlet UITextField *NEWpasswordTxt;
//@property (strong, nonatomic) IBOutlet UITextField *passwordConfirmationTxt;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet UIView *scrollView;

- (IBAction)showMenu;

@end
