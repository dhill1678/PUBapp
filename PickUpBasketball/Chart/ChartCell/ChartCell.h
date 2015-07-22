//
//  ChartCell.h
//  pickupbasketball
//
//  Created by Samrat on 16/07/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
#import "UUChart.h"
#import <UIKit/UIKit.h>

@interface ChartCell : UITableViewCell<UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
//    NSMutableArray *headerArray;
    NSMutableArray *xTableDataArray;
    NSMutableArray *yTableDataArray;
}
//- (void)configUI:(NSIndexPath *)indexPath;
- (void)configUI:(NSIndexPath *)indexPath :(NSMutableArray *)xTableArray :(NSMutableArray *)yTableArray;
@property (strong, nonatomic) IBOutlet UIScrollView *chatScrollView;
@property (strong, nonatomic) IBOutlet UIView *sidesView;

@end
