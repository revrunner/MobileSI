//
//  Square.h
//  Assignment2Template
//
//  Created by Nirav Agrawal on 2/16/16.
//  Copyright © 2016 CMPE161. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GLKit/GLKit.h>
#include <math.h>
#include "Shape2D.h"

#ifndef Square_h
#define Square_h
@interface Square : Shape2D

//Variables
@property (nonatomic) CGPoint squareOne;
@property (nonatomic) CGPoint squareTwo;
@property (nonatomic) CGPoint squareThree;
@property (nonatomic) CGPoint squareFour;
@property (nonatomic) CGFloat squareSideLength;

//Methods
-(id)init;
-(id)initWithCGPoint : (CGPoint) point;
-(void)drawSquare:(CGContextRef) context : (CGPoint) mappingConstant;

-(CGPoint)rotate:(float) angle : (CGPoint) squarePoint;
-(void)reset;

@end
#endif /* Square_h */