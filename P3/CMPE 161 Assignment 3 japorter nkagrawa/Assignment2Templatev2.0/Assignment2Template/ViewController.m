//
//  ViewController.m
//  Assignment2Template
//
//  Created on 2/1/16.
//  Copyright © 2016 CMPE161. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

#pragma mark - View methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"PI constant: %f",M_PI);
    
    //Initialize any variables
    _viewSize.x = self.view.frame.size.width;//Width of UIView
    _viewSize.y =self.view.frame.size.height;//Height of UIView
    
    NSLog(@"Width of UIView: %f",_viewSize.x);
    NSLog(@"Height of UIView: %f",_viewSize.y);
    
    //Initialize motion manager and update intervals
    mManager = [[CMMotionManager alloc] init];
    mManager.deviceMotionUpdateInterval = 1.0/10.0;
    mManager.accelerometerUpdateInterval = 1.0/10.0;
    [mManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical];
    
    accelerometerQueue = [NSOperationQueue currentQueue];
    
    firstTime = true;
    
    _accelData = [[NSMutableArray alloc] init];
    _motionData = [[NSMutableArray alloc] init];
    _gravityVector = [[NSMutableArray alloc] init];
    _line = [[Circle alloc] init];
    
    double cemp = 0.0;
    [_gravityVector addObject:[NSNumber numberWithDouble:cemp]];
    [_gravityVector addObject:[NSNumber numberWithDouble:cemp]];
    [_gravityVector addObject:[NSNumber numberWithDouble:cemp]];
    
    
    //Initialize AVCaptureDevice
    [self initCapture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Camera
- (void)initCapture {
    
    AVCaptureDevice     *theDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput
                                          deviceInputWithDevice:theDevice
                                          error:nil];
    /*We setupt the output*/
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    /*While a frame is processes in -captureOutput:didOutputSampleBuffer:fromConnection: delegate methods no other frames are added in the queue.
     If you don't want this behaviour set the property to NO */
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    
    //We create a serial queue to handle the processing of our frames
    dispatch_queue_t queue;
    queue = dispatch_queue_create("cameraQueue", NULL);
    [captureOutput setSampleBufferDelegate:self queue:queue];
    
    // Set the video output to store frame in YpCbCr planar so we can access the brightness in contiguios memory
    NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
    // choice is kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange or RGBA
    
    NSNumber* value = [NSNumber numberWithInt:kCVPixelFormatType_32BGRA] ;
    NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    [captureOutput setVideoSettings:videoSettings];
    
    //And we create a capture session
    self.captureSession = [[AVCaptureSession alloc] init];
    
    //You can change this for different resolutions
    self.captureSession.sessionPreset = AVCaptureSessionPreset640x480;
    
    //We add input and output
    [self.captureSession addInput:captureInput];
    [self.captureSession addOutput:captureOutput];
    
    //Initialize and add imageview
    self.imageView = [[UIImageView alloc] init];
    
#warning Initialize to size of the screen. You need to select the right values and replace 100 and 100
    //TODO: select right width and height value
    self.imageView.frame = CGRectMake(0, 0,375.0,667.0);
    
    //Add subviews to master view
    //The order is important in order to view the button
    [self.view addSubview:self.imageView];

#warning Add any UI elements here
    [self.view addSubview:_object2DSelectionSegmentControl];//Adding the segment control
    [self.view addSubview:_start];
    [self.view addSubview:_stop];
    
    
    //Once startRunning is called the camera will start capturing frames
    [self.captureSession startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    /*Lock the image buffer*/
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    
    // Get the pixel buffer width and height
    self.width = CVPixelBufferGetWidth(imageBuffer);
    self.height = CVPixelBufferGetHeight(imageBuffer);
    
    
    //----------------------------------------------------------------------------------------
     //If you need to do something on the image, uncomment the following
     ///////////////////////////
     // we copy  imageBuffer into another chunk of memory
     // this is necessary otherwise it will slow things down
     // however, we should be able to allocate this buffer once and for all rather than creating it and destroying it at each frame
    //----------------------------------------------------------------------------------------
//    uint8_t *base = (uint8_t *) malloc(bytesPerRow * self.height * sizeof(uint8_t));
//    memcpy(base, baseAddress, bytesPerRow * self.height);
//    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
//    
//    NSLog(@"%zu",self.height);
//    NSLog(@"%zu",self.width);
//    NSLog(@"Bytes per row: %zu",bytesPerRow);
//    
//    // just for fun, let's do something on this image
//    // swap color channels
//    uint8_t *tp1, *tp2;
//    tp1 = base;
//    for (int iy=0;iy<self.height; iy++,tp1 += bytesPerRow){
//        tp2 = tp1;
//        for (int ix=0 ;ix<bytesPerRow;ix+=4,tp2+=4){
//            uint8_t aux = *tp2;
//            
//            //NSLog(@"%d",*tp1);
//            
//            if (ix==1500) {
//                *tp2 = 0;
//                *(tp2+1)=0;
//                *(tp2+2) = 0;
//            } else {
//                
//                *tp2 = *(tp2+1);
//                *(tp2+1)=*(tp2+2);
//                *(tp2+2) = aux;
//            }
//            
//        }
//    }
//    
//    //Draw an image
//    
//    // copy the buffer back to imageBuffer
//    CVPixelBufferLockBaseAddress(imageBuffer,0);
//    memcpy(baseAddress, base, bytesPerRow * self.height);
//    free(base);
    //----------------------------------------------------------------------------------------
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, self.width, self.height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    
    //Context size
    _contextSize.x = self.width;
    _contextSize.y = self.height;
    
    CGPoint temp = CGPointMake((_contextSize.y/_viewSize.x), (_contextSize.x/_viewSize.y));
    
    [_line drawLine:context :temp];

    
    //See the values of the image buffer
//    NSLog(@"Self width: %zu",self.width);
//    NSLog(@"Self height: %zu",self.height);
    
    
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    // UIImage *image = [UIImage imageWithCGImage:quartzImage];
    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:(CGFloat)1 orientation:UIImageOrientationRight];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    //notice we use this selector to call our setter method 'setImg' Since only the main thread can update this
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    
}


#pragma mark - Actions
#warning Example of using segmented controls
- (IBAction)object2DSelectionSegmentChanged:(id)sender {
    
    //Line selected
    if (_object2DSelectionSegmentControl.selectedSegmentIndex == ACCELEROMETER) {
        
        //Let the captureOutput() know to draw lines only
        _objectToDraw = ACCELEROMETER;
        
        
        
        
        
    //Circle selected
    }else if (_object2DSelectionSegmentControl.selectedSegmentIndex == MOTIONDEVICE) {
        
        //Let the captureOutput() know to draw circles only
        _objectToDraw = MOTIONDEVICE;
        

    }
}

- (IBAction)CMStart:(id)sender {
    
    if (_objectToDraw == ACCELEROMETER) {
        
       // NSLog(@"start accel");
        [mManager startAccelerometerUpdates];
//        NSLog(@"xCMAccel: %f", mManager.accelerometerData.acceleration.x);
//        NSLog(@"yCMAccel: %f", mManager.accelerometerData.acceleration.y);
//        NSLog(@"zCMAccel: %f", mManager.accelerometerData.acceleration.z);
        
        [_gravityVector removeAllObjects];
        [_gravityVector addObject:[NSNumber numberWithDouble:mManager.accelerometerData.acceleration.x]];
        [_gravityVector addObject:[NSNumber numberWithDouble:mManager.accelerometerData.acceleration.y]];
        [_gravityVector addObject:[NSNumber numberWithDouble:mManager.accelerometerData.acceleration.z]];
        
        [self alignGravityAxesAccel];
        
        
    }else if (_objectToDraw == MOTIONDEVICE){
        
       // NSLog(@"start motion");
        //Ensure accelerometer is available
        if (mManager.isAccelerometerAvailable) {
            
            //Start DeviceMotion updates using referenc frame: CMAttitudeReferenceFrameXArbitraryZVertical, Queue: accelerometerQueue
            [mManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical toQueue:accelerometerQueue withHandler:^(CMDeviceMotion *motion, NSError *error){
                
                //Display acceleration the user is giving to the device
//                _xCMDeviceMotionAccelerometer.text = [NSString stringWithFormat:@"X: %f", motion.userAcceleration.x];
//                _yCMDeviceMotionAccelerometer.text = [NSString stringWithFormat:@"Y: %f", motion.userAcceleration.y];
//                _zCMDeviceMotionAccelerometer.text = [NSString stringWithFormat:@"Z: %f", motion.userAcceleration.z];
                
//                NSLog(@"xCMDeviceMotionAccelerometer: %f", motion.userAcceleration.x);
//                NSLog(@"yCMDeviceMotionAccelerometer: %f", motion.userAcceleration.y);
//                NSLog(@"zCMDeviceMotionAccelerometer: %f", motion.userAcceleration.z);
                
                [_motionData removeAllObjects];
                [_motionData addObject:[NSNumber numberWithDouble:motion.userAcceleration.x]];
                [_motionData addObject:[NSNumber numberWithDouble:motion.userAcceleration.y]];
                [_motionData addObject:[NSNumber numberWithDouble:motion.userAcceleration.z]];
                
                
                //Display the gravity acceleration vector expressed in the device's reference frame
//                _xGravity.text = [NSString stringWithFormat:@"X: %f", motion.gravity.x];
//                _yGravity.text = [NSString stringWithFormat:@"Y: %f", motion.gravity.y];
//                _zGravity.text = [NSString stringWithFormat:@"Z: %f", motion.gravity.z];
                
//                NSLog(@"xGravity: %f", motion.gravity.x);
//                NSLog(@"yGravity: %f", motion.gravity.y);
//                NSLog(@"zGravity: %f", motion.gravity.z);
                
                [_gravityVector removeAllObjects];
                [_gravityVector addObject:[NSNumber numberWithDouble:motion.gravity.x]];
                [_gravityVector addObject:[NSNumber numberWithDouble:motion.gravity.y]];
                [_gravityVector addObject:[NSNumber numberWithDouble:motion.gravity.z]];
                
                [self alignGravityAxesMotion];
                
                
                //Get a timestamp of the events, starting at 0s
                if (firstTime) {
                    startSimulationTime = motion.timestamp;
                    NSLog(@"Start time: %f", startSimulationTime);
                    firstTime = false;
                } else {
                    CFAbsoluteTime currentSimulationTime = motion.timestamp-startSimulationTime;
                    NSLog(@"Current time: %f", currentSimulationTime);
                }
                
                //Total acceleration of the device
               // _combinedDeviceMotion.text = [NSString stringWithFormat:@"X:%f Y:%f Z:%f", motion.userAcceleration.x+motion.gravity.x,motion.userAcceleration.y+motion.gravity.y,motion.userAcceleration.z+motion.gravity.z];
                
            }];
        }
        
    }
    
}

- (void)alignGravityAxesAccel{
    
    double tmp = [_gravityVector[0] doubleValue];
    double temp = [_gravityVector[1] doubleValue];
    double temp2 = [_gravityVector[2] doubleValue];
    
    [_gravityVector removeAllObjects];
    temp = temp * -1;
    temp2 = temp2 * -1;
    
    [_gravityVector addObject:[NSNumber numberWithDouble:tmp]];
    [_gravityVector addObject:[NSNumber numberWithDouble:temp]];
    [_gravityVector addObject:[NSNumber numberWithDouble:temp2]];
    
    [self computeHorizonLine];

    
//    NSLog(@"accelData x: %f", [_accelData[0] doubleValue]);
//    NSLog(@"accelData y: %f", [_accelData[1] doubleValue]);
//    NSLog(@"accelData z: %f", [_accelData[2] doubleValue]);
    
}

- (void)alignGravityAxesMotion{
    
    double tmp = [_gravityVector[0] doubleValue];
    double temp = [_gravityVector[1] doubleValue];
    double temp2 = [_gravityVector[2] doubleValue];
    
    [_gravityVector removeAllObjects];
    temp = temp * -1;
    temp2 = temp2 * -1;
 
    [_gravityVector addObject:[NSNumber numberWithDouble:tmp]];
    [_gravityVector addObject:[NSNumber numberWithDouble:temp]];
    [_gravityVector addObject:[NSNumber numberWithDouble:temp2]];
    
//    NSLog(@"gravityVector x: %@", _gravityVector[0]);
//    NSLog(@"gravityVector y: %@", _gravityVector[1]);
//    NSLog(@"gravityVector z: %@", _gravityVector[2]);
    
    [self computeHorizonLine];

    
}

//667,375
//233.5,187.5

- (void)computeHorizonLine{
    
    _xEqualToZero.x = 0.0;
    _yEqualToZero.y = 0.0;
    
    _xEqualToZero.y = (-1*[_gravityVector[0] doubleValue]*233.5 - [_gravityVector[1] doubleValue]*187.5 + [_gravityVector[2] doubleValue]*611)/(-1*[_gravityVector[1] doubleValue]);
    
    _yEqualToZero.x = (-1*[_gravityVector[0] doubleValue]*233.5 - [_gravityVector[1] doubleValue]*187.5 + [_gravityVector[2] doubleValue]*611)/(-1*[_gravityVector[0] doubleValue]);
    
    double slope = (_xEqualToZero.y - _yEqualToZero.y)/(_xEqualToZero.x - _yEqualToZero.x);
    double b = _xEqualToZero.y;
    
    CGPoint suh = CGPointMake(0.0, b);
    if (suh.y > 667.0 || suh.y < 0.0){
        suh.y = 667.0;
        suh.x = (667.0-b)/slope;
    }
    
    CGPoint cuh = CGPointMake((-b/slope), 0.0);
    if(cuh.x > 375.0 || cuh.x < 0.0){
        cuh.x = 375.0;
        cuh.y = (375.0 * slope) + b;
    }
    
    if(suh.x > 375.0){
        suh.x = 375.0;
        suh.y = (slope*375.0) + b;
    }
    else if(cuh.y > 667){
        cuh.y = 667.0;
        cuh.x = (667.0-b)/slope;
    }
    
    _line.lineStartPoint = suh;
    _line.lineEndPoint = cuh;
    
//    NSLog(@"point 1, x: %f y: %f", _xEqualToZero.x, _xEqualToZero.y);
//    NSLog(@"point 2, x: %f y: %f", _yEqualToZero.x, _yEqualToZero.y);
//    NSLog(@"point 1 after, x: %f y: %f", suh.x, suh.y);
//    NSLog(@"point 2 after, x: %f y: %f", cuh.x, cuh.y);
}

- (IBAction)CMStop:(id)sender {
    
    if (_objectToDraw == ACCELEROMETER) {
        
       // NSLog(@"stop accel");
        [mManager stopAccelerometerUpdates];

        
    }else if (_objectToDraw == MOTIONDEVICE){
        
       // NSLog(@"stop motion");
        //Halt the queue from receiving any more operations
        [accelerometerQueue setSuspended:TRUE];
        [accelerometerQueue cancelAllOperations];
        
        //stop device mpotion updates
        [mManager stopDeviceMotionUpdates];
        
        //Reset timestamp flag
        firstTime = true;
        
    }
    
}

@end
