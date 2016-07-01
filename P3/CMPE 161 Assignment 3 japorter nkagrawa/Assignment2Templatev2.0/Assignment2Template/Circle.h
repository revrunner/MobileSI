//
//  Circle.h
//  Assignment2Template
//
//  Created on 2/1/16.
//  Copyright © 2016 CMPE161. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GLKit/GLKit.h>
#include <math.h>
#include "Shape2D.h"

#ifndef Circle_h
#define Circle_h
@interface Circle : Shape2D

//Variables
@property (nonatomic) CGPoint lineStartPoint;
@property (nonatomic) CGPoint lineEndPoint;

//Methods
-(id)init;
-(id)initWithCGPoint : (CGPoint) point : (CGPoint) pointTwo;
-(void)drawLine:(CGContextRef) context : (CGPoint) mappingConstant;

@end
#endif /* Circle_h */