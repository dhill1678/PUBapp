//
//  PUSZone.h
//  PickUpStats
//
//  Created by Uzoma Orji on 8/26/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class PUSCourt;
@class PUSCartesianPath;

extern const int DEFAULT_SELECTED;
extern const int IS_SELECTED;
extern const int NOT_SELECTED;

@interface PUSZone : NSObject

@property(nonatomic, retain, readonly) PUSCourt *mCourt;
@property(nonatomic, retain, readonly) PUSCartesianPath *mPath;
@property(nonatomic, retain, readonly) UIColor *mColor;
@property(readonly) int mZoneNumber;
@property(readonly) int mSelected;
@property(readonly) int mFGM;
@property(readonly) int mFGA;

+(NSArray *) getZonesWithCourt:(PUSCourt *)court;

-(PUSZone *) initWithCourt:(PUSCourt *)court zoneNumber:(int)zoneNumber;

-(void) fill;

-(void) setSelected:(int)selection;

-(BOOL) hasStats;

-(BOOL) setStatsWithfgm:(int)fgm fga:(int)fga;

-(CGFloat) getFieldGoalPercentage;

-(BOOL) containsPoint:(CGPoint)point;

-(void) setPath;

@end
