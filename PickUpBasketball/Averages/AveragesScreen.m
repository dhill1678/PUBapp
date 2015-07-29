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
    [self loadParse:@"all"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Select First Row as default in UITableView
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.filterTableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
}

- (void)initData {
    headData =[[NSMutableArray alloc] initWithObjects:@"yourscore",@"opponentscore",@"twoptmade",@"twoptattempted",@"threeptmade",@"threeptattempted",@"freethrowmade",@"freethrowattempted",@"assists",@"totalrebounds",@"defrebounds",@"offrebounds",@"steals",@"blocks",@"turnovers",@"scoringstyle",@"pickupgame",@"seasongame",nil];
    avarageArray=[[NSMutableArray alloc] init];
    teamSizeArray=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    gameTypeArray=[[NSMutableArray alloc]initWithObjects:@"Season",@"Pickup", nil];
    filteredTitelArray=[[NSMutableArray alloc] initWithObjects:@"All",@"Season",@"Pickup",@"Wins",@"Loses",@"Season ID",@"Team Size",@"Full Court",@"Not Full Court",nil];
    
    filteredKeyArray=[[NSMutableArray alloc] initWithObjects:@"all",@"type,Season",@"type,Pickup",@"win,YES",@"win,NO",@"seasonid,seasonid",@"teamsize,teamsize",@"fullcourt,YES",@"fullcourt,NO",nil];
    seasonIdArray=[[NSMutableArray alloc]init];
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
                      [avarageArray removeAllObjects];
                      [yourStats addObjectsFromArray:objects];
                      NSLog(@"All Object: %@",yourStats);
                      for(int i=0;i<[headData count];i++){
                          if([[headData objectAtIndex:i] isEqualToString:@"pickupgame"]){
                              int sumValue=0;
                              int losesCount=0;
                              for (int j=0;j<[yourStats count]; j++) {
                                  if ([[[yourStats objectAtIndex:j] objectForKey:@"type"] isEqualToString:@"Pickup"]) {
                                      if([[[yourStats objectAtIndex:j] objectForKey:@"win"] isEqualToString:@"YES"]){
                                          sumValue = sumValue + 1;
                                      }else{
                                          losesCount=losesCount+1;
                                      }
                                  }
                              }
                              if((sumValue+losesCount)==0){
                                  [avarageArray addObject:[NSString stringWithFormat:@"0.0"]];
                              }else{
                                  [avarageArray addObject:[NSString stringWithFormat:@"%.1f",(float)sumValue/(sumValue+losesCount)]];
                              }
                              
                          }else if([[headData objectAtIndex:i] isEqualToString:@"seasongame"]){
                              int sumValue=0;
                              int losesCount=0;
                              for (int j=0;j<[yourStats count]; j++) {
                                  if([seasonIdArray count]==0){
                                      if ([[yourStats objectAtIndex:j] objectForKey:@"seasonid"]) {
                                          [seasonIdArray addObject:[[yourStats objectAtIndex:j] valueForKey:@"seasonid"]];
                                      }
                                  }
                                  if ([[[yourStats objectAtIndex:j] objectForKey:@"type"] isEqualToString:@"Season"]) {
                                      if([[[yourStats objectAtIndex:j] objectForKey:@"win"] isEqualToString:@"YES"]){
                                          sumValue = sumValue + 1;
                                      }else{
                                          losesCount=losesCount+1;
                                      }
                                  }
                              }
                              if((sumValue+losesCount)==0){
                                   [avarageArray addObject:[NSString stringWithFormat:@"0.0"]];
                              }else{
                                   [avarageArray addObject:[NSString stringWithFormat:@"%.1f",(float)sumValue/(sumValue+losesCount)]];
                              }
                             
                          }else{
                              int sumValue=0;
                              int undifinedCount=0;
                              for (int j=0; j<[yourStats count]; j++) {
                                  if ([[yourStats objectAtIndex:j] objectForKey:[headData objectAtIndex:i]]) {
                                      sumValue = sumValue + [[[yourStats objectAtIndex:j] valueForKey:[headData objectAtIndex:i]] intValue];
                                  }else{
//                                      sumValue=sumValue+ 0;
                                      undifinedCount++;
                                  }
                              }
                              NSLog(@"undifinedCount=%d",undifinedCount);
                              if(([yourStats count]-undifinedCount)==0){
                                  [avarageArray addObject:[NSString stringWithFormat:@"0.00"]];
                              }else{
                                  [avarageArray addObject:[NSString stringWithFormat:@"%.2f",(float)sumValue/([yourStats count]-undifinedCount)]];
                              }
                          }
                      }
                      NSLog(@"average Array=%@",avarageArray);
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
                      [self.filterTableView reloadData];
                      [self.averageTableView reloadData];
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

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView==self.averageTableView){
        if([avarageArray count] !=0 ){
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
    if(tableView==self.averageTableView){
        if([avarageArray count] !=0 ){
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
    if(tableView==self.averageTableView){
        static NSString *MyIdentifier = @"AverageCell";
        AverageCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[AverageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:MyIdentifier] ;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
//        [UIView animateWithDuration:0.5 animations:^{
//            cell.lblStatsValue.alpha = 0;
//        } completion:^(BOOL finished) {
//            cell.lblStatsValue.text=[avarageArray objectAtIndex:indexPath.section];
//            [UIView animateWithDuration:0.5 animations:^{
//                cell.lblStatsValue.alpha = 1;
//            }];
//        }];
        
        cell.lblStatsValue.text=[avarageArray objectAtIndex:indexPath.section];
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
    
    if(tableView==self.averageTableView){
        return 100.0f;
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
    if(tableView==self.averageTableView){
        return 50.0f;
    }else if(tableView==self.filterTableView){
        return 0;
    }else{
        return 0;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView==self.averageTableView){
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 50);
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        label.font = [UIFont systemFontOfSize:25];
        label.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
        label.text=[[headData objectAtIndex:section] uppercaseString];
        label.textColor = SelectedCellBGColor;
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
