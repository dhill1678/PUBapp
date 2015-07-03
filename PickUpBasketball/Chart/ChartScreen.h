//
//  ChartScreen.h
//  pickupbasketball
//
//  Created by Samrat on 30/06/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
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
    
}
@property (strong, nonatomic) IBOutlet UIScrollView *showChartScrollView;

@end
