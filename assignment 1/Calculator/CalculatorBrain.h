//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Roselle Milvich on 7/10/12.
//  Copyright (c) 2012 Roselle Milvich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void)pushOperand:(double)operand;
-(double)popOperand;
-(void)emptyOperands;
-(double)performOperation:(NSString*)operation;

@property (readonly) id program; 

+(double)runProgram:(id)program;
+(NSString*)descriptionOfProgram:(id)program;

@end
