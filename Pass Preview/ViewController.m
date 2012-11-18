//
//  ViewController.m
//  Pass Preview
//
//  Created by Mustafa Ahmedani on 11/17/12.
//  Copyright (c) 2012 Mustafa Ahmedani. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, PKAddPassesViewControllerDelegate>



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
