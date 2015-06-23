//
//  PUSCartesianPath.h
//  PickUpStats
//
//  Created by Uzoma Orji on 8/26/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import <UIKit/UIKit.h>

extern int const ENDX;
extern int const ENDY;

@interface PUSCartesianPath : UIBezierPath

+ (PUSCartesianPath *)fromArcsWithCenter:(CGPoint)center innerRadius:(CGFloat)innerRadius innerStartAngle:(CGFloat)innerStartAngle innerEndAngle:(CGFloat)innerEndAngle outerRadius:(CGFloat)outerRadius outerStartAngle:(CGFloat)outerStartAngle outerEndAngle:(CGFloat)outerEndAngle;

+ (CGPoint)getArcEndPointWithCenter:(CGPoint)center radius:(CGFloat)radius angle:(CGFloat)angle;

+ (CGPoint)getBorderEndPointWithCenter:(CGPoint)center angle:(CGFloat)angle borderEnd:(int)borderEnd borderValue:(CGFloat)borderValue borderAngle:(CGFloat)borderAngle;

- (void)addCartesianArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;

- (void)rLineToWithdx:(CGFloat)dx dy:(CGFloat)dy;

- (void)lineToArcEndPointWithCenter:(CGPoint)center radius:(CGFloat)radius angle:(CGFloat)angle;

- (void)lineToBorderPointWithCenter:(CGPoint)center angle:(CGFloat)angle borderEnd:(int)borderEnd borderValue:(CGFloat)borderValue borderAngle:(CGFloat)borderAngle;

@end
