//
//  MROSelectEcoleViewController.m
//  SupEtudes
//
//  Created by Developer on 20/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROSelectEcoleViewController.h"

@interface MROSelectEcoleViewController ()

@end

@implementation MROSelectEcoleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[_name setText:_ecole.name];
    [_tel setText:_ecole.tel];
    [_lieu setText:[_ecole.lieu toString]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
