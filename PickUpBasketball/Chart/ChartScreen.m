//
//  ChartScreen.m
//  pickupbasketball
//
//  Created by Samrat on 30/06/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
#import "AppDelegate.h"
#import "ChartScreen.h"


@interface ChartScreen ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ChartScreen
AppDelegate *appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    cellSelectedArray=[[NSMutableArray alloc] init];
    isShown=FALSE;
    SelectedCellBGColor = [UIColor colorWithRed:0.0f/255.0f green:31.0f/255.0f blue:112.0f/255.0f alpha:1.0f];
    NotSelectedCellBGColor =[UIColor colorWithRed:115.0f/255.0f green:153.0f/255.0f blue:198.0f/255.0f alpha:1.0f];
    yourStats = [[NSMutableArray alloc] init];
    arrayOfTitel=[[NSMutableArray alloc] initWithObjects:@"yourscore",@"opponentscore",@"twoptmade",@"twoptattempted",@"threeptmade",@"threeptattempted",@"freethrowmade",@"freethrowattempted",@"assists",@"totalrebounds",@"defrebounds",@"offrebounds",@"steals",@"blocks",@"turnovers",@"scoringstyle",nil];
    [cellSelectedArray addObject:[NSNumber numberWithInt:0]];
    _lblLineChart.text=[[arrayOfTitel objectAtIndex:0] uppercaseString];
    [self loadParse:[arrayOfTitel objectAtIndex:0]];
    self.chartListTableView.alpha=0.0;
}

#pragma mark - Select First Row as default in UITableView
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.chartListTableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Chartview Creat
-(void)loadChartView{
    NSInteger arrayCount=[yValueArray count];
    NSArray *arr=[yValueArray objectAtIndex:0];
    NSLog(@"Array count =%d",arrayCount);
    NSLog(@"Arr count =%lu",(unsigned long)[arr count]);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    if(60*[arr count] > width-20){
         _showChartScrollView.contentSize=CGSizeMake((60*[arr count]), _showChartScrollView.frame.size.height);
    }else{
         _showChartScrollView.contentSize=CGSizeMake(width-30, _showChartScrollView.frame.size.height);
    }
     NSLog(@"_showChartScrollView contentSize= %@",NSStringFromCGSize(_showChartScrollView.contentSize));
    if(chartView!=nil){
        [chartView removeFromView];
    }
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(0, 10, _showChartScrollView.contentSize.width -10, _showChartScrollView.contentSize.height-20)
                                              withSource:self
                                               withStyle:UUChartLineStyle];
    NSLog(@"chartView frame= %@",NSStringFromCGRect(chartView.frame));
    [chartView showInView:_showChartScrollView];
    appDelegate=[UIApplication sharedApplication ].delegate;
    NSLog(@"appDelegate.yChartLableArray =%@",appDelegate.yChartLableArray);
    
    UIView *sideView=[[UIView alloc] initWithFrame:CGRectMake(10, 10, 20, chartView.frame.size.height)];
    sideView.backgroundColor=[UIColor whiteColor];
    UILabel *lblOne=[[UILabel alloc] initWithFrame:CGRectMake(0, 423, 20, 10)];
    lblOne.text=[appDelegate.yChartLableArray objectAtIndex:0];
    [lblOne setTextAlignment:NSTextAlignmentRight];
    [lblOne setFont:[UIFont boldSystemFontOfSize:9.0f]];
    [lblOne setTextColor: UUDeepGrey];
    [sideView addSubview:lblOne];
    
    UILabel *lblTwo=[[UILabel alloc] initWithFrame:CGRectMake(0, 318.5, 20, 10)];
    lblTwo.text=[appDelegate.yChartLableArray objectAtIndex:1];
    [lblTwo setFont:[UIFont boldSystemFontOfSize:9.0f]];
    [lblTwo setTextAlignment:NSTextAlignmentRight];
    [lblTwo setTextColor: UUDeepGrey];
    [sideView addSubview:lblTwo];
    
    UILabel *lblThree=[[UILabel alloc] initWithFrame:CGRectMake(0, 214, 20, 10)];
    lblThree.text=[appDelegate.yChartLableArray objectAtIndex:2];
    [lblThree setFont:[UIFont boldSystemFontOfSize:9.0f]];
    [lblThree setTextAlignment:NSTextAlignmentRight];
    [lblThree setTextColor: UUDeepGrey];
    [sideView addSubview:lblThree];
    
    UILabel *lblFour=[[UILabel alloc] initWithFrame:CGRectMake(0, 109.5, 20, 10)];
    lblFour.text=[appDelegate.yChartLableArray objectAtIndex:3];
    [lblFour setFont:[UIFont boldSystemFontOfSize:9.0f]];
    [lblFour setTextAlignment:NSTextAlignmentRight];
    [lblFour setTextColor: UUDeepGrey];
    [sideView addSubview:lblFour];
    
    UILabel *lblFive=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 20, 10)];
    lblFive.text=[appDelegate.yChartLableArray objectAtIndex:4];
    [lblFive setFont:[UIFont boldSystemFontOfSize:9.0f]];
    [lblFive setTextAlignment:NSTextAlignmentRight];
    [lblFive setTextColor: UUDeepGrey];
    [sideView addSubview:lblFive];
    
    [self.yLabelView addSubview:sideView];
}

#pragma mark - Parse Load
-(void)loadParse :(NSString *)chartTitelName{
     if ([PFUser currentUser] != nil) {
         [self AddLoadingView];
         PFQuery *query = [PFQuery queryWithClassName:PF_GAME_CLASS_NAME];
         [query whereKey:PF_GAME_USER equalTo:[PFUser currentUser]];
//         [query whereKey:@"user"
//                 equalTo:[PFObject objectWithoutDataWithClassName:PF_USER_CLASS_NAME objectId:@"4hmtjrWSeA"]];
         [query orderByDescending:@"createdAt"];
         [query setLimit:1000];
         [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
          {
              if (error == nil) {
                  [yourStats removeAllObjects];
                  [yourStats addObjectsFromArray:objects];
                  xLableArray=[[NSMutableArray alloc] init];
                  yValueArray =[[NSMutableArray alloc] init];
                  NSMutableArray *tempXLabelArray=[[NSMutableArray alloc]init];
                  NSMutableArray *tempYValueArray=[[NSMutableArray alloc]init];
                  NSMutableArray *xLabelCountArray=[[NSMutableArray alloc]init];
                  for (int j=0;j<[yourStats count]; j++) {
                      NSString *dateStr=[self dateToStringConvertion:[[yourStats objectAtIndex:j] valueForKey:@"createdAt"]];
                      [tempXLabelArray addObject:dateStr];
                  }
                  NSLog(@"temp XLabelArray = %@",tempXLabelArray);
                  NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:tempXLabelArray];
                  [xLableArray addObjectsFromArray:[orderedSet array]];
                  NSLog(@"x LableArray = %@",xLableArray);
                  for (int j=0;j<[yourStats count]; j++) {
                      if ([[yourStats objectAtIndex:j] objectForKey:chartTitelName]) {
                          [tempYValueArray addObject:[NSString stringWithFormat:@"%@",[[yourStats objectAtIndex:j] valueForKey:chartTitelName]]];
                      }else{
                          [tempYValueArray addObject:@"0"];
                      }
                  }
                   NSLog(@"temp YValueArray = %@",tempYValueArray);
                  for(int i=0;i< [tempXLabelArray count]; i++){
                      NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:tempXLabelArray];
                      int cnt=(int)[countedSet countForObject:[tempXLabelArray objectAtIndex:i]];
                      NSNumber *countNumber= [NSNumber numberWithInt:cnt];
                      [xLabelCountArray addObject:countNumber];
                      i=i+cnt-1;
                  }

                   NSMutableArray *arr=[[NSMutableArray alloc] init];
                  int arrayCount=0;
                  for (int i=0; i<[xLabelCountArray count];i++) {
                      
                      int sumValue=0;
                      
                      for (int j=0; j< [[xLabelCountArray objectAtIndex:i] intValue]; j++) {
                          sumValue=sumValue+[[tempYValueArray objectAtIndex:arrayCount] intValue];
                          arrayCount++;
                      }
                      [arr addObject:[NSString stringWithFormat:@"%d",(sumValue/[[xLabelCountArray objectAtIndex:i] intValue])]];
                  }
                  [yValueArray addObject:[[NSArray arrayWithArray:arr] copy]];
                  NSLog(@"YValueArray = %@",yValueArray);
                  [self loadChartView];
                  [self RemoveLoadingView];
              }else {
                  [self RemoveLoadingView];
                  [ProgressHUD showError:@"No Stats To Show"];
              }
          }];
     }
}

#pragma mark - Date Converter
-(NSString *)dateToStringConvertion :(NSDate *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM-yy"];
    NSString *stringDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateString]];
    return stringDate;
}

#pragma mark - @required
#pragma mark -Array abscissa title
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    NSArray *array1 = [[NSArray arrayWithArray:xLableArray] copy];
    return array1;
}

#pragma mark -Numerical jagged array
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    NSArray *array = [[NSArray arrayWithArray:yValueArray] copy];
    NSLog(@"Array =%@ ",@[array]);
    return @[array];
}

#pragma mark - @optional
#pragma mark -An array of colors
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UURed];
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
    return NO;
}

#pragma mark - UITableView  Row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        return 30;
    }else{
        return 50;
    }
    
}

#pragma mark - UITableView  number of section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableView  number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrayOfTitel count];
}

#pragma mark - UITableView Cell Creation
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] ;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    int row=indexPath.row;
    NSNumber* rowValue = [NSNumber numberWithInt:row];
    if(cellSelectedArray.count==0){
        [cell setBackgroundColor:NotSelectedCellBGColor];
        cell.textLabel.textColor=SelectedCellBGColor;
    }else{
        for(NSNumber *i in cellSelectedArray)
        {
            
            if([i isEqualToNumber:rowValue])
            {
                [cell setBackgroundColor:SelectedCellBGColor];
                cell.textLabel.textColor=NotSelectedCellBGColor;
            }else{
                [cell setBackgroundColor:NotSelectedCellBGColor];
                cell.textLabel.textColor=SelectedCellBGColor;
            }
        }
    }
    cell.textLabel.text = [[arrayOfTitel objectAtIndex:indexPath.row] uppercaseString];
    return cell;
}

#pragma mark - UITableView Cell Seperator full width
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.chartListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.chartListTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.chartListTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.chartListTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UITableView Cell Selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
 NSLog(@"Select Indexpath.row=%ld",(long)indexPath.row);
    int row=indexPath.row;
    NSNumber* rowValue = [NSNumber numberWithInt:row];
    if(cellSelectedArray.count==0){
         [cellSelectedArray addObject:rowValue];
    }else{
        if(![cellSelectedArray containsObject:rowValue]){
            [cellSelectedArray removeAllObjects];
            [cellSelectedArray addObject:rowValue];
        }
    }
   
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:SelectedCellBGColor];
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor=NotSelectedCellBGColor;
    self.lblLineChart.text=[[arrayOfTitel objectAtIndex:indexPath.row] uppercaseString];
    [self loadParse:[arrayOfTitel objectAtIndex:indexPath.row]];
    [UIView animateWithDuration:0.5 animations:^{
                self.chartListTableView.alpha=0.0;
    }];
    isShown = false;
}

#pragma mark - UITableView Cell Delselection
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Deselect Indexpath.row=%ld",(long)indexPath.row);
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:NotSelectedCellBGColor];
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor=SelectedCellBGColor;
   
}

#pragma mark - Loading
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

#pragma mark - Drop Down Menu Show
- (IBAction)btnLineChartAction:(id)sender {
    
    if (!isShown) {
        [UIView animateWithDuration:0.5  animations:^{
            self.chartListTableView.alpha=1.0;
        }];
        isShown = true;
    } else {
        [UIView animateWithDuration:0.5  animations:^{
            self.chartListTableView.alpha=0.0;
        }];
        isShown = false;
    }
    

    
}
@end
