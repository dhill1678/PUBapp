//
//  PUSCourt.h
//  PickUpStats
//
//  Created by Uzoma Orji on 8/26/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PUSCartesianPath;
@class PUSZone;

extern const int NBA;
extern const int FIBA;
extern const int NCAA;

const float WIDTH_HEIGHT_RATIO;
const float HEIGHT_HOOP_Y_CENTER_RATIO;
const float WIDTH_ZONE_LINE_THICKNESS_RATIO;
const float WIDTH_COURT_LINE_THICKNESS_RATIO;

float mStrokeWidth;

@protocol CourtDelegate <NSObject>
-(void) onZoneSelected:(PUSZone*)zone;
@end

@interface PUSCourt : UIView

@property(readonly) float scale;
@property(readonly) int style;
@property(readonly) CGPoint hoopCenter;
@property(readonly) float mHoopXCenter;
@property(readonly) float mHoopYCenter;

@property(assign) CGSize minimum_size;
@property(readonly) float baseline_offset;
@property(readonly) float half_width_offset;
@property(readonly) float half_length_offset;
@property(readonly) float level_1_radius;
@property(readonly) float level_2_radius;
@property(readonly) float level_3_radius;
@property(readonly) float baseline_three_offset;
@property(readonly) float level_1_baseline_angle;
@property(readonly) float level_2_baseline_angle;
@property(readonly) float zone_1_2_3_angle;
@property(readonly) float zone_2_3_6_angle;
@property(readonly) float zone_2_5_6_angle;
@property(readonly) float zone_5_6_10_angle;
@property(readonly) float zone_3_6_7_angle;
@property(readonly) float zone_6_7_11_angle;
@property(readonly) float zone_6_10_11_angle;
@property(readonly) float zone_10_sideline_angle;
@property(readonly) float zone_5_10_three_angle;
@property(readonly) float zone_7_11_12_angle;
@property(readonly) float zone_12_halfcourt_angle;

@property (nonatomic, weak) id<CourtDelegate> delegate;
@property(nonatomic, retain) NSArray *mZones;
@property(nonatomic, retain) PUSCartesianPath *mZoneLines;
@property(nonatomic, retain) PUSCartesianPath *mCourtLines;

-(void) setStyle:(int)style;

@end
