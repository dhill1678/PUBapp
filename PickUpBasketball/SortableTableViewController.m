/*
 *  ViewController.m
 *  XCMultiTableDemo
 *
 * Created by Kingiol on 2013-07-19.
 * Copyright (c) 2013 Kingiol Ding. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */
#import "SortableTableViewController.h"
#import "XCMultiSortTableView.h"
#import "Configs.h"
#import "ProgressHUD.h"

#import <Parse/Parse.h>

@interface SortableTableViewController () <XCMultiTableViewDataSource>
{
    NSMutableArray *yourStats;
}

@end

@implementation SortableTableViewController {
    NSMutableArray *headData;
    NSMutableArray *leftTableData;
    NSMutableArray *rightTableData;
}
NSNumber* rowNumber;
NSIndexPath *selectedIndexPath;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // initialize arrays
    self.pickerBGView.alpha=0.0;
    self.filterTableView.alpha=0.0;
    yourStats = [[NSMutableArray alloc] init];
    [self initData];
    [self loadParse:@"all"];
    NSLog(@"Your Stats: %@",yourStats);
    NSLog(@"Your Stats Count: %lu",(unsigned long)yourStats.count);
    
//    [self initData];
  
//    tableView = [[XCMultiTableView alloc] initWithFrame:CGRectInset(self.view.bounds, 5.0f, 5.0f)];
//    tableView.leftHeaderEnable = YES;
//    tableView.datasource = self;
//    [self.view addSubview:tableView];
    
}

- (void)initData {
    teamSizeArray=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    gameTypeArray=[[NSMutableArray alloc]initWithObjects:@"Season",@"Pickup", nil];
    headData =[[NSMutableArray alloc] initWithObjects:@"type",@"seasonid",@"win",@"yourscore",@"oponentscore",@"twoptmade",@"twoattempted",@"threeptmade",@"threeptattempted",@"freethrowmade",@"freethrowattempted",@"assists",@"totalrebounds",@"defrebounds",@"offrebounds",@"steals",@"blocks",@"turnovers",@"gamewinner",@"scoringstyle",@"teamsize",@"fullcourt",nil];
    
    filteredTitelArray=[[NSMutableArray alloc] initWithObjects:@"All",@"Season",@"Pickup",@"Wins",@"Loses",@"Season ID",@"Team Size",@"Full Court",@"Not Full Court",nil];
    
    filteredKeyArray=[[NSMutableArray alloc] initWithObjects:@"all",@"type,Season",@"type,Pickup",@"win,YES",@"win,NO",@"seasonid,seasonid",@"teamsize,teamsize",@"fullcourt,YES",@"fullcourt,NO",nil];
    cellSelectedArray=[[NSMutableArray alloc] init];
    seasonIdArray=[[NSMutableArray alloc]init];
    SelectedCellBGColor = [UIColor colorWithRed:0.0f/255.0f green:31.0f/255.0f blue:112.0f/255.0f alpha:1.0f];
    NotSelectedCellBGColor =[UIColor colorWithRed:115.0f/255.0f green:153.0f/255.0f blue:198.0f/255.0f alpha:1.0f];
    leftTableData=[[NSMutableArray alloc] init];
    rightTableData = [[NSMutableArray alloc] init];
    rowNumber=[NSNumber numberWithInt:0];
    [cellSelectedArray addObject:rowNumber];
    selectedIndexPath=0;
}
#pragma mark - Select First Row as default in UITableView
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.filterTableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if(tableView==self.filterTableView){
        return 1;
    }else{
        return 0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   if(tableView==self.filterTableView){
        return [filteredTitelArray count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==self.filterTableView){
        
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
 if(tableView==self.filterTableView){
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
    return 0;
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
//        if(cellSelectedArray.count==0){
//            [cellSelectedArray addObject:rowNumber];
//        }else{
//            if(![cellSelectedArray containsObject:rowNumber]){
//                [cellSelectedArray removeAllObjects];
//                [cellSelectedArray addObject:rowNumber];
//            }
//        }
//        [[self.filterTableView cellForRowAtIndexPath:selectedIndexPath] setBackgroundColor:SelectedCellBGColor];
//        [self.filterTableView cellForRowAtIndexPath:selectedIndexPath].textLabel.textColor=NotSelectedCellBGColor;
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
        }
        [query orderByDescending:@"createdAt"];
        [query setLimit:1000];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
         {
             if (error == nil) {
                 if([objects count]>0){
                     //[allObjects removeAllObjects];
                     [yourStats removeAllObjects];
                     [yourStats addObjectsFromArray:objects];
                     NSLog(@"All Object: %@",yourStats);
                     NSMutableArray *twoL=[[NSMutableArray alloc] init];
                     for (int j=0;j<[yourStats count]; j++) {
                         if([seasonIdArray count]==0){
                             if ([[yourStats objectAtIndex:j] objectForKey:@"seasonid"]) {
                                 [seasonIdArray addObject:[[yourStats objectAtIndex:j] valueForKey:@"seasonid"]];
                             }
                         }
                         NSString *dateStr=[self dateToStringConvertion:[[yourStats objectAtIndex:j] valueForKey:@"createdAt"]];
                         [twoL addObject:dateStr];
                     }
                     [leftTableData removeAllObjects];
                     [leftTableData addObject:twoL];
                     
                     NSMutableArray *twoR=[[NSMutableArray alloc] init];
                     for (int i=0;i<[yourStats count]; i++) {
                         NSMutableArray *ary = [[NSMutableArray alloc]init];
                         if ([[yourStats objectAtIndex:i] objectForKey:@"type"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"type"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"seasonid"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"seasonid"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"win"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"win"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"yourscore"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"yourscore"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"opponentscore"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"opponentscore"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"twoptmade"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"twoptmade"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"twoptattempted"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"twoptattempted"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"threeptmade"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"threeptmade"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"threeptattempted"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"threeptattempted"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"freethrowmade"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"freethrowmade"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"freethrowattempted"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"freethrowattempted"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"assists"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"assists"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"totalrebounds"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"totalrebounds"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"defrebounds"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"defrebounds"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"offrebounds"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"offrebounds"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"steals"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"steals"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"blocks"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"blocks"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"turnovers"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"turnovers"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"gamewinner"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"gamewinner"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"scoringstyle"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"scoringstyle"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"teamsize"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"teamsize"]];
                         }else{
                             [ary addObject:@""];
                         }
                         if ([[yourStats objectAtIndex:i] objectForKey:@"fullcourt"]) {
                             [ary addObject:[[yourStats objectAtIndex:i] valueForKey:@"fullcourt"]];
                         }else{
                             [ary addObject:@""];
                         }
                         [twoR addObject:ary];
                     }
                     [rightTableData removeAllObjects];
                     [rightTableData addObject:twoR];
                     NSLog(@"left array=%@",leftTableData);
                     NSLog(@"right array=%@",rightTableData);
                     if(XCMtableView){
                         [XCMtableView removeFromSuperview];
                         XCMtableView = nil;
                     }
                     XCMtableView = [[XCMultiTableView alloc] initWithFrame:CGRectInset(self.view.bounds, 5.0f, 5.0f)];
                     XCMtableView.leftHeaderEnable = YES;
                     XCMtableView.datasource = self;
                     [self.view addSubview:XCMtableView];
                     [self.view bringSubviewToFront:self.filterTableView];
                     [self.view bringSubviewToFront:self.pickerBGView];
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
                     [self RemoveLoadingView];
                 }else{
                     [self RemoveLoadingView];
                     [ProgressHUD showError:@"No Stats To Show"];
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
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dateString]];
    NSLog(@"%@", stringDate);
    
    return stringDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //return AlignHorizontalPositionRight;
    //return AlignHorizontalPositionLeft;
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

- (IBAction)filter:(id)sender {
    
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
    
//    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.filterTableView];
//    NSLog(@"Your Stats: %@",yourStats);
//    NSLog(@"Your Stats Count: %lu",(unsigned long)yourStats.count);
//    NSLog(@"Your Stats 1: %@",yourStats[1]);
}

- (IBAction)btnDonePickerAction:(id)sender {

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
   
//    teamValue=[NSString stringWithFormat:@"%@",[teamSizeArray objectAtIndex:row]];
   
   
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
