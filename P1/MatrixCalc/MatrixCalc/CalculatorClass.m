//
//  CalculatorClass.m
//  CalculatorClass
//
//  Created on 1/12/16.
//  Copyright (c) 2016 CMPE161. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorClass.h"

@implementation CalculatorClass

//Method implementations defined here

//Initialize variables
-(id) init{
    self = [super init];
    
    //Continue only if the super class is not nil
    if (self) {
        systemCleared = false;
        number2 = 0.0;
        _number3 = 0;
        _userInput = [[NSString alloc] init];
        history = [[NSMutableString alloc] init];
        _matrixOne = [[NSMutableArray alloc] init];
        _matrixTwo = [[NSMutableArray alloc] init];
        _finalMatrix = [[NSMutableArray alloc] init];
    }
    return self;
}

//Clear variables
-(void)clear {
    systemCleared = true;
    number2 = 0.0;
    _number3 = 0;
    _userInput = [[NSString alloc] init];
    history = [[NSMutableString alloc] init];
    _matrixOne = [[NSMutableArray alloc] init];
    _matrixTwo = [[NSMutableArray alloc] init];
    _finalMatrix = [[NSMutableArray alloc] init];
   NSLog(@"%@",@"Calculator mem cleared.");
}

//Specifying setter and getter number for double number2
//since not using @property declaration
-(void) setNumber2:(double) theNumber {
    number2 = theNumber;
}

-(double) getNumber2 {
    return number2;
}

//Save user input and other data
-(void) setData:(NSString *) userInput {
//    [_numbers addObject:[NSNumber numberWithInt:5]];
//    [_numbers addObject:[NSNumber numberWithInt:25]];
    _userInput = userInput;
    [history appendString:_userInput];
    
    //Print data to console
    NSLog(@"\nData set as follows:");
    
//    NSLog(@"\tNumbers:");
//    for (int i=0; i<[_numbers count]; i++) {
//        NSLog(@"\t%@",_numbers[i]);
//    }
    
    NSLog(@"\tUser input: %@",self.userInput);
    NSLog(@"\tHistory: %@",history);
}

-(void) add{
    
    NSNumber *sum = 0;
    
    [self.finalMatrix removeAllObjects];
    
    for (int n = 0; n < 9; n++){
        sum = @([self.matrixOne[n] intValue] + [self.matrixTwo[n] intValue]);
        [self.finalMatrix addObject:sum];
        sum = 0;
    }
}

-(void) sub{
    
    NSNumber *sub = 0;
    
    [self.finalMatrix removeAllObjects];
    
    for (int n = 0; n < 9; n++){
        sub = @([self.matrixOne[n] intValue] - [self.matrixTwo[n] intValue]);
        [self.finalMatrix addObject:sub];
        sub = 0;
    }
    
}

-(void) mult{
    
    NSNumber *product = 0;
    
    [self.finalMatrix removeAllObjects];
    
    product = @(([self.matrixOne[0] intValue] * [self.matrixTwo[0] intValue]) + ([self.matrixOne[1] intValue] * [self.matrixTwo[3] intValue]) + ([self.matrixOne[2] intValue] * [self.matrixTwo[6] intValue]));
    [self.finalMatrix addObject:product];
    product = @(([self.matrixOne[0] intValue] * [self.matrixTwo[1] intValue]) + ([self.matrixOne[1] intValue] * [self.matrixTwo[4] intValue]) + ([self.matrixOne[2] intValue] * [self.matrixTwo[7] intValue]));
    [self.finalMatrix addObject:product];
    product = @(([self.matrixOne[0] intValue] * [self.matrixTwo[2] intValue]) + ([self.matrixOne[1] intValue] * [self.matrixTwo[5] intValue]) + ([self.matrixOne[2] intValue] * [self.matrixTwo[8] intValue]));
    [self.finalMatrix addObject:product];
    product = @(([self.matrixOne[3] intValue] * [self.matrixTwo[0] intValue]) + ([self.matrixOne[4] intValue] * [self.matrixTwo[3] intValue]) + ([self.matrixOne[5] intValue] * [self.matrixTwo[6] intValue]));
    [self.finalMatrix addObject:product];
    product = @(([self.matrixOne[3] intValue] * [self.matrixTwo[1] intValue]) + ([self.matrixOne[4] intValue] * [self.matrixTwo[4] intValue]) + ([self.matrixOne[5] intValue] * [self.matrixTwo[7] intValue]));
    [self.finalMatrix addObject:product];
    product = @(([self.matrixOne[3] intValue] * [self.matrixTwo[2] intValue]) + ([self.matrixOne[4] intValue] * [self.matrixTwo[5] intValue]) + ([self.matrixOne[5] intValue] * [self.matrixTwo[8] intValue]));
    [self.finalMatrix addObject:product];
    product = @(([self.matrixOne[6] intValue] * [self.matrixTwo[0] intValue]) + ([self.matrixOne[7] intValue] * [self.matrixTwo[3] intValue]) + ([self.matrixOne[8] intValue] * [self.matrixTwo[6] intValue]));
    [self.finalMatrix addObject:product];
    product = @(([self.matrixOne[6] intValue] * [self.matrixTwo[1] intValue]) + ([self.matrixOne[7] intValue] * [self.matrixTwo[4] intValue]) + ([self.matrixOne[8] intValue] * [self.matrixTwo[7] intValue]));
    [self.finalMatrix addObject:product];
    product = @(([self.matrixOne[6] intValue] * [self.matrixTwo[2] intValue]) + ([self.matrixOne[7] intValue] * [self.matrixTwo[5] intValue]) + ([self.matrixOne[8] intValue] * [self.matrixTwo[8] intValue]));
    [self.finalMatrix addObject:product];
    
}

-(void) div{
    
    NSNumber *quotient = 0;
    
    [self.finalMatrix removeAllObjects];
    
    for(int n = 0; n < 9; n++){
        if([self.matrixTwo[n] intValue] != 0 || !isnan([self.matrixTwo[n] intValue])){
            quotient = @([self.matrixOne[n] floatValue] / [self.matrixTwo[n] floatValue]);
        }
        else{
            quotient = 0;
        }
        [self.finalMatrix addObject:quotient];
        quotient = 0;
    }
    
}

-(void) multElements{
    
    NSNumber *product = 0;
    
    [self.finalMatrix removeAllObjects];
    
    for(int n = 0; n < 9; n++){
        product = @([self.matrixOne[n] intValue] * [self.matrixTwo[n] intValue]);
        [self.finalMatrix addObject:product];
        product = 0;
    }
    
}

-(void) determinant{
    
    NSNumber *determinant = 0;
    NSString *temp = @"N/A";
    
    [self.finalMatrix removeAllObjects];
    
    determinant = @(([self.matrixOne[0] intValue]*(([self.matrixOne[4] intValue]*[self.matrixOne[8] intValue]) - ([self.matrixOne[5] intValue]*[self.matrixOne[7] intValue]))) - ([self.matrixOne[1] intValue]*(([self.matrixOne[3] intValue]*[self.matrixOne[8] intValue]) - ([self.matrixOne[5] intValue]*[self.matrixOne[6] intValue]))) + ([self.matrixOne[2] intValue]*(([self.matrixOne[3] intValue]*[self.matrixOne[7] intValue]) - ([self.matrixOne[4] intValue]*[self.matrixOne[6] intValue]))));
    
    for(int n = 0; n < 9; n++){
        
        if(n == 4){
            [self.finalMatrix addObject:determinant];
        }
        else{
            [self.finalMatrix addObject:temp];
        }
        
    }
    
    
}

-(void) inverse{
    
    [self.finalMatrix removeAllObjects];
    NSNumber *invertedNumber = 0;
    
    self.determinant;
    NSNumber *det = 0;
    
    det = @([self.finalMatrix[4] intValue]);
    [self.finalMatrix removeAllObjects];
    
    invertedNumber = @(([self.matrixOne[4] intValue]*[self.matrixOne[8] intValue])-[self.matrixOne[5] intValue]*[self.matrixOne[7] intValue]);
    [self.finalMatrix addObject:invertedNumber];
    invertedNumber = @(([self.matrixOne[2] intValue]*[self.matrixOne[7] intValue])-[self.matrixOne[1] intValue]*[self.matrixOne[8] intValue]);
    [self.finalMatrix addObject:invertedNumber];
    invertedNumber = @(([self.matrixOne[1] intValue]*[self.matrixOne[5] intValue])-[self.matrixOne[2] intValue]*[self.matrixOne[4] intValue]);
    [self.finalMatrix addObject:invertedNumber];
    invertedNumber = @(([self.matrixOne[5] intValue]*[self.matrixOne[6] intValue])-[self.matrixOne[3] intValue]*[self.matrixOne[8] intValue]);
    [self.finalMatrix addObject:invertedNumber];
    invertedNumber = @(([self.matrixOne[0] intValue]*[self.matrixOne[8] intValue])-[self.matrixOne[2] intValue]*[self.matrixOne[6] intValue]);
    [self.finalMatrix addObject:invertedNumber];
    invertedNumber = @(([self.matrixOne[2] intValue]*[self.matrixOne[3] intValue])-[self.matrixOne[0] intValue]*[self.matrixOne[5] intValue]);
    [self.finalMatrix addObject:invertedNumber];
    invertedNumber = @(([self.matrixOne[3] intValue]*[self.matrixOne[7] intValue])-[self.matrixOne[4] intValue]*[self.matrixOne[6] intValue]);
    [self.finalMatrix addObject:invertedNumber];
    invertedNumber = @(([self.matrixOne[1] intValue]*[self.matrixOne[6] intValue])-[self.matrixOne[0] intValue]*[self.matrixOne[7] intValue]);
    [self.finalMatrix addObject:invertedNumber];
    invertedNumber = @(([self.matrixOne[0] intValue]*[self.matrixOne[4] intValue])-[self.matrixOne[1] intValue]*[self.matrixOne[3] intValue]);
    [self.finalMatrix addObject:invertedNumber];
    
    for(int n = 0; n < 9; n++){
        
        self.finalMatrix[n] = @([self.finalMatrix[n] floatValue] * (1/[det floatValue]));
        
    }
    
}

-(void) transpose{
    
    NSNumber *transposeElement = 0;
    NSMutableArray *transposeArray = self.matrixTwo;
    
    [self.finalMatrix removeAllObjects];
    
    transposeElement = @([self.matrixTwo[1] intValue]);
    [self.finalMatrix addObject:@([self.matrixTwo[0] intValue])];
    [self.finalMatrix addObject:@([self.matrixTwo[3] intValue])];
    [self.finalMatrix addObject:@([self.matrixTwo[6] intValue])];
    [self.finalMatrix addObject:@([self.matrixTwo[1] intValue])];
    [self.finalMatrix addObject:@([self.matrixTwo[4] intValue])];
    [self.finalMatrix addObject:@([self.matrixTwo[7] intValue])];
    [self.finalMatrix addObject:@([self.matrixTwo[2] intValue])];
    [self.finalMatrix addObject:@([self.matrixTwo[5] intValue])];
    [self.finalMatrix addObject:@([self.matrixTwo[8] intValue])];

}

-(void) dotProduct{
    
    [self.finalMatrix removeAllObjects];
    NSString *temp = @(" N/A");
    NSNumber *dotProduct = 0;
    
    dotProduct = @(([self.matrixOne[0] intValue]*[self.matrixOne[2] intValue]) + ([self.matrixOne[3] intValue]*[self.matrixOne[5] intValue]) + ([self.matrixOne[6] intValue]*[self.matrixOne[8] intValue]));
    
    for(int n = 0; n < 9; n++){
        
        if(n == 4){
            [self.finalMatrix addObject:dotProduct];
        }
        else{
            [self.finalMatrix addObject:temp];
        }
        
    }
    
}

-(void) crossProduct{
    
    [self.finalMatrix removeAllObjects];
    
    NSString *temp = @(" N/A");
    
    NSNumber *i = 0;
    NSNumber *j = 0;
    NSNumber *k = 0;
    
    i = @(([self.matrixOne[3] intValue]*[self.matrixOne[8] intValue]) - ([self.matrixOne[5] intValue]*[self.matrixOne[6] intValue]));
    k = @(([self.matrixOne[0] intValue]*[self.matrixOne[8] intValue]) - ([self.matrixOne[2] intValue]*[self.matrixOne[6] intValue]));
    j = @(([self.matrixOne[0] intValue]*[self.matrixOne[5] intValue]) - ([self.matrixOne[2] intValue]*[self.matrixOne[3] intValue]));
    
    for(int n = 0; n < 9; n++){
        
        if(n == 1){
            [self.finalMatrix addObject:i];
        }
        else if(n == 4){
            [self.finalMatrix addObject:k];
        }
        else if(n == 7){
            [self.finalMatrix addObject:j];
        }
        else{
            [self.finalMatrix addObject:temp];
        }
        
    }
    
}

-(void) multOddMatrix{
    
    [self.finalMatrix removeAllObjects];
    
    NSString *temp = @(" N/A");
    
    NSNumber *a = 0;
    NSNumber *b = 0;
    NSNumber *c = 0;
    
    a = @(([self.matrixOne[0] intValue]*[self.matrixTwo[0] intValue]) + ([self.matrixOne[3] intValue]*[self.matrixTwo[1] intValue]) + ([self.matrixOne[6] intValue]*[self.matrixTwo[2] intValue]));
    b = @(([self.matrixOne[0] intValue]*[self.matrixTwo[3] intValue]) + ([self.matrixOne[3] intValue]*[self.matrixTwo[4] intValue]) + ([self.matrixOne[6] intValue]*[self.matrixTwo[5] intValue]));
    c = @(([self.matrixOne[0] intValue]*[self.matrixTwo[6] intValue]) + ([self.matrixOne[3] intValue]*[self.matrixTwo[7] intValue]) + ([self.matrixOne[6] intValue]*[self.matrixTwo[8] intValue]));
    
    for(int n = 0; n < 9; n++){
        
        if(n == 1){
            [self.finalMatrix addObject:a];
        }
        else if(n == 4){
            [self.finalMatrix addObject:b];
        }
        else if(n == 7){
            [self.finalMatrix addObject:c];
        }
        else{
            [self.finalMatrix addObject:temp];
        }
        
    }
    
}

//+(NSMutableArray*)multiplicationOfMatrixOne:(NSMutableArray*)matrixOne andMatrixTwo:(NSMutableArray*)matrixTwo{
//    
//    NSMutableArray *finalMatrix;
//    finalMatrix = [NSMutableArray new];
//    
//    finalMatrix.numbers[0] = ((matrixOne.numbers[0] * matrixTwo.numbers[0]) + (matrixOne.numbers[1] * matrixTwo.numbers[3]) + (matrixOne.numbers[2] * matrixTwo.numbers[6]));
//    
//    return finalMatrix;
//}


@end
