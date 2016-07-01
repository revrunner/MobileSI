//
//  Square.m
//  Assignment2Template
//
//  Created by Nirav Agrawal on 2/16/16.
//  Copyright © 2016 CMPE161. All rights reserved.
//

#import "Square.h"
#import <math.h>

@implementation Square

#pragma mark - Init methods
//Standard init method.
-(id)init {
    self = [super init];
    
    if (self) {
        _squareSideLength = 75.0f;
        _squareOne.x = 375.0/2.0 - (_squareSideLength/2);
        _squareOne.y = 667.0/2.0 - (_squareSideLength/2);
        
        _squareTwo.x = 375.0/2.0 + (_squareSideLength/2);
        _squareTwo.y = 667.0/2.0 - (_squareSideLength/2);
        
        _squareThree.x = 375.0/2.0 + (_squareSideLength/2);
        _squareThree.y = 667.0/2.0 + (_squareSideLength/2);
        
        _squareFour.x = 375.0/2.0 - (_squareSideLength/2);
        _squareFour.y = 667.0/2.0 + (_squareSideLength/2);
    }
    return self;
}

//Initialize a Square object given a center point
-(id)initWithCGPoint : (CGPoint) point {
    
    self = [super init];
    
    if (self) {
        _squareSideLength = 75.0f;
        _squareOne.x = point.x - (_squareSideLength/2);
        _squareOne.y = point.y - (_squareSideLength/2);
        
        _squareTwo.x = point.x + (_squareSideLength/2);
        _squareTwo.y = point.y - (_squareSideLength/2);
        
        _squareThree.x = point.x + (_squareSideLength/2);
        _squareThree.y = point.y + (_squareSideLength/2);
        
        _squareFour.x = point.x - (_squareSideLength/2);
        _squareFour.y = point.y + (_squareSideLength/2);
    }
    return self;
}

#pragma mark - Draw square
//Draw a square in the specified location
-(void)drawSquare:(CGContextRef) context : (CGPoint) mappingConstant {
    
    CGPoint pointOne;
    CGPoint pointTwo;
    CGPoint pointThree;
    CGPoint pointFour;
    
    pointOne.x = _squareOne.x * mappingConstant.x;
    pointOne.y = _squareOne.y * mappingConstant.y;
    
    pointTwo.x = _squareTwo.x * mappingConstant.x;
    pointTwo.y = _squareTwo.y * mappingConstant.y;
    
    pointThree.x = _squareThree.x * mappingConstant.x;
    pointThree.y = _squareThree.y * mappingConstant.y;
    
    pointFour.x = _squareFour.x * mappingConstant.x;
    pointFour.y = _squareFour.y * mappingConstant.y;
    
    //You need to invert the coordinates due to the layout of the context
    //                         x-origin,    y-origin, width, height
//    CGRect square = CGRectMake(newPoint.y, newPoint.x, _squareSideLength, _squareSideLength);
//    CGContextSetRGBStrokeColor(context, self.red, self.green, self.blue, self.alpha);
//    CGContextSetRGBFillColor(context, self.red, self.green, self.blue, self.alpha);
//    CGContextSetLineWidth(context, 0.5);
//    CGContextFillRect(context, square);
    
    CGContextSetLineWidth(context, 6.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, pointOne.y, pointOne.x);
    CGContextAddLineToPoint(context, pointTwo.y, pointTwo.x);
    CGContextStrokePath(context);

    CGContextSetLineWidth(context, 6.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, pointTwo.y, pointTwo.x);
    CGContextAddLineToPoint(context, pointThree.y, pointThree.x);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 6.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, pointThree.y, pointThree.x);
    CGContextAddLineToPoint(context, pointFour.y, pointFour.x);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 6.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, pointFour.y, pointFour.x);
    CGContextAddLineToPoint(context, pointOne.y, pointOne.x);
    CGContextStrokePath(context);
}

//-(void)drawSquareHelper:(CGPoint) start : (CGPoint) end{
//    
//    CGContextSetLineWidth(context, 6.0);
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, newPoint.y, newPoint.x);
//    CGContextAddLineToPoint(context, endPoint.y, endPoint.x);
//    CGContextStrokePath(context);
//    
//}

-(CGPoint)rotate:(float) angle : (CGPoint) squarePoint{
    
    CGPoint oldPosition;
    CGPoint newPosition;
    
    oldPosition.x = 375.0/2.0;
    oldPosition.y = 667.0/2.0;
    
    squarePoint.x -= 375.0/2.0;
    squarePoint.y -= 667.0/2.0;
    
    newPosition.x = ((squarePoint.x) * (cosf(angle/180 * M_PI)) - ((squarePoint.y) * (sinf(angle / 180 * M_PI))));
    newPosition.y = ((squarePoint.x) * (sinf(angle/180 * M_PI)) + ((squarePoint.y) * (cosf(angle / 180 * M_PI))));
    
//    NSLog(@"X cordinate of newPosition before translate: %f", newPosition.x);
//    NSLog(@"Y cordinate of newPosition before translate: %f", newPosition.y);
//    
//    NSLog(@"X cordinate of oldPosition before translate: %f", oldPosition.x);
//    NSLog(@"Y cordinate of oldPosition before translate: %f", oldPosition.y);
    
    newPosition.x += oldPosition.x;
    newPosition.y += oldPosition.y;
    
//    NSLog(@"X cordinate of newPosition after translate: %f", newPosition.x);
//    NSLog(@"Y cordinate of newPosition after translate: %f", newPosition.y);
    
    return newPosition;
    
}

-(void)reset{
    
    _squareSideLength = 75.0f;
    _squareOne.x = 375.0/2.0 - (_squareSideLength/2);
    _squareOne.y = 667.0/2.0 - (_squareSideLength/2);
    
    _squareTwo.x = 375.0/2.0 + (_squareSideLength/2);
    _squareTwo.y = 667.0/2.0 - (_squareSideLength/2);
    
    _squareThree.x = 375.0/2.0 + (_squareSideLength/2);
    _squareThree.y = 667.0/2.0 + (_squareSideLength/2);
    
    _squareFour.x = 375.0/2.0 - (_squareSideLength/2);
    _squareFour.y = 667.0/2.0 + (_squareSideLength/2);
    
}


@end
