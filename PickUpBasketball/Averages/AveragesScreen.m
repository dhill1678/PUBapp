//
//  AveragesScreen.m
//  pickupbasketball
//
//  Created by Samrat on 14/07/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
#import "Configs.h"
#import "ProgressHUD.h"
#import "AveragesScreen.h"

@interface AveragesScreen ()

@end

@implementation AveragesScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    yourStats = [[NSMutableArray alloc] init];
    [self initData];
    [self loadParse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initData {
    headData =[[NSMutableArray alloc] initWithObjects:@"yourscore",@"opponentscore",@"twoptmade",@"twoptattempted",@"threeptmade",@"threeptattempted",@"freethrowmade",@"freethrowattempted",@"assists",@"totalrebounds",@"defrebounds",@"offrebounds",@"steals",@"blocks",@"turnovers",@"scoringstyle",@"pickupgame",@"seasongame",nil];
    
    leftTableData=[[NSMutableArray alloc] init];
    rightTableData = [[NSMutableArray alloc] init];
}


- (void)loadParse {
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
                 NSMutableArray *leftTableDataCount=[[NSMutableArray alloc]init];
                 
                 NSLog(@"All Object: %@",yourStats);
                 NSMutableArray *twoL=[[NSMutableArray alloc] init];
                 NSMutableArray *twoLL=[[NSMutableArray alloc] init];
                 for (int j=0;j<[yourStats count]; j++) {
                     NSString *dateStr=[self dateToStringConvertion:[[yourStats objectAtIndex:j] valueForKey:@"createdAt"]];
                     [twoL addObject:dateStr];
                 }
                 [leftTableData removeAllObjects];
                 NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:twoL];
                 [twoLL addObjectsFromArray:[orderedSet array]];
                 [leftTableData addObject:twoLL];
                 NSLog(@"leftTableData = %@",leftTableData);
                 
                 for(int i=0;i< [twoL count]; i++){
                     NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:twoL];
                     int cnt=(int)[countedSet countForObject:[twoL objectAtIndex:i]];
                     NSNumber *countNumber= [NSNumber numberWithInt:cnt];
                     [leftTableDataCount addObject:countNumber];
                     i=i+cnt-1;
                 }
                 
                NSMutableArray *twoR=[[NSMutableArray alloc] init];
                 int reCount=0;
                 int count = 0;
                 for (int m=0;m<[leftTableDataCount count]; m++){
                     NSMutableArray *arr=[[NSMutableArray alloc] init];
                     for(int i=0;i<[headData count];i++){
                      if([[headData objectAtIndex:i] isEqualToString:@"pickupgame"]){
                          int sumValue=0;
                          int pickUpCount=0;
                          count=reCount;
                          for (int j=0;j<[[leftTableDataCount objectAtIndex:m]intValue]; j++) {
                              if ([[[yourStats objectAtIndex:count] objectForKey:@"type"] isEqualToString:@"Pickup"]) {
                                  if([[[yourStats objectAtIndex:count] objectForKey:@"win"] isEqualToString:@"YES"]){
                                      sumValue = sumValue + 1;
                                  }
                                  pickUpCount++;
                              }
                              count++;
                          }
                          [arr addObject:[NSString stringWithFormat:@"%d/%d",sumValue,pickUpCount]];
                      }else if([[headData objectAtIndex:i] isEqualToString:@"seasongame"]){
                          int sumValue=0;
                          int pickUpCount=0;
                          count=reCount;
                          for (int j=0;j<[[leftTableDataCount objectAtIndex:m]intValue]; j++) {
                              if ([[[yourStats objectAtIndex:count] objectForKey:@"type"] isEqualToString:@"Season"]) {
                                  if([[[yourStats objectAtIndex:count] objectForKey:@"win"] isEqualToString:@"YES"]){
                                      sumValue = sumValue + 1;
                                  }
                                  pickUpCount++;
                              }
                              count++;
                          }
                          [arr addObject:[NSString stringWithFormat:@"%d/%d",sumValue,pickUpCount]];
                      }else{
                          int sumValue=0;
                          count=reCount;
                          for (int j=0;j<[[leftTableDataCount objectAtIndex:m]intValue]; j++) {
                              if ([[yourStats objectAtIndex:count] objectForKey:[headData objectAtIndex:i]]) {
                                  sumValue = sumValue + [[[yourStats objectAtIndex:count] valueForKey:[headData objectAtIndex:i]] intValue];
                              }else{
                                  sumValue=sumValue+ 0;
                              }
                              count++;
                          }
                          [arr addObject:[NSString stringWithFormat:@"%d",(sumValue/[[leftTableDataCount objectAtIndex:m]intValue])]];
                      }
                    }
                    reCount=count;
                    [twoR addObject:arr];
                 }
                 [rightTableData removeAllObjects];
                 [rightTableData addObject:twoR];

                 NSLog(@"left array=%@",leftTableData);
                 NSLog(@"right array=%@",rightTableData);

                 tableView = [[XCMultiTableView alloc] initWithFrame:CGRectInset(self.view.bounds, 5.0f, 5.0f)];
                 tableView.leftHeaderEnable = YES;
                 tableView.datasource = self;
                 [self.view addSubview:tableView];
                 [self RemoveLoadingView];
             } else {
                 [self RemoveLoadingView];
                 [ProgressHUD showError:@"No Stats To Show"];
             }
         }];
    }
}
-(NSString *)dateToStringConvertion :(NSDate *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM-yy"];
    NSString *stringDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateString]];
    NSLog(@"%@", stringDate);
    
    return stringDate;
}

#pragma mark - XCMultiTableViewDataSource

- (NSArray *)arrayDataForTopHeaderInTableView:(XCMultiTableView *)tableView {
    return [headData copy];
}
- (NSArray *)arrayDataForLeftHeaderInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    NSLog(@"Header = %@",[leftTableData objectAtIndex:section]);
    return [leftTableData objectAtIndex:section];
}

- (NSArray *)arrayDataForContentInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    NSLog(@"content = %@",[rightTableData objectAtIndex:section]);
    return [rightTableData objectAtIndex:section];
}

- (NSUInteger)numberOfSectionsInTableViews:(XCMultiTableView *)tableView {
    return [leftTableData count];
}

- (AlignHorizontalPosition)tableView:(XCMultiTableView *)tableView inColumn:(NSInteger)column {
    return AlignHorizontalPositionCenter;
}

- (CGFloat)tableView:(XCMultiTableView *)tableView contentTableCellWidth:(NSUInteger)column {
    return 150.0f;
}

- (CGFloat)tableView:(XCMultiTableView *)tableView cellHeightInRow:(NSUInteger)row InSection:(NSUInteger)section {
    return 35.0f;
}

- (UIColor *)tableView:(XCMultiTableView *)tableView bgColorInSection:(NSUInteger)section InRow:(NSUInteger)row InColumn:(NSUInteger)column {
    if (row % 2 == 0) {
        return [UIColor colorWithRed:115.0/255.0 green:153.0/255.0 blue:198.0/255.0 alpha:0.8];
    }
    return [UIColor colorWithRed:190.0/255.0 green:212.0/255.0 blue:233.0/255.0 alpha:0.8];
}

- (UIColor *)tableView:(XCMultiTableView *)tableView headerBgColorInColumn:(NSUInteger)column {
    return [UIColor blackColor];
}

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
