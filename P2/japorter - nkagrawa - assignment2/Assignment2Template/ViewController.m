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
    
//    NSLog(@"PI constant: %f",M_PI);
    
    //Initialize any variables
    _viewSize.x = self.view.frame.size.width;//Width of UIView
    _viewSize.y =self.view.frame.size.height;//Height of UIView
    
//    NSLog(@"Width of UIView: %f",_viewSize.x);
//    NSLog(@"Height of UIView: %f",_viewSize.y);
    
    //Initialize arrays
    _listOfCircles = [[NSMutableArray alloc]init];
    _listOfLines = [[NSMutableArray alloc]init];
    
    _shakeView = [[ShakingView alloc]init];

    //Initialize AVCaptureDevice
    [self initCapture];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapGesture:)];
    
    tapRecognizer.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:tapRecognizer];
    
    _startPoint.x = (0.0);
    _startPoint.y = (0.0);
    
    _squareOldPosition.x = 375.0/2.0;
    _squareOldPosition.y = 667.0/2.0;
    
    _square = [[Square alloc]init];
    
    _count = 0;
    
    _count2 = 0;
    
    _degrees.text = @"180";
    
    _sliderValue = 180.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if(event.type == UIEventSubtypeMotionShake){
        
        [_listOfCircles removeAllObjects];
        [_listOfLines removeAllObjects];
        [_square reset];
        _degreeRotation.value = 180.0;
        _degrees.text = [NSString stringWithFormat:@"%f", 180.0];
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

//- (void) viewWillAppear:(BOOL)animated{
//    
//    [_shakeView becomeFirstResponder];
//    [super viewWillAppear:animated];
//    
//}

- (void)respondToTapGesture:(UITapGestureRecognizer *) recognizer{
    
    if(recognizer.state == UIGestureRecognizerStateRecognized){
        
        if (_sliderValue != _degreeRotation.value){
            
            _sliderValue = _degreeRotation.value;

            _degrees.text = [NSString stringWithFormat:@"%f", _sliderValue];
            
        }
        
        if(_objectToDraw == CIRCLE){
            _startPoint = [recognizer locationInView:recognizer.view];
        
        //Location of the circle on the screen
        //This is different according to your device
        //See: http://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
            CGPoint location;
        
        //Middle of the screen using iPhone6
            location.x = _startPoint.x;
            location.y = _startPoint.y;
        
        //Create circle object with center location
            Circle* circle = [[Circle alloc]initWithCGPoint:location];
        
        //Add it to list of circles
            [_listOfCircles addObject:circle];

        }
        
        else if(_objectToDraw == LINE){
            
            _startPoint = [recognizer locationInView:recognizer.view];
            
            CGPoint temp;
            CGPoint temp2;
            
            if (_count == 0){
                _start.x = _startPoint.x;
                _start.y = _startPoint.y;
                _count++;
            }
            else if(_count == 1){
                _end.x = _startPoint.x;
                _end.y = _startPoint.y;
                
                temp = _start;
                temp2 = _end;
                _count = 0;
                                
                Line* line = [[Line alloc]init];
                line.lineStartPoint = temp;
                line.lineEndPoint = temp2;
                
                [_listOfLines addObject:line];
                
            }
            
//            NSLog(@"X cordinate of touch: %f", _start.x);
//            NSLog(@"Y cordinate of touch: %f", _start.y);
//            
//            NSLog(@"X cordinate of touch: %f", _end.x);
//            NSLog(@"Y cordinate of touch: %f", _end.y);
            
            
            
        }
        
        else if(_objectToDraw == SQUARE){
            
            if (_transformationToDo == TRANSLATE) {
                
                _startPoint = [recognizer locationInView:recognizer.view];
                
                CGPoint location;
                
                location.x = _startPoint.x;
                location.y = _startPoint.y;
                
//                NSLog(@"X cordinate of touch: %f", location.x);
//                NSLog(@"Y cordinate of touch: %f", location.y);
                
                Square* square = [[Square alloc]initWithCGPoint:location];
                
                _square = square;
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
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    
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
        
    [self.view addSubview:_rotateOrTranslateControl];
    
    [self.view addSubview:_degreeRotation];
    
    [self.view addSubview:_degrees];
    
    
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
    
    //See the values of the image buffer
//    NSLog(@"Self width: %zu",self.width);
//    NSLog(@"Self height: %zu",self.height);
    
    
#warning Here is where you draw 2D objects
    //----------------------------------------------------------------------------------------
    //TODO: Here is where you draw 2D objects.
    //----------------------------------------------------------------------------------------
    //Draw axes
    
    //375,667
    
    CGPoint temp = CGPointMake((_contextSize.y/_viewSize.x), (_contextSize.x/_viewSize.y));

    CGContextSetLineWidth(context, 6.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0 * temp.y, (375.0/2.0) * temp.x);
    CGContextAddLineToPoint(context, 667.0 * temp.y, (375.0/2.0) * temp.x);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 6.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, (667.0/2.0)  * temp.y, 0.0  * temp.x);
    CGContextAddLineToPoint(context, (667.0/2.0) * temp.y, 375.0  * temp.x);
    CGContextStrokePath(context);
    
    
    
    //Draw circles
    if (_objectToDraw == CIRCLE) {
  
        //Iterate through the list of circles and draw them all
        for (int i=0; i<[_listOfCircles count]; i++) {
            
            //Mapping constant calculated to do the mapping from Points to Context
            [_listOfCircles[i] drawCircle:context:CGPointMake((_contextSize.y/_viewSize.x), (_contextSize.x/_viewSize.y))];
        }

    //Draw lines
    }else if (_objectToDraw == LINE){

        for (int x = 0; x < [_listOfLines count]; x++){
            
            [_listOfLines[x] drawLine:context :CGPointMake((_contextSize.y/_viewSize.x), (_contextSize.x/_viewSize.y))];
            
        }
        
        //Example of calling class method from Shape2D to rotate a vector by 90 degrees
//        CGPoint results;
//        results = [Shape2D rotateVector:GLKVector3Make(4.0f, 3.0f, 0.0f) :90];
        
    }
    
    else if(_objectToDraw == SQUARE){
        
        if(_transformationToDo == ROTATE){
            
            if(_count2 == 0){
                
//                NSLog(@"X cordinate of box before rotate: %f", _square.squareCenter.x);
//                NSLog(@"Y cordinate of box before rotate: %f", _square.squareCenter.y);
            
                _square.squareOne = [_square rotate:_degreeRotation.value :_square.squareOne];
                _square.squareTwo = [_square rotate:_degreeRotation.value :_square.squareTwo];
                _square.squareThree = [_square rotate:_degreeRotation.value :_square.squareThree];
                _square.squareFour = [_square rotate:_degreeRotation.value :_square.squareFour];
                
//                NSLog(@"X cordinate of box after rotate: %f", _square.squareCenter.x);
//                NSLog(@"Y cordinate of box after rotate: %f", _square.squareCenter.y);
                
                _squareOldPosition = _square.squareOne;
                
                _count2++;
                
            }
            else{
                
                if (_sliderValue != _degreeRotation.value){
                    
                    _count2 = 0;
                    
                }else if(_squareOldPosition.x != _square.squareOne.x && _squareOldPosition.y != _square.squareOne.y)
                {
                    _count2 = 0;
                }
                
            }
            
        }
        
        [_square drawSquare:context :CGPointMake((_contextSize.y/_viewSize.x), (_contextSize.x/_viewSize.y))];
    }
    //----------------------------------------------------------------------------------------
    //----------------------------------------------------------------------------------------
    
    
    
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
    if (_object2DSelectionSegmentControl.selectedSegmentIndex == LINE) {
        
        //Let the captureOutput() know to draw lines only
        _objectToDraw = LINE;
        
        
    //Circle selected
    }else if (_object2DSelectionSegmentControl.selectedSegmentIndex == CIRCLE) {
        
        //Let the captureOutput() know to draw circles only
        _objectToDraw = CIRCLE;
        
   
    }
    else if (_object2DSelectionSegmentControl.selectedSegmentIndex == SQUARE){
        
        _objectToDraw = SQUARE;
        
    }
}

- (IBAction)geo2DSelectionSegmentChanged:(id)sender {
    
    if (_rotateOrTranslateControl.selectedSegmentIndex == NONE) {
        
        _transformationToDo = NONE;
        
    }
    else if (_rotateOrTranslateControl.selectedSegmentIndex == ROTATE){
        
        _transformationToDo = ROTATE;
        
        
    }
    else if (_rotateOrTranslateControl.selectedSegmentIndex == TRANSLATE){
        
        _transformationToDo = TRANSLATE;
        
    }
    
}

@end
