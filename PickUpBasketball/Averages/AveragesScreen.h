//
//  AveragesScreen.h
//  pickupbasketball
//
//  Created by Samrat on 14/07/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
#import "AverageCell.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface AveragesScreen : UIViewController
{
    NSMutableArray *yourStats;
    NSMutableArray *headData;
    NSMutableArray *avarageArray;
    UIView *loadingBackground;
    UILabel *loadingText;
    UIActivityIndicatorView *indicator;
    UIColor *SelectedCellBGColor;
    UIColor *NotSelectedCellBGColor;
    NSMutableArray *filteredTitelArray;
    NSMutableArray *filteredKeyArray;
    NSMutableArray *cellSelectedArray;
    NSMutableArray *teamSizeArray;
    NSMutableArray *seasonIdArray;
    BOOL isShown;
    NSString *teamValue;
    NSString *pickerViewSelection;
    NSMutableArray *gameTypeArray;
}
@property (strong, nonatomic) IBOutlet UITableView *averageTableView;
@property (strong, nonatomic) IBOutlet UITableView *filterTableView;
@property (strong, nonatomic) IBOutlet UIView *pickerBGView;
@property (strong, nonatomic) IBOutlet UIPickerView *teamSizePickerView;
- (IBAction)btnDonePickerViewAction:(id)sender;
- (IBAction)btnFilteredAction:(id)sender;
@end
