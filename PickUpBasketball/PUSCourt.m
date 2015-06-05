//
//  PUSCourt.m
//  PickUpStats
//
//  Created by Uzoma Orji on 8/26/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import "PUSCourt.h"
#import "PUSCartesianPath.h"
#import "PUSZone.h"

const int NBA = 0;
const int FIBA = 1;
const int NCAA = 2;

const float WIDTH_HEIGHT_RATIO = (float) 47/50;
const float HEIGHT_HOOP_Y_CENTER_RATIO = (float) 63/564;
const float WIDTH_ZONE_LINE_THICKNESS_RATIO = (float) 1/96;
const float WIDTH_COURT_LINE_THICKNESS_RATIO = (float) 1/64;

float mStrokeWidth = 0;
float mZoneLineWidth = 2.1;
float mCourtLineWidth = 3.2;

@implementation PUSCourt

@synthesize scale;
@synthesize style;
@synthesize hoopCenter;
@synthesize mHoopXCenter;
@synthesize mHoopYCenter;

@synthesize minimum_size;
@synthesize baseline_offset;
@synthesize half_width_offset;
@synthesize half_length_offset;
@synthesize level_1_radius;
@synthesize level_2_radius;
@synthesize level_3_radius;
@synthesize baseline_three_offset;
@synthesize level_1_baseline_angle;
@synthesize level_2_baseline_angle;
@synthesize zone_1_2_3_angle;
@synthesize zone_2_3_6_angle;
@synthesize zone_2_5_6_angle;
@synthesize zone_5_6_10_angle;
@synthesize zone_3_6_7_angle;
@synthesize zone_6_7_11_angle;
@synthesize zone_6_10_11_angle;
@synthesize zone_10_sideline_angle;
@synthesize zone_5_10_three_angle;
@synthesize zone_7_11_12_angle;
@synthesize zone_12_halfcourt_angle;

@synthesize delegate;
@synthesize mZones;
@synthesize mZoneLines;
@synthesize mCourtLines;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    UIImage *background_image = [[UIImage imageNamed:@"court_background.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    UIColor *background = [[UIColor alloc] initWithPatternImage:background_image];
    [self setBackgroundColor:background];
    
    minimum_size = CGSizeMake(100*WIDTH_HEIGHT_RATIO, 100);
    
    float w = MAX(minimum_size.width, self.frame.size.width);
    float h = MAX(minimum_size.height, self.frame.size.height);
    
    if (h < (w * WIDTH_HEIGHT_RATIO)) {
        w = h / WIDTH_HEIGHT_RATIO;
    } else {
        h = w * WIDTH_HEIGHT_RATIO;
    }
    
    style = NCAA;
    
    mStrokeWidth = 4;
    int strokeWidthScale = 8;
    float wView = w - strokeWidthScale/2 * mStrokeWidth;
    float hView = wView * WIDTH_HEIGHT_RATIO;
    
    mZoneLineWidth = hView * WIDTH_ZONE_LINE_THICKNESS_RATIO;
    mCourtLineWidth = hView * WIDTH_COURT_LINE_THICKNESS_RATIO;
    
    scale = (w - strokeWidthScale * mStrokeWidth) / 600;
    
    //CGRect mCourtBounds = CGRectMake(self.frame.origin.x, self.frame.origin.y, wView, hView); // doesn't work properly with autolayout for some reason9
    //CGRect mCourtBounds = CGRectMake(([UIScreen mainScreen].bounds.size.width - wView)/2, self.frame.origin.y, wView, hView); // this also doesn't work
    CGRect mCourtBounds = CGRectMake((background_image.size.width - wView)/2, (background_image.size.height - hView)/2, wView, hView);
    //NSLog(@"x = %f",self.frame.origin.x);
    //NSLog(@"x = %f",[UIScreen mainScreen].bounds.size.width);
    //NSLog(@"y = %f",self.frame.origin.y);
    //NSLog(@"width = %f",self.frame.size.width);
    //NSLog(@"height = %f",self.frame.size.height);
    
    mCourtBounds = CGRectOffset(mCourtBounds, (w - wView)/2, (h - hView)/2);
    
    mHoopXCenter = CGRectGetMidX(mCourtBounds)-mCourtBounds.origin.x/2 - 1;
    mHoopYCenter = (hView * HEIGHT_HOOP_Y_CENTER_RATIO) + (h - hView) - 1;
    hoopCenter = CGPointMake(mHoopXCenter, mHoopYCenter);
    
    [self setCourtDimensionsAndZones];
    
}

-(void) onZoneSelected:(PUSZone *)zone
{
    for (PUSZone *z in mZones) {
        [z setSelected:NOT_SELECTED];
    }
    [zone setSelected:IS_SELECTED];
    [self setNeedsDisplay];
    
    if ([[self delegate] respondsToSelector:NSSelectorFromString(@"onZoneSelected:")]) {
        [[self delegate] onZoneSelected:zone];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    for(PUSZone *zone in mZones) {
        if ([zone containsPoint:touchLocation]) {
            [self onZoneSelected:zone];
            break;
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    for (PUSZone *zone in mZones) {
        [zone fill];
    }
    
    [[UIColor clearColor] setFill];
    
    [[UIColor blackColor] setStroke];
    mZoneLines.lineWidth = mZoneLineWidth;
    [mZoneLines stroke];
    
    [[UIColor whiteColor] setStroke];
    mCourtLines.lineWidth = mCourtLineWidth;
    [mCourtLines stroke];
    
}

- (void) setStyle:(int)newStyle {
    style = newStyle;
    [self setCourtDimensionsAndZones];
}

- (void) setCourtDimensionsAndZones {
    baseline_offset = 63 * scale;
    half_width_offset = 50 * 12 / 2 * scale;
    half_length_offset = 94 * 12 / 2 * scale;
    
    switch (style)
    {
        case NBA:
			level_1_radius = 8 * 12 * scale; // 8ft;
			level_2_radius = 16 * 12 * scale; // 16ft;
			level_3_radius = (23 * 12 + 9) * scale; // 23'9"
			baseline_three_offset = (22 * 12) * scale; // 22'
            
			level_1_baseline_angle = 180 - (asin(baseline_offset / level_1_radius) * 180 / M_PI);
			level_2_baseline_angle = 180 - (asin(baseline_offset / level_2_radius) * 180 / M_PI);
            
			zone_1_2_3_angle = 240;
			zone_2_3_6_angle = 245;
            
			zone_2_5_6_angle = 215;
			zone_5_6_10_angle = 213;
            
			zone_3_6_7_angle = 249;
			zone_6_7_11_angle = 251;
            
			zone_10_sideline_angle = 199.7;
			zone_5_10_three_angle = 180 + (acos(baseline_three_offset / level_3_radius) * 180 / M_PI);
			zone_6_10_11_angle = zone_5_10_three_angle;
            
			zone_7_11_12_angle = 254;
			zone_12_halfcourt_angle = 285;
			break;
		case NCAA:
		default:
			level_1_radius = 7 * 12 * scale; // 7ft;
			level_2_radius = 14 * 12 * scale; // 14ft;
			level_3_radius = (20 * 12 + 9) * scale; // 20'9"
			baseline_three_offset = level_3_radius;
            
			level_1_baseline_angle = 180 - (asin(baseline_offset / level_1_radius) * 180 / M_PI);
			level_2_baseline_angle = 180 - (asin(baseline_offset / level_2_radius) * 180 / M_PI);
            
			zone_1_2_3_angle = 240;
			zone_2_3_6_angle = 245;
            
			zone_2_5_6_angle = 215;
			zone_5_6_10_angle = 213;
            
			zone_3_6_7_angle = 249;
			zone_6_7_11_angle = 251;
            
			zone_6_10_11_angle = 218;
			zone_10_sideline_angle = 215;
			zone_5_10_three_angle = 180;
            
			zone_7_11_12_angle = 254;
			zone_12_halfcourt_angle = 285;
			break;
    }
    
    // initialize Zones
    mZones = [PUSZone getZonesWithCourt:self];
    
    mZoneLines = [[PUSCartesianPath alloc] init];
    
    // zone 1 arc
    [mZoneLines addCartesianArcWithCenter:hoopCenter radius:level_1_radius startAngle:level_1_baseline_angle endAngle:540 - level_1_baseline_angle clockwise:NO];
    
    // zone 2 arc
    [mZoneLines moveToPoint:[PUSCartesianPath getArcEndPointWithCenter:hoopCenter radius:level_2_radius angle:level_2_baseline_angle]];
    [mZoneLines addCartesianArcWithCenter:hoopCenter radius:level_2_radius startAngle:level_2_baseline_angle endAngle:540 - level_2_baseline_angle clockwise:NO];
    
    
    float dataPoints[3][2][2] = { { { level_1_radius, zone_1_2_3_angle }, { level_2_radius, zone_2_3_6_angle } },
        { { level_2_radius, zone_2_5_6_angle }, { level_3_radius, zone_5_6_10_angle } },
        { { level_2_radius, zone_3_6_7_angle }, { level_3_radius, zone_6_7_11_angle } } };
    
    // straight lines between zones in the 2-pt region
    for(int k = 0; k < 3; k++) {
        CGPoint point = [PUSCartesianPath getArcEndPointWithCenter:hoopCenter radius:dataPoints[k][0][0] angle:dataPoints[k][0][1]];
        [mZoneLines moveToPoint:point];
        [mZoneLines lineToArcEndPointWithCenter:hoopCenter radius:dataPoints[k][1][0] angle:dataPoints[k][1][1]];
        
        point = [PUSCartesianPath getArcEndPointWithCenter:hoopCenter radius:dataPoints[k][0][0] angle:540-dataPoints[k][0][1]];
        [mZoneLines moveToPoint:point];
        [mZoneLines lineToArcEndPointWithCenter:hoopCenter radius:dataPoints[k][1][0] angle:540-dataPoints[k][1][1]];
    }
    
    
    // zone 12 straight lines
    for (int k = 0; k < 2; k++) {
        float level_3_angle = (k == 0) ? zone_7_11_12_angle : 540 - zone_7_11_12_angle;
        float border_angle = (k == 0) ? 540 - zone_12_halfcourt_angle : zone_12_halfcourt_angle;
        
        CGPoint point = [PUSCartesianPath getArcEndPointWithCenter:hoopCenter radius:level_3_radius angle:level_3_angle];
        [mZoneLines moveToPoint:point];
        [mZoneLines lineToBorderPointWithCenter:hoopCenter angle:zone_7_11_12_angle borderEnd:ENDY borderValue:mHoopYCenter-baseline_offset+half_length_offset borderAngle:border_angle];
    }
    
    // sideline three point lines
    for (int k = 0; k < 2; k++) {
        float level_3_angle = (k == 0) ? zone_6_10_11_angle : 540 - zone_6_10_11_angle;
        float sideline_angle = (k == 0) ? zone_10_sideline_angle : 540 - zone_10_sideline_angle;
        float sideline_value = (k == 0) ? mHoopXCenter - half_width_offset : mHoopXCenter + half_width_offset;
        
        CGPoint point = [PUSCartesianPath getArcEndPointWithCenter:hoopCenter radius:level_3_radius angle:level_3_angle];
        [mZoneLines moveToPoint:point];
        [mZoneLines lineToBorderPointWithCenter:hoopCenter angle:level_3_angle borderEnd:ENDX borderValue:sideline_value borderAngle:sideline_angle];
    }
    
    mCourtLines = [[PUSCartesianPath alloc] init];
    
    // outer court lines
    [mCourtLines moveToPoint:CGPointMake(mHoopXCenter - half_width_offset + mStrokeWidth / 2,
                                         mHoopYCenter - baseline_offset - mStrokeWidth / 2)];
    [mCourtLines rLineToWithdx:0 dy:(half_length_offset + mStrokeWidth / 2)];
    [mCourtLines rLineToWithdx:(2 * (half_width_offset - mStrokeWidth / 2)) dy:0];
    [mCourtLines rLineToWithdx:0 dy:-(half_length_offset + mStrokeWidth / 2)];
    [mCourtLines rLineToWithdx:-(2 * (half_width_offset - mStrokeWidth / 2)) - mStrokeWidth / 2 dy:0];
    
    // free throw tick marks
    for (int k = 0; k < 2; k++) {
        float offset = 7 * 12 * scale;
        float len = 2 * 12 * scale;
        int dir = (k == 0) ? 1 : -1;
        float offsets[5] = { 0, 1 * 12 * scale, 3 * 12 * scale, 3 * 12 * scale, 3 * 12 * scale };
        
        for (int n = 0; n < 5; n++) {
            offset += offsets[n];
            [mCourtLines moveToPoint:CGPointMake(mHoopXCenter + dir * ((8 * 12 - mStrokeWidth) * scale), mHoopYCenter - baseline_offset + offset)];
            [mCourtLines rLineToWithdx:(dir * len) dy:0];
        }
    }
    
    // sideline tick marks
    [mCourtLines moveToPoint:CGPointMake(mHoopXCenter - half_width_offset, mHoopYCenter - baseline_offset + 28 * 12 * scale)];
    [mCourtLines rLineToWithdx:(3 * 12 * scale) dy:0];
    
    [mCourtLines moveToPoint:CGPointMake(mHoopXCenter + half_width_offset, mHoopYCenter - baseline_offset + 28 * 12 * scale)];
    [mCourtLines rLineToWithdx:-(3 * 12 * scale) dy:0];
    
    // outer free throw rectangle
    [mCourtLines moveToPoint:CGPointMake(mHoopXCenter - ((8 * 12) - mStrokeWidth) * scale, mHoopYCenter - baseline_offset)];
    [mCourtLines rLineToWithdx:0 dy:((19 * 12) - mStrokeWidth) * scale];
    [mCourtLines rLineToWithdx:((16 * 12) - 2 * mStrokeWidth) * scale dy:0];
    [mCourtLines rLineToWithdx:0 dy:-((19 * 12) - mStrokeWidth) * scale];
    
    // inner free throw rectangle
    [mCourtLines moveToPoint:CGPointMake(mHoopXCenter - ((6 * 12) - mStrokeWidth / 2) * scale, mHoopYCenter - baseline_offset)];
    [mCourtLines rLineToWithdx:0 dy:((19 * 12) - mStrokeWidth) * scale];
    [mCourtLines rLineToWithdx:(((12 * 12) - mStrokeWidth) * scale) dy:0];
    [mCourtLines rLineToWithdx:0 dy:-((19 * 12) - mStrokeWidth) * scale];
    
    // hoop and backboard
    [mCourtLines moveToPoint:[PUSCartesianPath getArcEndPointWithCenter:hoopCenter radius:18*scale angle:0]];
    [mCourtLines addCartesianArcWithCenter:hoopCenter radius:18*scale startAngle:0 endAngle:360 clockwise:NO];
    [mCourtLines moveToPoint:CGPointMake(mHoopXCenter - 36 * scale, mHoopYCenter - 18 * scale - mStrokeWidth / 2)];
    [mCourtLines rLineToWithdx:72 * scale dy:0];
    
    // free throw circle
    [mCourtLines moveToPoint:[PUSCartesianPath getArcEndPointWithCenter:CGPointMake(mHoopXCenter, mHoopYCenter-baseline_offset + (19 * 12 - mStrokeWidth / 2) * scale) radius:6 * 12 * scale - mStrokeWidth / 2 angle:0]];
    [mCourtLines addCartesianArcWithCenter:CGPointMake(mHoopXCenter, mHoopYCenter-baseline_offset + (19 * 12 - mStrokeWidth / 2) * scale) radius:6 * 12 * scale - mStrokeWidth / 2 startAngle:0 endAngle:360 clockwise:NO];
    
    // halfcourt inner semi-circle
    [mCourtLines moveToPoint:[PUSCartesianPath getArcEndPointWithCenter:CGPointMake(mHoopXCenter, mHoopYCenter - baseline_offset + half_length_offset) radius:(2 * 12 + mStrokeWidth) * scale angle:0]];
    [mCourtLines addCartesianArcWithCenter:CGPointMake(mHoopXCenter, mHoopYCenter - baseline_offset + half_length_offset) radius:(2 * 12 + mStrokeWidth) * scale startAngle:0 endAngle:180 clockwise:NO];
    
    // halfcourt outer semi-circle
    [mCourtLines addCartesianArcWithCenter:CGPointMake(mHoopXCenter, mHoopYCenter - baseline_offset + half_length_offset) radius:(6 * 12 + mStrokeWidth) * scale startAngle:0 endAngle:180 clockwise:NO];
    
    // three point line
    CGPoint point = [PUSCartesianPath getArcEndPointWithCenter:hoopCenter radius:level_3_radius angle:zone_5_10_three_angle];
    [mCourtLines moveToPoint:CGPointMake(mHoopXCenter-baseline_three_offset, mHoopYCenter-baseline_offset)];
    [mCourtLines addLineToPoint:point];
    [mCourtLines addCartesianArcWithCenter:hoopCenter radius:level_3_radius startAngle:zone_5_10_three_angle endAngle:540-zone_5_10_three_angle clockwise:NO];
    [mCourtLines addLineToPoint:CGPointMake(mHoopXCenter+baseline_three_offset, mHoopYCenter-baseline_offset)];
    
    [self setNeedsDisplay];
}

@end
