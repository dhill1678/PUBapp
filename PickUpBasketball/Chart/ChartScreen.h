//
//  AnalyticsScreen.h
//  pickupbasketball
//
//  Created by Samrat on 15/07/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface ChartScreen : UIViewController
{
    NSMutableArray *yourStats;
    NSMutableArray *headData;
    NSMutableArray *leftTableData;
    NSMutableArray *rightTableData;
    UIView *loadingBackground;
    UILabel *loadingText;
    UIActivityIndicatorView *indicator;
    NSMutableArray *filteredTitelArray;
    NSMutableArray *filteredKeyArray;
    NSMutableArray *cellSelectedArray;
    NSMutableArray *teamSizeArray;
    UIColor *SelectedCellBGColor;
    UIColor *NotSelectedCellBGColor;
    BOOL isShown;
    NSString *teamValue;

}
@property (strong, nonatomic) IBOutlet UITableView *chartTableView;
@property (strong, nonatomic) IBOutlet UITableView *filterTableView;
- (IBAction)btnFilteredAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblFilteredOutlet;
@property (strong, nonatomic) IBOutlet UIView *pickerBGView;
@property (strong, nonatomic) IBOutlet UIPickerView *teamSizePickerView;


@end
