//
//  GameView.m
//  Pseudo Tetris
//
//  Created by Jeremy Ong on 12/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "GameView.h"

@interface GameView() <UIDynamicAnimatorDelegate>
@property UIDynamicAnimator *animator;
@property UIGravityBehavior *behavior;
@property UICollisionBehavior *collision;
@property UIDynamicItemBehavior *dynamicBehavior;
@property NSMutableArray *blocks;
@end

@implementation GameView


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if (self){
		[self addAnimatorsBehaviors];
		self.blocks = [[NSMutableArray alloc] init];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dropBlock)];
		[self addGestureRecognizer:tap];
	}
	return self;
}

- (void)dropBlock{
	BlockView *block = [self returnBlockWithRandomPosition];
	[self addSubview:block];
	[self.blocks addObject:block];
	[self.dynamicBehavior addItem:block];
	[self.behavior addItem:block];
	[self.collision addItem:block];
}

- (BlockView*)returnBlockWithRandomPosition{
	BlockView *block = [BlockView initWithRandomColor];
	CGFloat blockWidth = self.frame.size.width / 10;
	int randomNum = arc4random_uniform(10);
	CGFloat randomPosition = blockWidth * randomNum;
	block.frame = CGRectMake(randomPosition, 0, blockWidth, blockWidth);
	return block;
}

- (CGPoint)CGRectCenter:(CGRect)rect{
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

- (void)addAnimatorsBehaviors{
	self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
	self.behavior = [[UIGravityBehavior alloc] init];
	self.collision = [[UICollisionBehavior alloc]
										init];
	self.dynamicBehavior = [[UIDynamicItemBehavior alloc] init];
	self.animator.delegate = self;
	self.dynamicBehavior.allowsRotation = NO;
	self.collision.translatesReferenceBoundsIntoBoundary = YES;
	[self.animator addBehavior:self.behavior];
	[self.animator addBehavior:self.dynamicBehavior];
	[self.animator addBehavior:self.collision];
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
	NSMutableArray *blockYPoints = [[NSMutableArray alloc] init];
	CGFloat filledYPoint = 0.0;
	for (BlockView *block in self.blocks) {
		int blockCenterPoint = (int)([self CGRectCenter:block.frame].y/40);
		[blockYPoints addObject:[NSNumber numberWithInt:(int)blockCenterPoint]];
	}
	NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:blockYPoints];
	for (NSNumber *num in countedSet){
		if ([countedSet countForObject:num] == 10){
			filledYPoint = [num floatValue];
		}
	}
	NSMutableArray *mutableBlocks = [self.blocks mutableCopy];
	for (BlockView *block in self.blocks) {
		if ((int)([self CGRectCenter:block.frame].y/40) == (int)filledYPoint){
			[UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
				[mutableBlocks removeObject:block];
				[self.dynamicBehavior removeItem:block];
				[self.behavior removeItem:block];
				[self.collision removeItem:block];
				[block removeFromSuperview];
			} completion:nil];
		}
	}
	self.blocks = mutableBlocks;
}

@end
