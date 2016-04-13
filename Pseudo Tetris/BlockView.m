//
//  BlockView.m
//  Pseudo Tetris
//
//  Created by Jeremy Ong on 12/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "BlockView.h"

@implementation BlockView

+(BlockView*)initWithRandomColor{
	CGFloat red = ((float)rand() / RAND_MAX);
	CGFloat green = ((float)rand() / RAND_MAX);
	CGFloat blue = ((float)rand() / RAND_MAX);
	UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
	BlockView *temp = [[BlockView alloc] init];
	temp.backgroundColor = color;
	return temp;
}

@end
