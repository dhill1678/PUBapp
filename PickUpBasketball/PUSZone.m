//
//  PUSZone.m
//  PickUpStats
//
//  Created by Uzoma Orji on 8/26/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import "PUSZone.h"
#import "PUSCourt.h"
#import "PUSCartesianPath.h"

const int DEFAULT_SELECTED = 0;
const int IS_SELECTED = 1;
const int NOT_SELECTED = 2;

@implementation PUSZone

@synthesize mCourt;
@synthesize mPath;
@synthesize mColor;
@synthesize mZoneNumber;
@synthesize mSelected;
@synthesize mFGM;
@synthesize mFGA;

+(NSArray *) getZonesWithCourt:(PUSCourt *)court {
    NSMutableArray *zones = [[NSMutableArray alloc] init];
    for (int k = 1; k <= 14; k++) {
        [zones addObject:[[PUSZone alloc] initWithCourt:court zoneNumber:k]];
    }
    return zones;
}

-(PUSZone *) initWithCourt:(PUSCourt *)court zoneNumber:(int)zoneNumber {
    self = [self init];
    mCourt = court;
    mPath = [[PUSCartesianPath alloc] init];
    mZoneNumber = zoneNumber;
    mSelected = DEFAULT_SELECTED;
    [self setPath];
    [self setColor];
    return self;
}

-(void) setColor {
    if (mSelected == NOT_SELECTED) {
        if ([self hasStats]) {
            mColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
        } else {
            mColor = [UIColor clearColor];
        }
    } else if (mSelected == IS_SELECTED) {
        mColor = [UIColor yellowColor];
    } else {
        if ([self hasStats]) {
            mColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        } else {
           mColor = [UIColor clearColor];
        }
    }
}

-(void) fill {
    [mColor setFill];
    [mColor setStroke];
    [mPath fill];
}

-(void) setSelected:(int)selection {
    mSelected = selection;
    [self setColor];
}
    
-(BOOL) hasStats {
    return ((mFGA > 0) && (mFGM >= 0));
}
    
-(BOOL) setStatsWithfgm:(int)fgm fga:(int)fga{
    if ((fga > 0) && (fgm >= 0)) {
        mFGA = fga;
        mFGM = fgm;
        [self setColor];
        return true;
    }
    [self setColor];
    return false;
}
    
-(CGFloat) getFieldGoalPercentage {
    if ([self hasStats]) {
        return (CGFloat) mFGM/mFGA;
    } else {
        return -1;
    }
}

-(BOOL) containsPoint:(CGPoint)point {
    return [mPath containsPoint:point];
}

-(void) setPath {
    [mPath removeAllPoints];
        
    switch (mZoneNumber) {
        case 1:
            [mPath addCartesianArcWithCenter:mCourt.hoopCenter radius:mCourt.level_1_radius startAngle:mCourt.level_1_baseline_angle endAngle:540-mCourt.level_1_baseline_angle clockwise:NO];
            [mPath closePath];
            break;
        case 2:
            mPath = [PUSCartesianPath fromArcsWithCenter:mCourt.hoopCenter innerRadius:mCourt.level_1_radius innerStartAngle:mCourt.level_1_baseline_angle innerEndAngle:mCourt.zone_1_2_3_angle outerRadius:mCourt.level_2_radius outerStartAngle:mCourt.level_2_baseline_angle outerEndAngle:mCourt.zone_2_3_6_angle];
             
            break;
        case 3:
            mPath = [PUSCartesianPath fromArcsWithCenter:mCourt.hoopCenter innerRadius:mCourt.level_1_radius innerStartAngle:mCourt.zone_1_2_3_angle innerEndAngle:(540 - mCourt.zone_1_2_3_angle) outerRadius:mCourt.level_2_radius outerStartAngle:mCourt.zone_2_3_6_angle outerEndAngle:(540 -mCourt.zone_2_3_6_angle)];
            
            break;
        case 4:
            mPath = [PUSCartesianPath fromArcsWithCenter:mCourt.hoopCenter innerRadius:mCourt.level_1_radius innerStartAngle:540-mCourt.zone_1_2_3_angle innerEndAngle:(540 - mCourt.level_1_baseline_angle) outerRadius:mCourt.level_2_radius outerStartAngle:540-mCourt.zone_2_3_6_angle outerEndAngle:(540 -mCourt.level_2_baseline_angle)];
            
            break;
        case 5:
            [mPath addCartesianArcWithCenter:mCourt.hoopCenter radius:mCourt.level_2_radius startAngle:mCourt.zone_2_5_6_angle endAngle:mCourt.level_2_baseline_angle clockwise:YES];
            [mPath addLineToPoint:CGPointMake(mCourt.mHoopXCenter - mCourt.baseline_three_offset, mCourt.mHoopYCenter - mCourt.baseline_offset)];
            [mPath lineToArcEndPointWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius angle:mCourt.zone_5_10_three_angle];
            [mPath addCartesianArcWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius startAngle:mCourt.zone_5_10_three_angle endAngle:mCourt.zone_5_6_10_angle clockwise:NO];
            [mPath lineToArcEndPointWithCenter:mCourt.hoopCenter radius:mCourt.level_2_radius angle:mCourt.zone_2_5_6_angle];
            [mPath closePath];
            break;
        case 6:
            mPath = [PUSCartesianPath fromArcsWithCenter:mCourt.hoopCenter innerRadius:mCourt.level_2_radius innerStartAngle:mCourt.zone_2_5_6_angle innerEndAngle:mCourt.zone_3_6_7_angle outerRadius:mCourt.level_3_radius outerStartAngle:mCourt.zone_5_6_10_angle outerEndAngle:mCourt.zone_6_7_11_angle];
            break;
        case 7:
            mPath = [PUSCartesianPath fromArcsWithCenter:mCourt.hoopCenter innerRadius:mCourt.level_2_radius innerStartAngle:mCourt.zone_3_6_7_angle innerEndAngle:540-mCourt.zone_3_6_7_angle outerRadius:mCourt.level_3_radius outerStartAngle:mCourt.zone_6_7_11_angle outerEndAngle:540-mCourt.zone_6_7_11_angle];
            break;
        case 8:
            mPath = [PUSCartesianPath fromArcsWithCenter:mCourt.hoopCenter innerRadius:mCourt.level_2_radius innerStartAngle:540-mCourt.zone_3_6_7_angle innerEndAngle:540-mCourt.zone_2_5_6_angle outerRadius:mCourt.level_3_radius outerStartAngle:540-mCourt.zone_6_7_11_angle outerEndAngle:540-mCourt.zone_5_6_10_angle];
            break;
        case 9:
            [mPath addCartesianArcWithCenter:mCourt.hoopCenter radius:mCourt.level_2_radius startAngle:540 - mCourt.zone_2_5_6_angle endAngle:540 - mCourt.level_2_baseline_angle clockwise:NO];
            [mPath addLineToPoint:CGPointMake(mCourt.mHoopXCenter + mCourt.baseline_three_offset, mCourt.mHoopYCenter - mCourt.baseline_offset)];
            [mPath lineToArcEndPointWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius angle:540 - mCourt.zone_5_10_three_angle];
            [mPath addCartesianArcWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius startAngle:540 - mCourt.zone_5_10_three_angle endAngle:540 - mCourt.zone_5_6_10_angle clockwise:YES];
            [mPath lineToArcEndPointWithCenter:mCourt.hoopCenter radius:mCourt.level_2_radius angle:540 - mCourt.zone_2_5_6_angle];
            [mPath closePath];
            break;
        case 10:
            [mPath moveToPoint:CGPointMake(mCourt.mHoopXCenter - mCourt.baseline_three_offset, mCourt.mHoopYCenter - mCourt.baseline_offset)];
            [mPath lineToArcEndPointWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius angle:mCourt.zone_5_10_three_angle];
            [mPath addCartesianArcWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius startAngle:mCourt.zone_5_10_three_angle endAngle:mCourt.zone_6_10_11_angle clockwise:NO];
            [mPath lineToBorderPointWithCenter:mCourt.hoopCenter angle:mCourt.zone_6_10_11_angle borderEnd:ENDX borderValue:mCourt.mHoopXCenter - mCourt.half_width_offset borderAngle:mCourt.zone_10_sideline_angle];
            [mPath addLineToPoint:CGPointMake(mCourt.mHoopXCenter - mCourt.half_width_offset, mCourt.mHoopYCenter - mCourt.baseline_offset)];
            [mPath rLineToWithdx:mCourt.half_width_offset- mCourt.baseline_three_offset dy:0];
            [mPath closePath];
            break;
        case 11:
            [mPath addCartesianArcWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius startAngle:mCourt.zone_6_10_11_angle endAngle:mCourt.zone_7_11_12_angle clockwise:NO];
            [mPath lineToBorderPointWithCenter:mCourt.hoopCenter angle:mCourt.zone_7_11_12_angle borderEnd:ENDY borderValue:mCourt.mHoopYCenter - mCourt.baseline_offset + mCourt.half_length_offset borderAngle:540 - mCourt.zone_12_halfcourt_angle];
            [mPath addLineToPoint:CGPointMake(mCourt.mHoopXCenter - mCourt.half_width_offset, mCourt.mHoopYCenter - mCourt.baseline_offset + mCourt.half_length_offset)];
            [mPath lineToBorderPointWithCenter:mCourt.hoopCenter angle:mCourt.zone_6_10_11_angle borderEnd:ENDX borderValue:mCourt.mHoopXCenter - mCourt.half_width_offset borderAngle:mCourt.zone_10_sideline_angle];
            [mPath closePath];
            break;
        case 12:
            [mPath addCartesianArcWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius startAngle:mCourt.zone_7_11_12_angle endAngle:540 - mCourt.zone_7_11_12_angle clockwise:NO];
            [mPath lineToBorderPointWithCenter:mCourt.hoopCenter angle:mCourt.zone_7_11_12_angle borderEnd:ENDY borderValue:mCourt.mHoopYCenter - mCourt.baseline_offset + mCourt.half_length_offset borderAngle:mCourt.zone_12_halfcourt_angle];
            [mPath lineToBorderPointWithCenter:mCourt.hoopCenter angle:mCourt.zone_7_11_12_angle borderEnd:ENDY borderValue:mCourt.mHoopYCenter - mCourt.baseline_offset + mCourt.half_length_offset borderAngle:540 - mCourt.zone_12_halfcourt_angle];
            [mPath lineToArcEndPointWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius angle:mCourt.zone_7_11_12_angle];
            [mPath closePath];
            break;
        case 13:
            [mPath addCartesianArcWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius startAngle:540 - mCourt.zone_6_10_11_angle endAngle:540 - mCourt.zone_7_11_12_angle clockwise:YES];
            [mPath lineToBorderPointWithCenter:mCourt.hoopCenter angle:540-mCourt.zone_7_11_12_angle borderEnd:ENDY borderValue:mCourt.mHoopYCenter - mCourt.baseline_offset + mCourt.half_length_offset borderAngle:mCourt.zone_12_halfcourt_angle];
            [mPath addLineToPoint:CGPointMake(mCourt.mHoopXCenter + mCourt.half_width_offset, mCourt.mHoopYCenter - mCourt.baseline_offset + mCourt.half_length_offset)];
            [mPath lineToBorderPointWithCenter:mCourt.hoopCenter angle:540 - mCourt.zone_6_10_11_angle borderEnd:ENDX borderValue:mCourt.mHoopXCenter + mCourt.half_width_offset borderAngle:540 - mCourt.zone_10_sideline_angle];
            [mPath closePath];
            break;
        case 14:
            [mPath moveToPoint:CGPointMake(mCourt.mHoopXCenter + mCourt.baseline_three_offset, mCourt.mHoopYCenter - mCourt.baseline_offset)];
            [mPath lineToArcEndPointWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius angle:540 - mCourt.zone_5_10_three_angle];
            [mPath addCartesianArcWithCenter:mCourt.hoopCenter radius:mCourt.level_3_radius startAngle:540 - mCourt.zone_5_10_three_angle endAngle:540 - mCourt.zone_6_10_11_angle clockwise:YES];
            [mPath lineToBorderPointWithCenter:mCourt.hoopCenter angle:540 - mCourt.zone_6_10_11_angle borderEnd:ENDX borderValue:mCourt.mHoopXCenter + mCourt.half_width_offset borderAngle:540 - mCourt.zone_10_sideline_angle];
            [mPath addLineToPoint:CGPointMake(mCourt.mHoopXCenter + mCourt.half_width_offset, mCourt.mHoopYCenter - mCourt.baseline_offset)];
            [mPath rLineToWithdx:-(mCourt.half_width_offset- mCourt.baseline_three_offset) dy:0];
            [mPath closePath];
            break;
        default:
            break;
    }
}

@end
