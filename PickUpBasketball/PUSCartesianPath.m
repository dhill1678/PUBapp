//
//  PUSCartesianPath.m
//  PickUpStats
//
//  Created by Uzoma Orji on 8/26/14.
//  Copyright (c) 2014 AppMuumba. All rights reserved.
//

#import "PUSCartesianPath.h"

int const ENDX = 0;
int const ENDY = 1;

@implementation PUSCartesianPath

+ (PUSCartesianPath *)fromArcsWithCenter:(CGPoint)center innerRadius:(CGFloat)innerRadius innerStartAngle:(CGFloat)innerStartAngle innerEndAngle:(CGFloat)innerEndAngle outerRadius:(CGFloat)outerRadius outerStartAngle:(CGFloat)outerStartAngle outerEndAngle:(CGFloat)outerEndAngle {
    CGPoint innerStartPoint = [self getArcEndPointWithCenter:center radius:innerRadius angle:innerStartAngle];
    CGPoint outerEndPoint = [self getArcEndPointWithCenter:center radius:outerRadius angle:outerEndAngle];
    
    PUSCartesianPath *path = [[PUSCartesianPath alloc] init];
    path.usesEvenOddFillRule = YES;
    [path removeAllPoints];
    [path addCartesianArcWithCenter:center radius:outerRadius startAngle:outerEndAngle endAngle:outerStartAngle clockwise:YES];
    [path addLineToPoint:innerStartPoint];
    [path addCartesianArcWithCenter:center radius:innerRadius startAngle:innerStartAngle endAngle:innerEndAngle clockwise:NO];
    [path addLineToPoint:outerEndPoint];
    [path closePath];
    
    return path;
}

+ (CGPoint)getArcEndPointWithCenter:(CGPoint)center radius:(CGFloat)radius angle:(CGFloat)angle {
    return CGPointMake(center.x + (cosf(angle*M_PI/180)*radius), center.y - (sinf(angle*M_PI/180)*radius));
}

+ (CGPoint)getBorderEndPointWithCenter:(CGPoint)center angle:(CGFloat)angle borderEnd:(int)borderEnd borderValue:(CGFloat)borderValue borderAngle:(CGFloat)borderAngle {
    CGFloat slope = sinf(borderAngle * M_PI/180)/cosf(borderAngle*M_PI/180);
    
    if (borderEnd == ENDX) {
        return CGPointMake(borderValue, center.y-slope*(borderValue - center.x));
    } else {
        return CGPointMake((center.y - borderValue)/slope + center.x, borderValue);
    }
}

- (void)addCartesianArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise {
    [self addArcWithCenter:center radius:radius startAngle:(360-startAngle)*M_PI/180 endAngle:(360-endAngle)*M_PI/180 clockwise:clockwise];
}

- (void)rLineToWithdx:(CGFloat)dx dy:(CGFloat)dy {
    [self addLineToPoint:CGPointMake(self.currentPoint.x + dx, self.currentPoint.y + dy)];
}

- (void)lineToArcEndPointWithCenter:(CGPoint)center radius:(CGFloat)radius angle:(CGFloat)angle {
    [self addLineToPoint:[PUSCartesianPath getArcEndPointWithCenter:center radius:radius angle:angle]];
}

- (void)lineToBorderPointWithCenter:(CGPoint)center angle:(CGFloat)angle borderEnd:(int)borderEnd borderValue:(CGFloat)borderValue borderAngle:(CGFloat)borderAngle {
    [self addLineToPoint:[PUSCartesianPath getBorderEndPointWithCenter:center angle:angle borderEnd:borderEnd borderValue:borderValue borderAngle:borderAngle]];
}

@end
