//
//  Line.m
//  Assignment2Template
//
//  Created by Nirav Agrawal on 2/16/16.
//  Copyright © 2016 CMPE161. All rights reserved.
//

#import "Line.h"

@implementation Line

#pragma mark - Init methods
//Standard init method. Sets circle center to (0,0) and size to 50
-(id)init {
    self = [super init];
    
    if (self) {
        _lineStartPoint.x = 0.0f;
        _lineStartPoint.y = 0.0f;
        _lineEndPoint.x = 0.0f;
        _lineEndPoint.y = 0.0f;
    }
    return self;
}

//Initialize a Circle object given a center point
-(id)initWithCGPoints : (CGPoint) point : (CGPoint) pointTwo{
    
    self = [super init];
    
    if (self) {
        _lineStartPoint.x = point.x;
        _lineStartPoint.y = point.y;
        _lineEndPoint.x = pointTwo.x;
        _lineEndPoint.y = pointTwo.y;
    }
    return self;
}

#pragma mark - Draw circle
//Draw a circle in the specified location
-(void)drawLine:(CGContextRef) context : (CGPoint) mappingConstant {
    
    CGPoint newPoint;
    CGPoint endPoint;
    
    newPoint.x = _lineStartPoint.x*mappingConstant.x;
    newPoint.y = _lineStartPoint.y*mappingConstant.y;
    
    endPoint.x = _lineEndPoint.x*mappingConstant.x;
    endPoint.y = _lineEndPoint.y*mappingConstant.y;
    
    //You need to invert the coordinates due to the layout of the context
    //                         x-origin,    y-origin, width, height
//    //CGRect line = CGRectMake(newPoint.y, newPoint.x, _circleSize, _circleSize);
//    CGContextSetRGBStrokeColor(context, self.red, self.green, self.blue, self.alpha);
//    CGContextSetRGBFillColor(context, self.red, self.green, self.blue, self.alpha);
//    CGContextSetLineWidth(context, 0.5);
//    //CGContextFillEllipseInRect (context, line);
    
    CGContextSetLineWidth(context, 6.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, newPoint.y, newPoint.x);
    CGContextAddLineToPoint(context, endPoint.y, endPoint.x);
    CGContextStrokePath(context);
    
}

@end
