//
//  ChartScreen.m
//  pickupbasketball
//
//  Created by Samrat on 30/06/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
#import "ChartScreen.h"
@interface ChartScreen ()

@end

@implementation ChartScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    yourStats = [[NSMutableArray alloc] init];
    [self loadParse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)loadChartView{
    int arrayCount=[yourStats count];
    NSLog(@"Array count =%d",arrayCount);
    _showChartScrollView.contentSize=CGSizeMake((64*arrayCount), 400);
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10, _showChartScrollView.contentSize.width -20, 380)
                                              withSource:self
                                               withStyle:UUChartLineStyle];
    [chartView showInView:_showChartScrollView];
}

-(NSArray *)makeGameLineChartArray :(NSString *)str{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    for (int j=0;j<[yourStats count]; j++) {
        if ([[yourStats objectAtIndex:j] objectForKey:str]) {
            [arr addObject:[NSString stringWithFormat:@"%@",[[yourStats objectAtIndex:j] valueForKey:str]]];
        }else{
            [arr addObject:@"0"];
        }
    }
    NSArray *array = [[NSArray arrayWithArray:arr] copy];
    return array;
}
-(void)loadParse{
     if ([PFUser currentUser] != nil) {
         [self AddLoadingView];
         PFQuery *query = [PFQuery queryWithClassName:PF_GAME_CLASS_NAME];
         [query whereKey:PF_GAME_USER equalTo:[PFUser currentUser]];
         [query orderByDescending:@"createdAt"];
         [query setLimit:1000];
         [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
          {
              if (error == nil) {
                  [yourStats removeAllObjects];
                  [yourStats addObjectsFromArray:objects];
                  xLableArray=[[NSMutableArray alloc] init];
                  yValueArray =[[NSMutableArray alloc] init];
                  NSMutableArray *arrayOfTitel=[[NSMutableArray alloc] initWithObjects:@"yourscore",@"opponentscore",@"twoptmade",@"twoptattempted",@"threeptmade",@"threeptattempted",@"freethrowmade",@"freethrowattempted",@"assists",@"totalrebounds",@"defrebounds",@"offrebounds",@"steals",@"blocks",@"turnovers",@"scoringstyle",nil];
                  for (int i=0; i<[arrayOfTitel count]; i++) {
                      [yValueArray addObject: [self makeGameLineChartArray:[arrayOfTitel objectAtIndex:i]]];
                  }
                  for (int j=0;j<[yourStats count]; j++) {
                      NSString *dateStr=[self dateToStringConvertion:[[yourStats objectAtIndex:j] valueForKey:@"createdAt"]];
                      [xLableArray addObject:dateStr];
                  }
                  [self loadChartView];
                  [self RemoveLoadingView];
              }else {
                  [self RemoveLoadingView];
                  [ProgressHUD showError:@"No Stats To Show"];
              }
          }];
     }
}


-(NSString *)dateToStringConvertion :(NSDate *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateString]];
    NSLog(@"%@", stringDate);
    
    return stringDate;
}
#pragma mark - @required
//Array abscissa title
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    NSArray *array1 = [[NSArray arrayWithArray:xLableArray] copy];
    return array1;
}

//Numerical jagged array
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    NSArray *array = [[NSArray arrayWithArray:yValueArray] copy];
    NSLog(@"Array =%@ ",@[array]);
    return @[array];
}

#pragma mark - @optional
//An array of colors
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UURed,UUBrown,UUGreen,UUYellow,UUBlack,UUBlue,UUDarkYellow,UUGrey,UUFreshGreen,UUStarYellow,UUDeepGrey,UUButtonGrey,UUWeiboColor,UUPinkGrey,UULightBlue,UUBrown];
}
//Display Value range
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
//    return CGRangeMake(60, 0);
    return CGRangeZero;
}

#pragma mark - Exclusive features a line graph
//Label value region
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    return CGRangeZero;
}

//Analyzing display horizontal lines
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//Analyzing display maximum and minimum
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return NO;
}
//

#pragma mark-
#pragma mark Loading
-(void)AddLoadingView
{
    loadingBackground = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 70)];
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, 0, 10, 10);
    loadingText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 62, 20)];
    loadingText.font = [UIFont boldSystemFontOfSize:13];
    loadingText.center = CGPointMake(self.view.center.x + 20, self.view.center.y + 0);
    loadingBackground.layer.cornerRadius=10;
    loadingBackground.backgroundColor = [UIColor blackColor];
    loadingBackground.center = self.view.center;
    [indicator startAnimating];
    indicator.center = CGPointMake(self.view.center.x - 40, self.view.center.y + 0);
    loadingText.text = @"Loading...";
    loadingText.textColor = [UIColor whiteColor];
    loadingText.backgroundColor = [UIColor clearColor];
    [self.view addSubview:loadingBackground];
    [self.view addSubview:indicator];
    [self.view addSubview:loadingText];
    self.view.userInteractionEnabled=NO;
}

-(void)RemoveLoadingView
{
    [loadingBackground removeFromSuperview];
    [indicator removeFromSuperview];
    [loadingText removeFromSuperview];
    self.view.userInteractionEnabled=YES;
}
@end
