//
//  ChartScreen.h
//  pickupbasketball
//
//  Created by Samrat on 30/06/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
#import "Common.h"
#import "Configs.h"
#import "ProgressHUD.h"
#import "UUChart.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface ChartScreen : UIViewController <UUChartDataSource>
{
    //for loading
    NSMutableArray *yourStats;
    UIView *loadingBackground;
    UILabel *loadingText;
    UIActivityIndicatorView *indicator;
    //for chart
    UUChart *chartView;
    NSMutableArray *xLableArray;
    NSMutableArray *yValueArray;
    NSMutableArray *arrayOfTitel;
    BOOL isShown;
    
    UIColor *SelectedCellBGColor;
    UIColor *NotSelectedCellBGColor;
    NSMutableArray *cellSelectedArray;
}
@property (strong, nonatomic) IBOutlet UIScrollView *showChartScrollView;
@property (strong, nonatomic) IBOutlet UITableView *chartListTableView;
@property (strong, nonatomic) IBOutlet UILabel *lblLineChart;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (strong, nonatomic) IBOutlet UIView *yLabelView;
- (IBAction)btnLineChartAction:(id)sender;


@end
