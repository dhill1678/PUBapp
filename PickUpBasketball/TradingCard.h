//
//  TradingCard.h
//  PickUpStats
//
//  Created by DAVID HILL on 7/10/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradingCard : UIViewController {
    
    IBOutlet UIImageView *CardPhoto;
    UIImage *image;
}

- (IBAction)ShareButton:(id)sender;
- (UIImage*)loadImage;

@property (strong, nonatomic) NSString *Nickname;

@property (strong, nonatomic) IBOutlet UIImageView *Emblem1;
@property (strong, nonatomic) IBOutlet UIImageView *Emblem2;
@property (strong, nonatomic) IBOutlet UIImageView *Emblem3;

@property (strong, nonatomic) IBOutlet UILabel *NicknameLabel;
@property (strong, nonatomic) IBOutlet UILabel *BallerStatusLabel;

@end
