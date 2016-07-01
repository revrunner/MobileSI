//
//  ViewController.m
//  MatrixCalc
//
//  Created by Nirav Agrawal on 1/27/16.
//  Copyright © 2016 xyz. All rights reserved.
//

#import "ViewController.h"
#import <math.h>

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Do any additional setup after loading the view
    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 20.0, 0.0, 0.)];
    //    imageView.image = [UIImage imageNamed:@"MatrixCalculatorSmaller.jpg"];
    //    [imageView sizeToFit];
    //    [self.view addSubview:imageView];
    
    
    //Allocate and initialize calculator class
    _myCalculator = [[CalculatorClass alloc] init];
    
    _matrixOne = [[NSMutableArray alloc] init];
    _matrixTwo = [[NSMutableArray alloc] init];
    
    //Example of message passing. Clearing any data in my calculator
    [_myCalculator clear];
    
    //Make UITextField delegate to self. This is used in conjunction with the two methods
    //listed below in order so that the keyboard is dismissed when the user presses return
    // self.userTextField.delegate = self;
    
    _labelA1.layer.borderWidth = 1.0;
    _labelA2.layer.borderWidth = 1.0;
    _labelA3.layer.borderWidth = 1.0;
    _labelA4.layer.borderWidth = 1.0;
    _labelA5.layer.borderWidth = 1.0;
    _labelA6.layer.borderWidth = 1.0;
    _labelA7.layer.borderWidth = 1.0;
    _labelA8.layer.borderWidth = 1.0;
    _labelA9.layer.borderWidth = 1.0;
    _labelA1.userInteractionEnabled = YES;
    _labelA2.userInteractionEnabled = YES;
    _labelA3.userInteractionEnabled = YES;
    _labelA4.userInteractionEnabled = YES;
    _labelA5.userInteractionEnabled = YES;
    _labelA6.userInteractionEnabled = YES;
    _labelA7.userInteractionEnabled = YES;
    _labelA8.userInteractionEnabled = YES;
    _labelA9.userInteractionEnabled = YES;

    _labelB1.layer.borderWidth = 1.0;
    _labelB2.layer.borderWidth = 1.0;
    _labelB3.layer.borderWidth = 1.0;
    _labelB4.layer.borderWidth = 1.0;
    _labelB5.layer.borderWidth = 1.0;
    _labelB6.layer.borderWidth = 1.0;
    _labelB7.layer.borderWidth = 1.0;
    _labelB8.layer.borderWidth = 1.0;
    _labelB9.layer.borderWidth = 1.0;
    _labelB1.userInteractionEnabled = YES;
    _labelB2.userInteractionEnabled = YES;
    _labelB3.userInteractionEnabled = YES;
    _labelB4.userInteractionEnabled = YES;
    _labelB5.userInteractionEnabled = YES;
    _labelB6.userInteractionEnabled = YES;
    _labelB7.userInteractionEnabled = YES;
    _labelB8.userInteractionEnabled = YES;
    _labelB9.userInteractionEnabled = YES;

    _labelC1.layer.borderWidth = 1.0;
    _labelC2.layer.borderWidth = 1.0;
    _labelC3.layer.borderWidth = 1.0;
    _labelC4.layer.borderWidth = 1.0;
    _labelC5.layer.borderWidth = 1.0;
    _labelC6.layer.borderWidth = 1.0;
    _labelC7.layer.borderWidth = 1.0;
    _labelC8.layer.borderWidth = 1.0;
    _labelC9.layer.borderWidth = 1.0;
    _labelC1.userInteractionEnabled = YES;
    _labelC2.userInteractionEnabled = YES;
    _labelC3.userInteractionEnabled = YES;
    _labelC4.userInteractionEnabled = YES;
    _labelC5.userInteractionEnabled = YES;
    _labelC6.userInteractionEnabled = YES;
    _labelC7.userInteractionEnabled = YES;
    _labelC8.userInteractionEnabled = YES;
    _labelC9.userInteractionEnabled = YES;
    
    [_matrixOne removeAllObjects];
    
    NSString *temp = @("N/A");
    
    for(int n = 0; n < 9; n++){
        [_matrixOne addObject:temp];
    }
    
    _myCalculator.matrixOne = _matrixOne;
    
    _labelA1.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[0]];
    _labelA2.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[1]];
    _labelA3.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[2]];
    _labelA4.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[3]];
    _labelA5.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[4]];
    _labelA6.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[5]];
    _labelA7.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[6]];
    _labelA8.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[7]];
    _labelA9.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[8]];
    
    [_matrixTwo removeAllObjects];
    
    for(int n = 0; n < 9; n++){
        [_matrixTwo addObject:temp];
    }
    
    _myCalculator.matrixTwo = _matrixTwo;
    
    _labelB1.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[0]];
    _labelB2.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[1]];
    _labelB3.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[2]];
    _labelB4.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[3]];
    _labelB5.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[4]];
    _labelB6.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[5]];
    _labelB7.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[6]];
    _labelB8.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[7]];
    _labelB9.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[8]];
    
    //Initialize fields
    // self.userTextField.text = @"";
    // self.historyTextField.text = @"History";

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fireAlert{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Bad Math! Check your matrices!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)FillA:(id)sender {
    
    [_matrixOne removeAllObjects];
    int num1 = arc4random() % 10 + 1;
    [_matrixOne addObject:[NSNumber numberWithInt:num1]];
    int num2 = arc4random() % 10 + 1;
    [_matrixOne addObject:[NSNumber numberWithInt:num2]];
    int num3 = arc4random() % 10 + 1;
    [_matrixOne addObject:[NSNumber numberWithInt:num3]];
    int num4 = arc4random() % 10 + 1;
    [_matrixOne addObject:[NSNumber numberWithInt:num4]];
    int num5 = arc4random() % 10 + 1;
    [_matrixOne addObject:[NSNumber numberWithInt:num5]];
    int num6 = arc4random() % 10 + 1;
    [_matrixOne addObject:[NSNumber numberWithInt:num6]];
    int num7 = arc4random() % 10 + 1;
    [_matrixOne addObject:[NSNumber numberWithInt:num7]];
    int num8 = arc4random() % 10 + 1;
    [_matrixOne addObject:[NSNumber numberWithInt:num8]];
    int num9 = arc4random() % 10 + 1;
    [_matrixOne addObject:[NSNumber numberWithInt:num9]];
    _myCalculator.matrixOne = _matrixOne;
    
    _labelA1.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[0]];
    _labelA2.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[1]];
    _labelA3.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[2]];
    _labelA4.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[3]];
    _labelA5.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[4]];
    _labelA6.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[5]];
    _labelA7.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[6]];
    _labelA8.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[7]];
    _labelA9.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[8]];
}

- (IBAction)FillB:(id)sender {
    
    [_matrixTwo removeAllObjects];
    int num1 = arc4random() % 10 + 1;
    [_matrixTwo addObject:[NSNumber numberWithInt:num1]];
    int num2 = arc4random() % 10 + 1;
    [_matrixTwo addObject:[NSNumber numberWithInt:num2]];
    int num3 = arc4random() % 10 + 1;
    [_matrixTwo addObject:[NSNumber numberWithInt:num3]];
    int num4 = arc4random() % 10 + 1;
    [_matrixTwo addObject:[NSNumber numberWithInt:num4]];
    int num5 = arc4random() % 10 + 1;
    [_matrixTwo addObject:[NSNumber numberWithInt:num5]];
    int num6 = arc4random() % 10 + 1;
    [_matrixTwo addObject:[NSNumber numberWithInt:num6]];
    int num7 = arc4random() % 10 + 1;
    [_matrixTwo addObject:[NSNumber numberWithInt:num7]];
    int num8 = arc4random() % 10 + 1;
    [_matrixTwo addObject:[NSNumber numberWithInt:num8]];
    int num9 = arc4random() % 10 + 1;
    [_matrixTwo addObject:[NSNumber numberWithInt:num9]];
    _myCalculator.matrixTwo = _matrixTwo;
    
    _labelB1.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[0]];
    _labelB2.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[1]];
    _labelB3.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[2]];
    _labelB4.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[3]];
    _labelB5.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[4]];
    _labelB6.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[5]];
    _labelB7.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[6]];
    _labelB8.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[7]];
    _labelB9.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[8]];
    
    
}

- (IBAction)Addition:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    self.populateObjectArrays;
    _myCalculator.add;
    self.populateFinalMatrix;
   
}

- (IBAction)Subtraction:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    self.populateObjectArrays;
    _myCalculator.sub;
    self.populateFinalMatrix;
   
}

- (IBAction)Mult:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    self.populateObjectArrays;
    _myCalculator.mult;
    self.populateFinalMatrix;
   
}

- (IBAction)Div:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    
    
    self.populateObjectArrays;

    _myCalculator.div;
    self.populateFinalMatrix;
    
}

- (IBAction)MultElements:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    self.populateObjectArrays;
    _myCalculator.multElements;
    self.populateFinalMatrix;
    
}

- (IBAction)Determinant:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    self.populateObjectArrays;
    _myCalculator.determinant;
    self.populateFinalMatrix;
    
}

- (IBAction)Inverse:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    self.populateObjectArrays;
    _myCalculator.inverse;
    self.populateFinalMatrix;
    
}

- (IBAction)Transpose:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    self.populateObjectArrays;
    _myCalculator.transpose;
    self.populateFinalMatrix;
    
}

- (IBAction)dotProduct:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    self.populateObjectArrays;
    _myCalculator.dotProduct;
    self.populateFinalMatrix;
    
}

- (IBAction)crossProduct:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    self.populateObjectArrays;
    _myCalculator.crossProduct;
    self.populateFinalMatrix;
    
}

- (IBAction)multOddMatrix:(id)sender {
    
    [_myCalculator.finalMatrix removeAllObjects];
    self.populateObjectArrays;
    _myCalculator.multOddMatrix;
    self.populateFinalMatrix;
    
}

- (IBAction)EnterPressed:(id)sender {
    
    NSLog(_textField.text);
    
    NSString *textField = _textField.text;
    NSArray *arrayOfText = [textField componentsSeparatedByString:@" "];
    
    if (arrayOfText.count != 4){
        
        _textField.text = @"Invalid";
        
    }
    else{
        
        if ([arrayOfText[0]  isEqual: @"A"]){
            if (([arrayOfText[1] intValue]) == 1){
                if (([arrayOfText[2] intValue]) == 1){
                    _matrixOne[0] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixOne[0] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 2){
                    _matrixOne[1] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixOne[1] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 3){
                    _matrixOne[2] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixOne[2] = @([arrayOfText[3] intValue]);
                }
                else{
                    _textField.text = @"Invalid";
                }
            }
            else if (([arrayOfText[1] intValue]) == 2){
                if (([arrayOfText[2] intValue]) == 1){
                    _matrixOne[3] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixOne[3] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 2){
                    _matrixOne[4] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixOne[4] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 3){
                    _matrixOne[5] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixOne[5] = @([arrayOfText[3] intValue]);
                }
                else{
                    _textField.text = @"Invalid";
                }
                
            }
            else if (([arrayOfText[1] intValue]) == 3){
                if (([arrayOfText[2] intValue]) == 1){
                    _matrixOne[6] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixOne[6] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 2){
                    _matrixOne[7] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixOne[7] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 3){
                    _matrixOne[8] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixOne[8] = @([arrayOfText[3] intValue]);
                }
                else{
                    _textField.text = @"Invalid";
                }
            }
            else{
                _textField.text = @"Invalid";
            }
        }
        if ([arrayOfText[0]  isEqual: @"B"]){
            if (([arrayOfText[1] intValue]) == 1){
                if (([arrayOfText[2] intValue]) == 1){
                    _matrixTwo[0] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixTwo[0] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 2){
                    _matrixTwo[1] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixTwo[1] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 3){
                    _matrixTwo[2] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixTwo[2] = @([arrayOfText[3] intValue]);
                }
                else{
                    _textField.text = @"Invalid";
                }
            }
            else if (([arrayOfText[1] intValue]) == 2){
                if (([arrayOfText[2] intValue]) == 1){
                    _matrixTwo[3] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixTwo[3] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 2){
                    _matrixTwo[4] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixTwo[4] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 3){
                    _matrixTwo[5] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixTwo[5] = @([arrayOfText[3] intValue]);
                }
                else{
                    _textField.text = @"Invalid";
                }
                
            }
            else if (([arrayOfText[1] intValue]) == 3){
                if (([arrayOfText[2] intValue]) == 1){
                    _matrixTwo[6] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixTwo[6] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 2){
                    _matrixTwo[7] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixTwo[7] = @([arrayOfText[3] intValue]);
                }
                else if (([arrayOfText[2] intValue]) == 3){
                    _matrixTwo[8] = @([arrayOfText[3] intValue]);
                    _myCalculator.matrixTwo[8] = @([arrayOfText[3] intValue]);
                }
                else{
                    _textField.text = @"Invalid";
                }
            }
            else{
                _textField.text = @"Invalid";
            }
        }
   
    }
    self.populateObjectArrays;
    
}

- (IBAction)ClearA:(id)sender {
    
    [_matrixOne removeAllObjects];
    
    NSString *temp = @("N/A");
    
    for(int n = 0; n < 9; n++){
        [_matrixOne addObject:temp];
    }
    
    _myCalculator.matrixOne = _matrixOne;
    
    _labelA1.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[0]];
    _labelA2.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[1]];
    _labelA3.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[2]];
    _labelA4.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[3]];
    _labelA5.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[4]];
    _labelA6.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[5]];
    _labelA7.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[6]];
    _labelA8.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[7]];
    _labelA9.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[8]];
    
}

- (IBAction)ClearB:(id)sender {
    
    [_matrixTwo removeAllObjects];
    
    NSString *temp = @("N/A");
    
    for(int n = 0; n < 9; n++){
        [_matrixTwo addObject:temp];
    }
    
    _myCalculator.matrixTwo = _matrixTwo;
    
    _labelB1.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[0]];
    _labelB2.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[1]];
    _labelB3.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[2]];
    _labelB4.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[3]];
    _labelB5.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[4]];
    _labelB6.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[5]];
    _labelB7.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[6]];
    _labelB8.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[7]];
    _labelB9.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[8]];
    
}

- (void)populateObjectArrays{
    
    _myCalculator.matrixOne = _matrixOne;
    _myCalculator.matrixTwo = _matrixTwo;
    
    _labelA1.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[0]];
    _labelA2.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[1]];
    _labelA3.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[2]];
    _labelA4.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[3]];
    _labelA5.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[4]];
    _labelA6.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[5]];
    _labelA7.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[6]];
    _labelA8.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[7]];
    _labelA9.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixOne[8]];
    
    _labelB1.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[0]];
    _labelB2.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[1]];
    _labelB3.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[2]];
    _labelB4.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[3]];
    _labelB5.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[4]];
    _labelB6.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[5]];
    _labelB7.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[6]];
    _labelB8.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[7]];
    _labelB9.text = [NSString stringWithFormat:@"%@", _myCalculator.matrixTwo[8]];

}

- (void)populateFinalMatrix{
    
    _labelC1.text = [NSString stringWithFormat:@"%@", _myCalculator.finalMatrix[0]];
    _labelC2.text = [NSString stringWithFormat:@"%@", _myCalculator.finalMatrix[1]];
    _labelC3.text = [NSString stringWithFormat:@"%@", _myCalculator.finalMatrix[2]];
    _labelC4.text = [NSString stringWithFormat:@"%@", _myCalculator.finalMatrix[3]];
    _labelC5.text = [NSString stringWithFormat:@"%@", _myCalculator.finalMatrix[4]];
    _labelC6.text = [NSString stringWithFormat:@"%@", _myCalculator.finalMatrix[5]];
    _labelC7.text = [NSString stringWithFormat:@"%@", _myCalculator.finalMatrix[6]];
    _labelC8.text = [NSString stringWithFormat:@"%@", _myCalculator.finalMatrix[7]];
    _labelC9.text = [NSString stringWithFormat:@"%@", _myCalculator.finalMatrix[8]];
    
}
//----------------------------------------------------------------------------------------------------




//----------------------------------------------------------------------------------------------------
//The system does not dismiss the keyboard automatically.
//To dismiss the keyboard, call the “resignFirstResponder” method of the text-based view
//The following two methods are part of <UITextFieldDelegate>, which is declared in ViewController.h

//For more information: https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html

//Take focus away from the TextField so the keyboard is dismissed when the user presses return or go
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == _userTextField) {
        [_userTextField resignFirstResponder];
        
    }
    return YES;
}

// Dismiss the keyboard when the view outside the text field or keyboard is touched
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_userTextField resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}
//----------------------------------------------------------------------------------------------------


@end
