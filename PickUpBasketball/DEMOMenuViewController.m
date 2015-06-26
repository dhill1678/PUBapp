//
//  DEMOMenuViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "DEMOHomeViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "DEMONavigationController.h"
//#import "ProfileViewController.h"
#import "PlayerCardViewController.h"
#import "AboutVC.h"
#import "ProfileVC.h"
#import "PracticeViewController.h"
#import "NewGameViewController.h"
#import "StatsHomeViewController.h"

#import "Configs.h"
#import "Utilities.h"
#import "WelcomeVC.h"
#import "pushnotification.h"

#import <Parse/Parse.h>

@interface DEMOMenuViewController () {
    NSArray *titles;
}

@end

@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    titles = @[@"New Game", @"Practice", @"Profile", @"My Stats", @"Send Game Invitations", @"Trading Card", @"Achievements", @"Info", @"Logout"]; // Leaderboard removed
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:167.0/255.0 green:166.0/255.0 blue:155.0/255.0 alpha:1];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 176, 141)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"logo_round.png"];
        imageView.layer.masksToBounds = YES;
        //imageView.layer.cornerRadius = 50.0;
        //imageView.layer.borderColor = [UIColor colorWithRed:115/255.0f green:153/255.0f blue:198/255.0f alpha:1.0f].CGColor;
        //imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        /*
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = @"Pickup Stats";
        label.font = [UIFont fontWithName:@"Agent Orange" size:20];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:115/255.0f green:153/255.0f blue:198/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        */
        
        [view addSubview:imageView];
        //[view addSubview:label];
        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    //cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:31.0/255.0 blue:112.0/255.0 alpha:1];
    cell.textLabel.font = [UIFont fontWithName:@"Heiti TC" size:20];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 0;
}

// control menu selection actions
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        NewGameViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewGameViewController"];
        navigationController.viewControllers = @[homeViewController];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        PracticeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PracticeViewController"];
        navigationController.viewControllers = @[homeViewController];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        ProfileVC *profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
        navigationController.viewControllers = @[profileViewController];
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        StatsHomeViewController *statsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StatsHome"];
        navigationController.viewControllers = @[statsViewController];
    } else if (indexPath.section == 0 && indexPath.row == 4)  {
        //[self performSegueWithIdentifier:@"TabBarVC" sender:self]; // didn't work
        UITabBarController *tabController = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
        tabController.selectedIndex = 0;
        //[[self navigationController] pushViewController:tabController animated:YES]; // didn't work
        navigationController.viewControllers = @[tabController];
        //UIViewController *profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactsVC"];
        //navigationController.viewControllers = @[profileViewController];
    } else if (indexPath.section == 0 && indexPath.row == 5)  {
        PlayerCardViewController *cardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"cardController"];
        navigationController.viewControllers = @[cardViewController];
    } else if (indexPath.section == 0 && indexPath.row == 7) {
        // was "indexPath.row == 8"
        AboutVC *aboutViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutVC"];
        navigationController.viewControllers = @[aboutViewController];
    } else if (indexPath.section == 0 && indexPath.row == 8) {
        // was "indexPath.row == 9"
        [PFUser logOut];
        ParsePushUserResign();
        PostNotification(NOTIFICATION_USER_LOGGED_OUT);
        
        // Open the Login VC again
        WelcomeVC *welcomeVC =[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeVC"];
        welcomeVC.navigationItem.hidesBackButton=YES;
        [self.navigationController pushViewController: welcomeVC animated:true];
    }
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// define number of rows per section - edited
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    //return 10;
    return [titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //NSArray *titles = @[@"New Game", @"Practice", @"Profile", @"My Stats", @"Send Game Invitations", @"Trading Card", @"Achievements", @"Leaderboards", @"Info", @"Logout"];
    cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}

@end
