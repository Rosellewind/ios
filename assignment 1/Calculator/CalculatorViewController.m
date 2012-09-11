//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Roselle Milvich on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL isEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize historyLabel;
@synthesize isEnteringNumber;
@synthesize brain = _brain;

-(CalculatorBrain*)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc]init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    //see if isDoubleDecimal
    NSString *digit = sender.currentTitle;
    BOOL isDoubleDecimal = NO;
    if ([digit isEqualToString:@"."] && isEnteringNumber) {
        NSLog(@"isEqualToString");
        NSRange range = [self.display.text rangeOfString:@"."];
        if (range.location != NSNotFound)
            isDoubleDecimal = YES;
    }
    
    //display number
    if (!isDoubleDecimal) {
        if (isEnteringNumber){
            self.display.text = [self.display.text stringByAppendingString:digit];
        } else{
            self.display.text = digit;
            isEnteringNumber = YES;
        }
    }
}

- (IBAction)enterPressed 
{
    
    //display in history
    historyLabel.text = [historyLabel.text stringByAppendingFormat:@" %@",self.display.text];
    
    //push on stack
    [self.brain pushOperand:self.display.text.doubleValue];
    self.isEnteringNumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (isEnteringNumber) [self enterPressed];
    
    NSString *operation = [sender currentTitle];
    //add operation in history
    historyLabel.text = [historyLabel.text stringByAppendingFormat:@" %@",operation];
    
    double result = [self.brain performOperation:operation];
    
    //display
    self.display.text = [NSString stringWithFormat:@"%g",result];
}

- (IBAction)clearPressed {
    display.text = @"0";
    historyLabel.text = @"";
    self.isEnteringNumber = NO;
    [self.brain emptyOperands];
}


- (void)viewDidUnload {
    [self setDisplay:nil];
    [self setHistoryLabel:nil];
    [super viewDidUnload];
}
@end
