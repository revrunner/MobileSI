//
//  ViewController.h
//  MatrixCalc
//
//  Created by Nirav Agrawal on 1/27/16.
//  Copyright © 2016 xyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorClass.h"

@interface ViewController : UIViewController

//My classes
@property (nonatomic) CalculatorClass *myCalculator;
@property (nonatomic) NSMutableArray *matrixOne;
@property (nonatomic) NSMutableArray *matrixTwo;
@property (nonatomic) NSMutableArray *matrixThree;

//Outlets
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UILabel *historyTextField;

@property (weak, nonatomic) IBOutlet UILabel *labelA1;
@property (weak, nonatomic) IBOutlet UILabel *labelA2;
@property (weak, nonatomic) IBOutlet UILabel *labelA3;
@property (weak, nonatomic) IBOutlet UILabel *labelA4;
@property (weak, nonatomic) IBOutlet UILabel *labelA5;
@property (weak, nonatomic) IBOutlet UILabel *labelA6;
@property (weak, nonatomic) IBOutlet UILabel *labelA7;
@property (weak, nonatomic) IBOutlet UILabel *labelA8;
@property (weak, nonatomic) IBOutlet UILabel *labelA9;

@property (weak, nonatomic) IBOutlet UILabel *labelB1;
@property (weak, nonatomic) IBOutlet UILabel *labelB2;
@property (weak, nonatomic) IBOutlet UILabel *labelB3;
@property (weak, nonatomic) IBOutlet UILabel *labelB4;
@property (weak, nonatomic) IBOutlet UILabel *labelB5;
@property (weak, nonatomic) IBOutlet UILabel *labelB6;
@property (weak, nonatomic) IBOutlet UILabel *labelB7;
@property (weak, nonatomic) IBOutlet UILabel *labelB8;
@property (weak, nonatomic) IBOutlet UILabel *labelB9;

@property (weak, nonatomic) IBOutlet UILabel *labelC1;
@property (weak, nonatomic) IBOutlet UILabel *labelC2;
@property (weak, nonatomic) IBOutlet UILabel *labelC3;
@property (weak, nonatomic) IBOutlet UILabel *labelC4;
@property (weak, nonatomic) IBOutlet UILabel *labelC5;
@property (weak, nonatomic) IBOutlet UILabel *labelC6;
@property (weak, nonatomic) IBOutlet UILabel *labelC7;
@property (weak, nonatomic) IBOutlet UILabel *labelC8;
@property (weak, nonatomic) IBOutlet UILabel *labelC9;
@property (weak, nonatomic) IBOutlet UITextField *textField;






//Actions
- (IBAction)FillA:(id)sender;
- (IBAction)FillB:(id)sender;
- (IBAction)Addition:(id)sender;
- (IBAction)Subtraction:(id)sender;
- (IBAction)Mult:(id)sender;
- (IBAction)Div:(id)sender;
- (IBAction)MultElements:(id)sender;
- (IBAction)Determinant:(id)sender;
- (IBAction)Inverse:(id)sender;
- (IBAction)Transpose:(id)sender;
- (IBAction)dotProduct:(id)sender;
- (IBAction)crossProduct:(id)sender;
- (IBAction)ClearA:(id)sender;
- (IBAction)ClearB:(id)sender;
- (IBAction)multOddMatrix:(id)sender;
- (IBAction)EnterPressed:(id)sender;

- (void)fireAlert;
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

- (void)populateObjectArrays;
- (void)populateFinalMatrix;


//- (IBAction)FillB:(id)sender;




@end

