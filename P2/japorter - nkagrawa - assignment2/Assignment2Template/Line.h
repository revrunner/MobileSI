//
//  Line.h
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

#ifndef Line_h
#define Line_h
@interface Line : Shape2D

//Variables
@property (nonatomic) CGPoint lineStartPoint;
@property (nonatomic) CGPoint lineEndPoint;

//Methods
-(id)init;
-(id)initWithCGPoint : (CGPoint) point : (CGPoint) pointTwo;
-(void)drawLine:(CGContextRef) context : (CGPoint) mappingConstant;

@end
#endif /* Line_h */