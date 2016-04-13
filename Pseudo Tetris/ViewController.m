//
//  ViewController.m
//  Pseudo Tetris
//
//  Created by Jeremy Ong on 12/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "ViewController.h"
#import "GameView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet GameView *gameView;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
