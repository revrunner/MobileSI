//
//  ViewController.h
//  Assignment2Template
//
//  Created on 2/1/16.
//  Copyright © 2016 CMPE161. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GLKit/GLKit.h>
#include <math.h>
#include "Circle.h"
#include "Line.h"
#include "Square.h"
#include "ShakingView.h"

@interface ViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate>

//Enums
typedef enum { LINE, CIRCLE, SQUARE } ObjectType;
typedef enum { NONE, ROTATE, TRANSLATE } VecType;

//Properties
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) size_t height;
@property (nonatomic) size_t width;
@property (nonatomic) CGPoint contextSize;
@property (nonatomic) CGPoint viewSize;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) ObjectType objectToDraw;
@property (nonatomic) ObjectType transformationToDo;
@property (nonatomic) NSMutableArray* listOfCircles;
@property (nonatomic) int count;
@property (nonatomic) int count2;
@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint end;
@property (nonatomic) CGPoint squareOldPosition;
@property (nonatomic) NSMutableArray* listOfLines;
@property (nonatomic) Square* square;
@property (nonatomic) float sliderValue;
@property (nonatomic) ShakingView* shakeView;





//Outlets
@property (weak, nonatomic) IBOutlet UISegmentedControl *object2DSelectionSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *rotateOrTranslateControl;
@property (weak, nonatomic) IBOutlet UISlider *degreeRotation;
@property (weak, nonatomic) IBOutlet UILabel *degrees;





//Actions
- (IBAction)object2DSelectionSegmentChanged:(id)sender;
- (IBAction)geo2DSelectionSegmentChanged:(id)sender;





@end

