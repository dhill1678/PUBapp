
/*==============================
 
 - WazzUp -
 
 Chat App Template made by FV iMAGINATION - 2015
 for codecanyon.net
 
 ===============================*/


#import "ChatGroup.h"
//#import "REFrostedViewController.h"

NSString *groupId;


@interface ChatsVC : UIViewController
<
UITableViewDataSource,
UITableViewDelegate,
ChatGroupDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *messagesTable;
@property (weak, nonatomic) IBOutlet UIView *emptyView;

- (void)loadMessages;
- (IBAction)menuButton:(id)sender;

@end
