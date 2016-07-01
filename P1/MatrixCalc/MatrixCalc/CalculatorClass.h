//
//  CalculatorClass.h
//  CalculatorClass
//
//  Created on 1/12/16.
//  Copyright (c) 2016 CMPE161. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef Calculator_CalculatorClass_h
#define Calculator_CalculatorClass_h
@interface CalculatorClass : NSObject
{
    bool systemCleared;
    double number2;
    NSMutableString* history;
}

//Property declarations
@property NSMutableArray* matrixOne;
@property NSMutableArray* matrixTwo;
@property NSMutableArray* finalMatrix;
@property NSString* userInput;
@property int number3;


//Method declarations
-(id)init;
-(void)clear;
-(void)setNumber2:(double)theNumber;
-(double)getNumber2;
-(void)setData:(NSString*)userInput;

-(void)add;
-(void)sub;
-(void)mult;
-(void)div;
-(void)multElements;
-(void)determinant;
-(void)inverse;
-(void)transpose;
-(void)dotProduct;
-(void)crossProduct;
-(void)multOddMatrix;

//+(CalculatorClass*)transpose;
//+(CalculatorClass*)determinant;
//+(NSMutableArray*)multiplicactionOfMatrixOne:(NSMutableArray*)matrixOne andMatrixTwo:(NSMutableArray*)matrixTwo;
//+(CalculatorClass*)subtract;
//+(NSMutableArray*)addidtionOfMatrixOne: (NSMutableArray*)matrixOneandMatrixTwo: (NSMutableArray*)matrixTwo;
//+(CalculatorClass*)divide;
//+(CalculatorClass*)dotProduct;
//+(CalculatorClass*)crossProduct;
//+(CalculatorClass*)fill;

@end
#endif
