//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Roselle Milvich on 7/10/12.
//  Copyright (c) 2012 Roselle Milvich. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain
@synthesize programStack = _programStack;
-(NSMutableArray*)operandStack
{
if (!_programStack)
    _programStack = [[NSMutableArray alloc]init];
    return _programStack;
}

-(void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

-(void)emptyOperands
{
    [self.programStack removeAllObjects];
}

-(double)performOperation:(NSString*)operation
{
    [self.programStack addObject:operation];
    [CalculatorBrain runProgram:self.program];
    
    double result = 0;
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"x"]){
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]){
        double secondOperand = [self popOperand];
        result = [self popOperand] - secondOperand;
    } else if ([operation isEqualToString:@"/"]){
        double secondOperand = [self popOperand];
        if (secondOperand) result = [self popOperand] / secondOperand;
    } else if ([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]);
    } else if ([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
    } else if ([operation isEqualToString:@"pi"]){
        result = M_PI;
    }
    [self pushOperand:result];
    return result;
}
@end
