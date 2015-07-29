//
//  ChartCell.m
//  pickupbasketball
//
//  Created by Samrat on 16/07/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
#import "AppDelegate.h"
#import "ChartCell.h"

@implementation ChartCell
AppDelegate *appDelegate;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)configUI:(NSIndexPath *)indexPath :(NSMutableArray *)xArray :(NSMutableArray *)yArray{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    path = indexPath;
    xTableDataArray=xArray;
    yTableDataArray=yArray;
    if([xTableDataArray count] !=0 && [yTableDataArray count] !=0){
        NSLog(@"xTableDataArray= %@",xTableDataArray);
        NSLog(@"yTableDataArray= %@",yTableDataArray);
        NSInteger arrayCount=[yTableDataArray count];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        if(50*arrayCount > screenWidth-30){
            self.chatScrollView.contentSize=CGSizeMake((50*arrayCount)-30, self.chatScrollView.frame.size.height);
        }else{
            self.chatScrollView.contentSize=CGSizeMake(screenWidth-30, self.chatScrollView.frame.size.height);
        }
        chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(0, 0, self.chatScrollView.contentSize.width, self.chatScrollView.contentSize.height)
                                                  withSource:self
                                                   withStyle:UUChartLineStyle];
//        chartView.backgroundColor=[UIColor redColor];
        [chartView showInView:self.chatScrollView];
        appDelegate=[UIApplication sharedApplication ].delegate;
        NSLog(@"appDelegate.yChartLableArray =%@",appDelegate.yChartLableArray);
        NSLog(@"appDelegate.yChartLableFrameArray =%@",appDelegate.yChartLableFrameArray);
        UIView *sideView=[[UIView alloc] initWithFrame:CGRectMake(0, chartView.frame.origin.y, 20, chartView.frame.size.height)];
        sideView.backgroundColor=[UIColor whiteColor];
        for (int i=0; i<[appDelegate.yChartLableArray count]; i++) {
            CGRect someRect = [[appDelegate.yChartLableFrameArray objectAtIndex:i] CGRectValue];
            UILabel *lblOne=[[UILabel alloc] initWithFrame:CGRectMake(someRect.origin.x, someRect.origin.y, someRect.size.width, someRect.size.height)];
            lblOne.text=[appDelegate.yChartLableArray objectAtIndex:i];
            [lblOne setTextAlignment:NSTextAlignmentRight];
            [lblOne setFont:[UIFont boldSystemFontOfSize:9.0f]];
            [lblOne setTextColor: UUDeepGrey];
            [sideView addSubview:lblOne];
        }
        [self.sidesView addSubview:sideView];
    }
}

#pragma mark - @required
#pragma mark -Array abscissa title
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    
    NSArray *array = [[NSArray arrayWithArray:xTableDataArray ] copy];
     NSArray *arr=[[NSArray alloc] init];
     for (NSArray * aroy in array) {
          arr=aroy;
     }
    if([arr count]!=0){
        return arr;
    }else{
        return 0;
    }
}
#pragma mark -Numerical jagged array
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    NSArray *array = [[NSArray arrayWithArray:yTableDataArray ] copy];
    NSLog(@"path.row=%ld",(long)path.section);
    NSArray *arr=[[NSArray alloc] init];
    for (NSArray * aroy in array) {
        arr=aroy;
         NSLog(@"aroy value= %@",array);
    }
    if([arr count]!=0){
        return @[@[[arr objectAtIndex:path.section]]];
    }else{
        return 0;
    }
}

#pragma mark - @optional
#pragma mark -An array of colors
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUBlue];
}
#pragma mark -Display Value range
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{

    return CGRangeZero;
}

#pragma mark - Exclusive features a line graph
#pragma mark -Label value region
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    return CGRangeZero;
}

#pragma mark -Analyzing display horizontal lines
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

#pragma mark -Analyzing display maximum and minimum
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return YES;
}
@end
