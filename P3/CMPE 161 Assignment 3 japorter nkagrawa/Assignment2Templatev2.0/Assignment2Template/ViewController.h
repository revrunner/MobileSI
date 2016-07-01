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
    Boolean firstTime;
    NSTimeInterval startSimulationTime;
}

//Enums
typedef enum { ACCELEROMETER, MOTIONDEVICE } ObjectType;

//Properties
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) size_t height;
@property (nonatomic) size_t width;
@property (nonatomic) CGPoint contextSize;
@property (nonatomic) CGPoint viewSize;
@property (nonatomic) ObjectType objectToDraw;
@property (nonatomic) NSMutableArray *accelData;
@property (nonatomic) NSMutableArray *motionData;
@property (nonatomic) NSMutableArray *gravityVector;
@property (nonatomic) CGPoint xEqualToZero;
@property (nonatomic) CGPoint yEqualToZero;
@property (nonatomic) Circle *line;


//Outlets
@property (weak, nonatomic) IBOutlet UISegmentedControl *object2DSelectionSegmentControl;
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet UIButton *stop;


//Actions
- (IBAction)object2DSelectionSegmentChanged:(id)sender;
- (IBAction)CMStart:(id)sender;
- (IBAction)CMStop:(id)sender;





@end

