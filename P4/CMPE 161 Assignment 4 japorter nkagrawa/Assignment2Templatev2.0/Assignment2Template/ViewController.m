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
    mManager.gyroUpdateInterval = 1.0/10.0;
    [mManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical];
    
    accelerometerQueue = [NSOperationQueue currentQueue];
    gyroQueue = [NSOperationQueue currentQueue];
    
    firstTime = true;
    
    _listOfCircles = [[NSMutableArray alloc]init];
    _motionData = [[NSMutableArray alloc] init];
    _gyroData = [[NSMutableArray alloc]init];
    _tempRotationalMatrix = [[NSMutableArray alloc]init];
    _identityRotationalMatrix = [[NSMutableArray alloc] init];
    _finalMatrix = [[NSMutableArray alloc] init];
    _cameraPoints = [[NSMutableArray alloc]init];
    
    //Initialize AVCaptureDevice
    [self initCapture];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapGesture:)];
    
    tapRecognizer.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:tapRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)respondToTapGesture:(UITapGestureRecognizer *) recognizer{
    
    if(recognizer.state == UIGestureRecognizerStateRecognized){
            
        _startPoint = [recognizer locationInView:recognizer.view];
        
        _startPoint.x = _startPoint.x*(_contextSize.y/_viewSize.x);
        _startPoint.y = _startPoint.y*(_contextSize.x/_viewSize.y);
        
        Circle* circle = [[Circle alloc]initWithCGPoint:_startPoint];
        [_listOfCircles removeAllObjects];
        [_listOfCircles addObject:circle];
        
        _startPoint.x = _startPoint.x - 240;
        _startPoint.y = _startPoint.y - 320;
        
        if(_objectToDraw == NONE){
            
            if (mManager.isGyroActive){
                
                [gyroQueue setSuspended:TRUE];
                [gyroQueue cancelAllOperations];
                
                [mManager stopGyroUpdates];
                
            }
            
            if(mManager.isDeviceMotionActive){
                
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
        
        else if(_objectToDraw == DEVICEMOTION){
            
            if (mManager.isGyroActive){
                
                [gyroQueue setSuspended:TRUE];
                [gyroQueue cancelAllOperations];
                
                [mManager stopGyroUpdates];
                
            }
            
            //Ensure accelerometer is available
            if (mManager.isAccelerometerAvailable) {
                
                //Start DeviceMotion updates using referenc frame: CMAttitudeReferenceFrameXArbitraryZVertical, Queue: accelerometerQueue
                [mManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical toQueue:accelerometerQueue withHandler:^(CMDeviceMotion *motion, NSError *error){
                    
                    CFAbsoluteTime currentSimulationTime;
                    
                    [_motionData removeAllObjects];
                    [_motionData addObject:[NSNumber numberWithDouble:motion.userAcceleration.x]];
                    [_motionData addObject:[NSNumber numberWithDouble:motion.userAcceleration.y]];
                    [_motionData addObject:[NSNumber numberWithDouble:motion.userAcceleration.z]];
                    
                    
                    //Get a timestamp of the events, starting at 0s
                    if (firstTime) {
                        startSimulationTime = motion.timestamp;
                        currentSimulationTime = 0;
                        NSLog(@"Start time: %f", startSimulationTime);
                        firstTime = false;
                    } else {
                        currentSimulationTime = motion.timestamp-startSimulationTime;
                        NSLog(@"Current time: %f", currentSimulationTime);
                    }
                    

                    //focal is 611
                    
                    
                    if (currentSimulationTime == 0){
                        
                        _temp = motion.attitude;
                        
                    }else{
                        
                        [motion.attitude multiplyByInverseOfAttitude:_temp];
                        
                    }
                    
                    NSLog(@"temp : %@", _temp);
                    
                    [_cameraPoints removeAllObjects];
                    
                    NSNumber *product = 0;
                    
                    product = @((_startPoint.x*_temp.rotationMatrix.m11)+(_startPoint.y*_temp.rotationMatrix.m12)+(611*_temp.rotationMatrix.m13));
                    [_cameraPoints addObject:product];
                    product = @((_startPoint.x*_temp.rotationMatrix.m21)+(_startPoint.y*_temp.rotationMatrix.m22)+(611*_temp.rotationMatrix.m23));
                    [_cameraPoints addObject:product];
                    product = @((_startPoint.x*_temp.rotationMatrix.m31)+(_startPoint.y*_temp.rotationMatrix.m32)+(611*_temp.rotationMatrix.m33));
                    [_cameraPoints addObject:product];
                    
                    CGPoint pixelsOfCircleMovement;
                    
                    NSNumber* x = 0;
                    NSNumber* y = 0;
                    
                    x = @(((611.0*([_cameraPoints[0] doubleValue]/[_cameraPoints[2] doubleValue])) + 240.0));
                    y = @(((611.0*([_cameraPoints[1] doubleValue]/[_cameraPoints[2] doubleValue])) + 320.0));
                    
                    pixelsOfCircleMovement.x = [x doubleValue];
                    pixelsOfCircleMovement.y = [y doubleValue];
                    
                    //_startPoint.x = pixelsOfCircleMovement.x;
                    
                    Circle* hey = [[Circle alloc]initWithCGPoint:pixelsOfCircleMovement];
                    
                    if(!_traceOnOff.isOn){
                        [_listOfCircles removeAllObjects];
                    }
                    [_listOfCircles addObject:hey];
                    
                }];
            }

            
        }
        
        else if(_objectToDraw == GYROSCOPE){
            
            if(mManager.isDeviceMotionActive){
                
                // NSLog(@"stop motion");
                //Halt the queue from receiving any more operations
                [accelerometerQueue setSuspended:TRUE];
                [accelerometerQueue cancelAllOperations];
                
                //stop device mpotion updates
                [mManager stopDeviceMotionUpdates];
                
                //Reset timestamp flag
                firstTime = true;
            
            }
            
            if(mManager.isGyroAvailable) {
                
                [mManager startGyroUpdatesToQueue:gyroQueue withHandler:^(CMGyroData * gyroData, NSError * error) {
                    
                    CFAbsoluteTime currentSimulationTime;
                    
                    [_gyroData removeAllObjects];
                    [_gyroData addObject:[NSNumber numberWithDouble:gyroData.rotationRate.x]];
                    [_gyroData addObject:[NSNumber numberWithDouble:gyroData.rotationRate.y]];
                    [_gyroData addObject:[NSNumber numberWithDouble:gyroData.rotationRate.z]];
                    
                    NSLog(@"xGyro: %f", gyroData.rotationRate.x);
                    NSLog(@"yGyro: %f", gyroData.rotationRate.y);
                    NSLog(@"zGyro: %f", gyroData.rotationRate.z);
                    
                    if (_gyroSpecifics == SMALL){
                        
                        [_finalMatrix removeAllObjects];
                        
                        if (firstTime) {
                            startSimulationTime = gyroData.timestamp;
                            currentSimulationTime = 0;
                            NSLog(@"Start time: %f", startSimulationTime);
                            firstTime = false;
                        } else {
                            currentSimulationTime = gyroData.timestamp-startSimulationTime;
                            NSLog(@"Current time: %f", currentSimulationTime);
                        }
                        
                        [_gyroData removeAllObjects];
                        [_gyroData addObject:[NSNumber numberWithDouble:(gyroData.rotationRate.x*0.1)]];
                        [_gyroData addObject:[NSNumber numberWithDouble:(gyroData.rotationRate.y*0.1)]];
                        [_gyroData addObject:[NSNumber numberWithDouble:(gyroData.rotationRate.z*0.1)]];
                        
                        NSLog(@"xGyro 2: %f", gyroData.rotationRate.x);
                        NSLog(@"yGyro 2: %f", gyroData.rotationRate.y);
                        NSLog(@"zGyro 2: %f", gyroData.rotationRate.z);
                        
                        if(currentSimulationTime == 0){
                            
                            NSLog(@"inside");
                            
                            [_tempRotationalMatrix removeAllObjects];
                            
                            [_tempRotationalMatrix addObject:[NSNumber numberWithDouble:1.0]];
                            [_tempRotationalMatrix addObject:[NSNumber numberWithDouble:0.0]];
                            [_tempRotationalMatrix addObject:[NSNumber numberWithDouble:0.0]];
                            [_tempRotationalMatrix addObject:[NSNumber numberWithDouble:0.0]];
                            [_tempRotationalMatrix addObject:[NSNumber numberWithDouble:1.0]];
                            [_tempRotationalMatrix addObject:[NSNumber numberWithDouble:0.0]];
                            [_tempRotationalMatrix addObject:[NSNumber numberWithDouble:0.0]];
                            [_tempRotationalMatrix addObject:[NSNumber numberWithDouble:0.0]];
                            [_tempRotationalMatrix addObject:[NSNumber numberWithDouble:1.0]];
                            
                            _identityRotationalMatrix = _tempRotationalMatrix;
                            
                            _finalMatrix = _identityRotationalMatrix;
                            
                        }else if(currentSimulationTime > 0.0){
                            
                            NSLog(@"inside 2");
                            
                            [_identityRotationalMatrix removeAllObjects];
                            
                            [_identityRotationalMatrix addObject:[NSNumber numberWithDouble:1.0]];
                            [_identityRotationalMatrix addObject:[NSNumber numberWithDouble:[_gyroData[2] doubleValue]]];
                            [_identityRotationalMatrix addObject:[NSNumber numberWithDouble:(-1*[_gyroData[1] doubleValue])]];
                            [_identityRotationalMatrix addObject:[NSNumber numberWithDouble:(-1*[_gyroData[2] doubleValue])]];
                            [_identityRotationalMatrix addObject:[NSNumber numberWithDouble:1.0]];
                            [_identityRotationalMatrix addObject:[NSNumber numberWithDouble:[_gyroData[0] doubleValue]]];
                            [_identityRotationalMatrix addObject:[NSNumber numberWithDouble:[_gyroData[1] doubleValue]]];
                            [_identityRotationalMatrix addObject:[NSNumber numberWithDouble:(-1*[_gyroData[0] doubleValue])]];
                            [_identityRotationalMatrix addObject:[NSNumber numberWithDouble:1.0]];
                            
                            //multiple the new matrix (identityRotationalMatrix) by the old one which
                            //essentially equals all of the past rotational matrices combined
                            //into one (tempRotationalMatrix)
                            
                            NSNumber *product = 0;
                            
                            NSLog(@"inside 3");
                            NSLog(@"_identityRotation: %@", _identityRotationalMatrix);
                            NSLog(@"_tempRotation: %@",_tempRotationalMatrix);
                            
                            NSLog(@"_identityRotation 2 : %@", _identityRotationalMatrix);
                            NSLog(@"_tempRotation 2 : %@",_tempRotationalMatrix);
                            
                            product = @(([_tempRotationalMatrix[0] doubleValue] * [_identityRotationalMatrix[0] doubleValue]) + ([_tempRotationalMatrix[1] doubleValue] * [_identityRotationalMatrix[3] doubleValue]) + ([_tempRotationalMatrix[2] doubleValue] * [_identityRotationalMatrix[6] doubleValue]));
                            [_finalMatrix addObject:product];
                            product = @(([_tempRotationalMatrix[0] doubleValue] * [_identityRotationalMatrix[1] doubleValue]) + ([_tempRotationalMatrix[1] doubleValue] * [_identityRotationalMatrix[4] doubleValue]) + ([_tempRotationalMatrix[2] doubleValue] * [_identityRotationalMatrix[7] doubleValue]));
                            [_finalMatrix addObject:product];
                            product = @(([_tempRotationalMatrix[0] doubleValue] * [_identityRotationalMatrix[2] doubleValue]) + ([_tempRotationalMatrix[1] doubleValue] * [_identityRotationalMatrix[5] doubleValue]) + ([_tempRotationalMatrix[2] doubleValue] * [_identityRotationalMatrix[8] doubleValue]));
                            [_finalMatrix addObject:product];
                            product = @(([_tempRotationalMatrix[3] doubleValue] * [_identityRotationalMatrix[0] doubleValue]) + ([_tempRotationalMatrix[4] doubleValue] * [_identityRotationalMatrix[3] doubleValue]) + ([_tempRotationalMatrix[5] doubleValue] * [_identityRotationalMatrix[6] doubleValue]));
                            [_finalMatrix addObject:product];
                            product = @(([_tempRotationalMatrix[3] doubleValue] * [_identityRotationalMatrix[1] doubleValue]) + ([_tempRotationalMatrix[4] doubleValue] * [_identityRotationalMatrix[4] doubleValue]) + ([_tempRotationalMatrix[5] doubleValue] * [_identityRotationalMatrix[7] doubleValue]));
                            [_finalMatrix addObject:product];
                            product = @(([_tempRotationalMatrix[3] doubleValue] * [_identityRotationalMatrix[2] doubleValue]) + ([_tempRotationalMatrix[4] doubleValue] * [_identityRotationalMatrix[5] doubleValue]) + ([_tempRotationalMatrix[5] doubleValue] * [_identityRotationalMatrix[8] doubleValue]));
                            [_finalMatrix addObject:product];
                            product = @(([_tempRotationalMatrix[6] doubleValue] * [_identityRotationalMatrix[0] doubleValue]) + ([_tempRotationalMatrix[7] doubleValue] * [_identityRotationalMatrix[3] doubleValue]) + ([_tempRotationalMatrix[8] doubleValue] * [_identityRotationalMatrix[6] doubleValue]));
                            [_finalMatrix addObject:product];
                            product = @(([_tempRotationalMatrix[6] doubleValue] * [_identityRotationalMatrix[1] doubleValue]) + ([_tempRotationalMatrix[7] doubleValue] * [_identityRotationalMatrix[4] doubleValue]) + ([_tempRotationalMatrix[8] doubleValue] * [_identityRotationalMatrix[7] doubleValue]));
                            [_finalMatrix addObject:product];
                            product = @(([_tempRotationalMatrix[6] doubleValue] * [_identityRotationalMatrix[2] doubleValue]) + ([_tempRotationalMatrix[7] doubleValue] * [_identityRotationalMatrix[5] doubleValue]) + ([_tempRotationalMatrix[8] doubleValue] * [_identityRotationalMatrix[8] doubleValue]));
                            [_finalMatrix addObject:product];
                            
                            NSLog(@"inside 4ß");
                            
                        }
                        
                        NSLog(@"outside");
                        
                        _tempRotationalMatrix = _finalMatrix;
                        
                        //focal length is 611
                        
                        [_cameraPoints removeAllObjects];
                        
                        NSNumber *product = 0;
                        
                        product = @((_startPoint.x*[_finalMatrix[0] doubleValue])+(_startPoint.y*[_finalMatrix[1] doubleValue])+(611*[_finalMatrix[2] doubleValue]));
                        [_cameraPoints addObject:product];
                        product = @((_startPoint.x*[_finalMatrix[3] doubleValue])+(_startPoint.y*[_finalMatrix[4] doubleValue])+(611*[_finalMatrix[5] doubleValue]));
                        [_cameraPoints addObject:product];
                        product = @((_startPoint.x*[_finalMatrix[6] doubleValue])+(_startPoint.y*[_finalMatrix[7] doubleValue])+(611*[_finalMatrix[8] doubleValue]));
                        [_cameraPoints addObject:product];
                        
                        CGPoint pixelsOfCircleMovement;
                        
                        NSNumber* x = 0;
                        NSNumber* y = 0;
                        
                        x = @(((611.0*([_cameraPoints[0] doubleValue]/[_cameraPoints[2] doubleValue])) + 240.0));
                        y = @(((611.0*([_cameraPoints[1] doubleValue]/[_cameraPoints[2] doubleValue])) + 320.0));
                        
                        pixelsOfCircleMovement.x = [x doubleValue];
                        pixelsOfCircleMovement.y = [y doubleValue];
                        
                        Circle* hey = [[Circle alloc]initWithCGPoint:pixelsOfCircleMovement];
                        
                        if(!_traceOnOff.isOn){
                            [_listOfCircles removeAllObjects];
                        }
                        [_listOfCircles addObject:hey];
                        
                    }
                    
                }];
                
            }
            
            

        }
        
    }
    
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
    [self.view addSubview:_rodriguezControl];
    [self.view addSubview:_traceOnOff];
    [self.view addSubview:_button];
    
    
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
    
    for (int i=0; i<[_listOfCircles count]; i++) {
        
        //Mapping constant calculated to do the mapping from Points to Context
        [_listOfCircles[i] drawCircle:context:temp];
    }
    
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
    if (_object2DSelectionSegmentControl.selectedSegmentIndex == NONE) {
        
        //Let the captureOutput() know to draw lines only
        _objectToDraw = NONE;
        
        
    //Circle selected
    }else if (_object2DSelectionSegmentControl.selectedSegmentIndex == DEVICEMOTION) {
        
        //Let the captureOutput() know to draw circles only
        _objectToDraw = DEVICEMOTION;
        

    }else if (_object2DSelectionSegmentControl.selectedSegmentIndex == GYROSCOPE) {
        
        _objectToDraw = GYROSCOPE;
        
    }
}


- (IBAction)gyro2DSelectionSegmentChanged:(id)sender {
    
    if (_rodriguezControl.selectedSegmentIndex == FULL){
        
        _gyroSpecifics = FULL;
        
    }else if (_rodriguezControl.selectedSegmentIndex == SMALL){
        
        _gyroSpecifics = SMALL;
        
    }
    
}

- (IBAction)startOver:(id)sender {
    
    if (mManager.isGyroActive){
        
        [gyroQueue setSuspended:TRUE];
        [gyroQueue cancelAllOperations];
        
        [mManager stopGyroUpdates];
        
    }
    
    if(mManager.isDeviceMotionActive){
        
        // NSLog(@"stop motion");
        //Halt the queue from receiving any more operations
        [accelerometerQueue setSuspended:TRUE];
        [accelerometerQueue cancelAllOperations];
        
        //stop device mpotion updates
        [mManager stopDeviceMotionUpdates];
        
        //Reset timestamp flag
        firstTime = true;
        
    }
    
    [_listOfCircles removeAllObjects];
}

@end
