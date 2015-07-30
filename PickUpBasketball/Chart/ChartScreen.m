//
//  AnalyticsScreen.m
//  pickupbasketball
//
//  Created by Samrat on 15/07/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//
#import "ChartCell.h"
#import "Configs.h"
#import "ProgressHUD.h"
#import "ChartScreen.h"

@interface ChartScreen ()

@end

@implementation ChartScreen
NSNumber* rowNumber;
NSIndexPath *selectedIndexPath;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    isShown=FALSE;
    self.pickerBGView.alpha=0.0;
    self.filterTableView.alpha=0.0;
    yourStats = [[NSMutableArray alloc] init];
    cellSelectedArray=[[NSMutableArray alloc] init];
    SelectedCellBGColor = [UIColor colorWithRed:0.0f/255.0f green:31.0f/255.0f blue:112.0f/255.0f alpha:1.0f];
    NotSelectedCellBGColor =[UIColor colorWithRed:115.0f/255.0f green:153.0f/255.0f blue:198.0f/255.0f alpha:1.0f];
    [self initData];
    rowNumber=[NSNumber numberWithInt:0];
    selectedIndexPath=0;
    calculationStatus=NO;
    [self loadParse:@"all"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initData {
    teamSizeArray=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    gameTypeArray=[[NSMutableArray alloc]initWithObjects:@"Season",@"Pickup", nil];
    headData =[[NSMutableArray alloc] initWithObjects:@"yourscore",@"opponentscore",@"twoptmade",@"twoptattempted",@"threeptmade",@"threeptattempted",@"freethrowmade",@"freethrowattempted",@"assists",@"totalrebounds",@"defrebounds",@"offrebounds",@"steals",@"blocks",@"turnovers",@"win",nil];
    
    filteredTitelArray=[[NSMutableArray alloc] initWithObjects:@"All",@"Season",@"Pickup",@"Wins",@"Loses",@"Season ID",@"Team Size",@"Full Court",@"Not Full Court",nil];
    
    filteredKeyArray=[[NSMutableArray alloc] initWithObjects:@"all",@"type,Season",@"type,Pickup",@"win,YES",@"win,NO",@"seasonid,seasonid",@"teamsize,teamsize",@"fullcourt,YES",@"fullcourt,NO",nil];
    seasonIdArray=[[NSMutableArray alloc]init];
    leftTableData=[[NSMutableArray alloc] init];
    rightTableData = [[NSMutableArray alloc] init];
}
#pragma mark - Select First Row as default in UITableView
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.filterTableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView==self.chartTableView){
        if([leftTableData count] !=0 && [rightTableData count] !=0){
            return [headData count];
        }else{
            return 0;
        }
    }else if(tableView==self.filterTableView){
        return 1;
    }else{
        return 0;
    }
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView==self.chartTableView){
        if([leftTableData count] !=0 && [rightTableData count] !=0){
            return 1;
        }else{
            return 0;
        }
    }else if(tableView==self.filterTableView){
        return [filteredTitelArray count];
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==self.chartTableView){
        
       static NSString *MyIdentifier = @"ChartCell";
       ChartCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[ChartCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:MyIdentifier] ;
        }
        [cell configUI: indexPath : leftTableData : rightTableData];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(tableView==self.filterTableView){
        
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
        int row=(int)indexPath.row;
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
        cell.textLabel.text = [[filteredTitelArray objectAtIndex:indexPath.row] uppercaseString];
        return cell;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.chartTableView){
        return 150;
    }else if(tableView==self.filterTableView){
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            return 30;
        }else{
            return 50;
        }
    }else{
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView==self.chartTableView){
         return 30;
    }else if(tableView==self.filterTableView){
         return 0;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView==self.chartTableView){
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 30);
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        label.font = [UIFont systemFontOfSize:20];
        label.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
        if([[headData objectAtIndex:section] isEqualToString:@"win"]){
          label.text=@"TOTAL NUMBER OF WIN";
        }else{
          label.text=[[headData objectAtIndex:section] uppercaseString];
        }
        label.textColor = SelectedCellBGColor;//[UIColor colorWithRed:0.257 green:0.650 blue:0.478 alpha:1.000];
        label.textAlignment = NSTextAlignmentCenter;
        return label;
    }else {
        return nil;
    }
    
}
#pragma mark - UITableView Cell Seperator full width
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.filterTableView){
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.filterTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.filterTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.filterTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.filterTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UITableView Cell Selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView==self.filterTableView){
        teamValue=@"";
        selectedIndexPath=indexPath;
        NSLog(@"Select Indexpath.row=%ld",(long)indexPath.row);
        int row=(int)indexPath.row;
        rowNumber = [NSNumber numberWithInt:row];
        if([[filteredTitelArray objectAtIndex:indexPath.row] isEqualToString:@"Team Size"] ){
            pickerViewSelection=@"Team Size";
            [self showPickerView];
        }else if([[filteredTitelArray objectAtIndex:indexPath.row] isEqualToString:@"Season ID"]){
            if([seasonIdArray count]>0){
                pickerViewSelection=@"Season ID";
                [self showPickerView];
            }else{
                 [ProgressHUD showError:@"There are no Season Id."];
            }
        }else if([[filteredTitelArray objectAtIndex:indexPath.row] isEqualToString:@"Wins"]){
            pickerViewSelection=@"Wins";
            [self showPickerView];
        }else if([[filteredTitelArray objectAtIndex:indexPath.row] isEqualToString:@"Loses"]){
            pickerViewSelection=@"Loses";
            [self showPickerView];
        }else{
            pickerViewSelection=@"";
            [self loadParse:[filteredKeyArray objectAtIndex:indexPath.row]];
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            self.filterTableView.alpha=0.0;
        }];
        isShown = false;
    }
}
-(void)showPickerView{
    [UIView animateWithDuration:0.5  animations:^{
        self.pickerBGView.alpha=1.0;
    }];
    [self.teamSizePickerView reloadAllComponents];
}
#pragma mark - UITableView Cell Delselection
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.filterTableView){
        NSLog(@"Deselect Indexpath.row=%ld",(long)indexPath.row);
        [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:NotSelectedCellBGColor];
        [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor=SelectedCellBGColor;
    }
}

- (void)loadParse :(NSString *) keyType {
    if ([PFUser currentUser] != nil) {
        [self AddLoadingView];
        PFQuery *query = [PFQuery queryWithClassName:PF_GAME_CLASS_NAME];
        if([keyType isEqualToString:@"all"]){
            [query whereKey:PF_GAME_USER equalTo:[PFUser currentUser]];
        }else{
            NSArray* array = [keyType componentsSeparatedByString: @","];
            NSString *keyString=[array objectAtIndex:0];
            NSString *valueString=[array objectAtIndex:1];
            if([keyString isEqualToString:@"seasonid"]){
                [query whereKey:keyString equalTo:teamValue];
            }else if([keyString isEqualToString:@"teamsize"]){
                [query whereKey:keyString equalTo:teamValue];
            }else if([keyString isEqualToString:@"win"]){
                [query whereKey:keyString equalTo:valueString];
                [query whereKey:@"type" equalTo:teamValue];
            }else{
                [query whereKey:keyString equalTo:valueString];
            }
            [query whereKey:PF_GAME_USER equalTo:[PFUser currentUser]];
//            [query whereKey:@"user"
//                    equalTo:[PFObject objectWithoutDataWithClassName:PF_USER_CLASS_NAME objectId:@"4hmtjrWSeA"]];

        }
        [query orderByDescending:@"createdAt"];
        [query setLimit:1000];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
         {
             if (error == nil) {
                 if([objects count]>0){
                     [yourStats removeAllObjects];
                     [yourStats addObjectsFromArray:objects];
                    
                     NSMutableArray *leftTableDataCount=[[NSMutableArray alloc]init];
                     NSLog(@"All Object: %@",yourStats);
                     NSMutableArray *twoL=[[NSMutableArray alloc] init];
                     NSMutableArray *twoLL=[[NSMutableArray alloc] init];
                     if([seasonIdArray count]==0){
                         for (int j=0;j<[yourStats count]; j++) {
                             if ([[yourStats objectAtIndex:j] objectForKey:@"seasonid"]) {
                                 NSString*seasionStr=[NSString stringWithFormat:@"%@",[[yourStats objectAtIndex:j] objectForKey:@"seasonid"]];
                                 if(seasionStr.length>0){
                                     [seasonIdArray addObject:[[yourStats objectAtIndex:j] valueForKey:@"seasonid"]];
                                 }
                             }
                         }
                         NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:seasonIdArray];
                         [seasonIdArray removeAllObjects];
                         [seasonIdArray addObjectsFromArray:[orderedSet array]];
                     }
                       NSLog(@"seasonIdArray = %@",seasonIdArray);
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
                     NSLog(@"leftTableDataCount = %@",leftTableDataCount);
                     NSMutableArray *twoR=[[NSMutableArray alloc] init];
                     for (int m=0;m< [headData count]; m++) {
                         
                         NSMutableArray *tempYValueArray=[[NSMutableArray alloc]init];
                         for (int j=0;j<[yourStats count]; j++) {
                             if([[headData objectAtIndex:m] isEqualToString:@"win"]){
                                 
                                 if ([[yourStats objectAtIndex:j] objectForKey:[headData objectAtIndex:m]]) {
                                     if([[[yourStats objectAtIndex:j] valueForKey:[headData objectAtIndex:m]] isEqualToString:@"YES"]){
                                         [tempYValueArray addObject:@"1"];
                                     }else{
                                         [tempYValueArray addObject:@"0"];
                                     }
                                 }else{
                                     [tempYValueArray addObject:@"NA"];
                                 }
                             }else{
                                 if ([[yourStats objectAtIndex:j] objectForKey:[headData objectAtIndex:m]]) {
                                     
                                     [tempYValueArray addObject:[NSString stringWithFormat:@"%@",[[yourStats objectAtIndex:j] valueForKey:[headData objectAtIndex:m]]]];
                                 }else{
                                     [tempYValueArray addObject:@"NA"];
                                 }
                             }
                         }
                         NSLog(@"tempYValueArray = %@",tempYValueArray);
                         NSMutableArray *arr=[[NSMutableArray alloc] init];
                         int arrayCount=0;
                         for (int i=0; i<[leftTableDataCount count];i++) {
                             if([[headData objectAtIndex:m] isEqualToString:@"win"]){
                                 int sumValue=0;
                                 for (int j=0; j< [[leftTableDataCount objectAtIndex:i] intValue]; j++) {
                                     if([[tempYValueArray objectAtIndex:arrayCount] isEqualToString:@"NA"]){
                                         //nothing
                                     }else{
                                         sumValue=sumValue+[[tempYValueArray objectAtIndex:arrayCount] intValue];
                                     }
                                    
                                     
                                     arrayCount++;
                                     
                                 }
                                 [arr addObject:[NSString stringWithFormat:@"%d",sumValue]];
                             }else{
                                 int sumValue=0;
                                 int undefinedCount=0;
                                 for (int j=0; j< [[leftTableDataCount objectAtIndex:i] intValue]; j++) {
                                     if([[tempYValueArray objectAtIndex:arrayCount] isEqualToString:@"NA"]){
                                         undefinedCount++;
                                     }else{
                                         sumValue=sumValue+[[tempYValueArray objectAtIndex:arrayCount] intValue];
                                     }
                                     
                                     
                                     arrayCount++;
                                 }
                                 if(calculationStatus){
                                     [arr addObject:[NSString stringWithFormat:@"%d",sumValue]];
                                 }else{
                                     NSLog(@" average value= %.2f",(sumValue/([[leftTableDataCount objectAtIndex:i] floatValue]-undefinedCount)));
                                     
                                     NSLog(@"undefinedCount= %d",undefinedCount);
                                     if(([[leftTableDataCount objectAtIndex:i] floatValue]-undefinedCount)==0){
                                         [arr addObject:[NSString stringWithFormat:@"0.00"]];
                                     }else{
                                          [arr addObject:[NSString stringWithFormat:@"%.2f",(sumValue/([[leftTableDataCount objectAtIndex:i] floatValue]-undefinedCount))]];
                                     }
                                 }
                             }
                         }
                         NSLog(@"arr = %@",arr);
                         [twoR addObject:arr];
                     }
                     [rightTableData removeAllObjects];
                     [rightTableData addObject:twoR];
                     if(cellSelectedArray.count==0){
                         [cellSelectedArray addObject:rowNumber];
                     }else{
                         if(![cellSelectedArray containsObject:rowNumber]){
                             [cellSelectedArray removeAllObjects];
                             [cellSelectedArray addObject:rowNumber];
                         }
                     }
                     [[self.filterTableView cellForRowAtIndexPath:selectedIndexPath] setBackgroundColor:SelectedCellBGColor];
                     [self.filterTableView cellForRowAtIndexPath:selectedIndexPath].textLabel.textColor=NotSelectedCellBGColor;
                     self.lblFilteredOutlet.text=[[filteredTitelArray objectAtIndex:selectedIndexPath.row] uppercaseString];
                     [self.filterTableView reloadData];
                     [_chartTableView reloadData];
                     NSLog(@"left array=%@",leftTableData);
                     NSLog(@"right array=%@",rightTableData);
                     [self RemoveLoadingView];
                 }else{
                     [ProgressHUD showError:@"No Stats To Show"];
                     [self RemoveLoadingView];
                 }
                 
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

- (IBAction)btnFilteredAction:(id)sender {
    [UIView animateWithDuration:0.5  animations:^{
        self.pickerBGView.alpha=0.0;
    }];
    if (!isShown) {
        [UIView animateWithDuration:0.5  animations:^{
            self.filterTableView.alpha=1.0;
        }];
        isShown = true;
    } else {
        [UIView animateWithDuration:0.5  animations:^{
            self.filterTableView.alpha=0.0;
        }];
        isShown = false;
    }
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if([pickerViewSelection isEqualToString:@"Team Size"]){
        return teamSizeArray.count;
    }else if([pickerViewSelection isEqualToString:@"Season ID"]){
        return seasonIdArray.count;
    }else if([pickerViewSelection isEqualToString:@"Wins"]){
        return gameTypeArray.count;
    }else if([pickerViewSelection isEqualToString:@"Loses"]){
        return gameTypeArray.count;
    }else{
        return 0;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([pickerViewSelection isEqualToString:@"Team Size"]){
         return [teamSizeArray objectAtIndex:row];
    }else if([pickerViewSelection isEqualToString:@"Season ID"]){
         return [seasonIdArray objectAtIndex:row];
    }else if([pickerViewSelection isEqualToString:@"Wins"]){
        return [gameTypeArray objectAtIndex:row];
    }else if([pickerViewSelection isEqualToString:@"Loses"]){
        return [gameTypeArray objectAtIndex:row];
    }else{
        return nil;
    }
   
}
#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{

}
- (IBAction)btnDonePickerViewAction:(id)sender {
    [UIView animateWithDuration:0.5  animations:^{
        self.pickerBGView.alpha=0.0;
    }];
    if([pickerViewSelection isEqualToString:@"Team Size"]){
        teamValue =[NSString stringWithFormat:@"%@",[teamSizeArray objectAtIndex:[self.teamSizePickerView selectedRowInComponent:0]]];
         NSLog(@"%@", teamValue);
        [self loadParse:@"teamsize,teamsize"];
    }else if([pickerViewSelection isEqualToString:@"Season ID"]){
        teamValue =[NSString stringWithFormat:@"%@",[seasonIdArray objectAtIndex:[self.teamSizePickerView selectedRowInComponent:0]]];
         NSLog(@"%@", teamValue);
        [self loadParse:@"seasonid,seasonid"];
    }else if([pickerViewSelection isEqualToString:@"Wins"]){
        teamValue =[NSString stringWithFormat:@"%@",[gameTypeArray objectAtIndex:[self.teamSizePickerView selectedRowInComponent:0]]];
        NSLog(@"%@", teamValue);
        [self loadParse:@"win,YES"];
    }else{
        teamValue =[NSString stringWithFormat:@"%@",[gameTypeArray objectAtIndex:[self.teamSizePickerView selectedRowInComponent:0]]];
        NSLog(@"%@", teamValue);
        [self loadParse:@"win,NO"];
    }

}
- (IBAction)btnToggleTotalAndAvarageAction:(id)sender{
    calculationStatus=!calculationStatus;
    if(calculationStatus){
        [self.btnToggleTotalAndAverage setTitle:@"Monthly Total"];
    }else{
        [self.btnToggleTotalAndAverage setTitle:@"Monthly Average"];
    }
    rowNumber=[NSNumber numberWithInt:0];
    selectedIndexPath=0;
    [self loadParse:@"all"];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.filterTableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
    
}
@end
