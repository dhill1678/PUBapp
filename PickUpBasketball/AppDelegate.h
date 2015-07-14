//
//  AppDelegate.h
//  PickUpBasketball
//
//  Created by DAVID HILL on 3/8/15.
//  Copyright (c) 2015 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatsVC.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ChatsVC *messages;
@property (nonatomic,retain) NSMutableArray *yChartLableArray;

@end

