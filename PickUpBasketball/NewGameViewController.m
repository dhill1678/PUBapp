//
//  ViewController.m
//  HTHorizontalSelectionList Example
//
//  Created by Erik Ackermann on 9/14/14.
//  Copyright (c) 2014 Hightower. All rights reserved.
//

#import "NewGameViewController.h"
#import "HTHorizontalSelectionList.h"
#import "PickUpViewController.h"
#import "SeasonViewController.h"

@interface NewGameViewController () <HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource>

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSArray *gameTypes;

//@property (nonatomic, strong) UILabel *selectedItemLabel;

@end

@implementation NewGameViewController

/*
@synthesize scrollView;
@synthesize statTest, step;
*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //round corners on buttons
    CALayer *btnLayer104 = [_startButton layer];
    [btnLayer104 setMasksToBounds:YES];
    [btnLayer104 setCornerRadius:10.0f];
    
    // For switch
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HELPME"]) {
        _helpSwitch.on = NO;
        helpON = NO;
    } else {
        _helpSwitch.on = YES;
        helpON = YES;
    }
    
    
    //self.title = @"Example App";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 70, 0, 140, 40)];
    self.selectionList.delegate = self;
    self.selectionList.dataSource = self;
    
    self.gameTypes = @[@"Pickup",
                      @"Season"];
    
    [self.view addSubview:self.selectionList];
    
    /*
    self.selectedItemLabel = [[UILabel alloc] init];
    self.selectedItemLabel.text = self.gameTypes[self.selectionList.selectedButtonIndex];
    self.selectedItemLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.selectedItemLabel];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedItemLabel
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedItemLabel
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
     */
    
    _gameLabel.text = [NSString stringWithFormat:@"%@ Game",self.gameTypes[self.selectionList.selectedButtonIndex]];
    
    if ([@"Pickup" isEqualToString:self.gameTypes[self.selectionList.selectedButtonIndex]]) {
        _gameDescriptionLabel.text = [NSString stringWithFormat:@"It's a Point Race!    UNTIMED"];
    } else {
        _gameDescriptionLabel.text = [NSString stringWithFormat:@"Race Against the Clock! TIMED"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.gameTypes.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.gameTypes[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    Select = index;
    
    // update the view for the corresponding index
    //self.selectedItemLabel.text = self.gameTypes[index];
    _gameLabel.text = [NSString stringWithFormat:@"%@ Game",self.gameTypes[index]];
    
    if ([@"Pickup" isEqualToString:self.gameTypes[index]]) {
        _gameDescriptionLabel.text = [NSString stringWithFormat:@"It's a Point Race!    UNTIMED"];
    } else {
        _gameDescriptionLabel.text = [NSString stringWithFormat:@"Race Against the Clock! TIMED"];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"pickup"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:helpON forKey:@"HELPME"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // Get reference to the destination view controller
        PickUpViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.HELP = helpON ? @"YES" : @"NO";
        //[vc setMyObjectHere:_practiceLabel.text];
    } else if ([[segue identifier] isEqualToString:@"season"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:helpON forKey:@"HELPME"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // Get reference to the destination view controller
        SeasonViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.HELP = helpON ? @"YES" : @"NO";
        //[vc setMyObjectHere:_practiceLabel.text];
    }
}

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)startGame:(id)sender {
    if ([@"Pickup" isEqualToString:self.gameTypes[Select]]) {
        [self performSegueWithIdentifier:@"pickup" sender:self];
    } else {
        [self performSegueWithIdentifier:@"season" sender:self];
    }
}

- (IBAction)instructions:(id)sender {
    [self performSegueWithIdentifier:@"showInstructions" sender:self];
}

- (IBAction)switchAction:(id)sender {
    if (_helpSwitch.on) {
        helpON = YES;
    } else {
        helpON = NO;
    }
    
    NSLog(@"%hhd",helpON);
    NSLog(@"%@",helpON ? @"YES" : @"NO");
}


/////////////////
// Ad Handling //
/////////////////

#pragma mark - iAD Delegate Methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}


@end
