//
//  AveragesScreen.h
//  pickupbasketball
//
//  Created by Samrat on 14/07/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
#import <Parse/Parse.h>
#import "XCMultiSortTableView.h"
#import <UIKit/UIKit.h>

@interface AveragesScreen : UIViewController<XCMultiTableViewDataSource>
{
    NSMutableArray *yourStats;
    NSMutableArray *headData;
    NSMutableArray *leftTableData;
    NSMutableArray *rightTableData;
    XCMultiTableView *tableView;
    UIView *loadingBackground;
    UILabel *loadingText;
    UIActivityIndicatorView *indicator;
}

@end
