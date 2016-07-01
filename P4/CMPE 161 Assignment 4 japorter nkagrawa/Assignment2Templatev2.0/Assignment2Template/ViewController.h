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
#import <CoreMotion/CoreMotion.h>
#include <math.h>
#include "Circle.h"

@interface ViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate>{
    CMMotionManager *mManager;
    NSOperationQueue *accelerometerQueue;
    NSOperationQueue *gyroQueue;
    Boolean firstTime;
    NSTimeInterval startSimulationTime;
}

//Enums
typedef enum { NONE, DEVICEMOTION, GYROSCOPE } ObjectType;
typedef enum { FULL, SMALL } GyroType;

//Properties
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) size_t height;
@property (nonatomic) size_t width;
@property (nonatomic) CGPoint contextSize;
@property (nonatomic) CGPoint viewSize;
@property (nonatomic) ObjectType objectToDraw;
@property (nonatomic) GyroType gyroSpecifics;
@property (nonatomic) NSMutableArray* listOfCircles;
@property (nonatomic) NSMutableArray* motionData;
@property (nonatomic) NSMutableArray* gyroData;
@property (nonatomic) NSMutableArray* tempRotationalMatrix;
@property (nonatomic) NSMutableArray* identityRotationalMatrix;
@property (nonatomic) NSMutableArray* finalMatrix;
@property (nonatomic) NSMutableArray* cameraPoints;
@property (nonatomic) CMAttitude *temp;
@property (nonatomic) CGPoint startPoint;

//Outlets
@property (weak, nonatomic) IBOutlet UISegmentedControl *object2DSelectionSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *rodriguezControl;
@property (weak, nonatomic) IBOutlet UISwitch *traceOnOff;
@property (weak, nonatomic) IBOutlet UIButton *button;



//Actions
- (IBAction)object2DSelectionSegmentChanged:(id)sender;
- (IBAction)gyro2DSelectionSegmentChanged:(id)sender;
- (IBAction)startOver:(id)sender;







@end

