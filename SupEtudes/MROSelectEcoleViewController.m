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
    _manager = [MROCoreDataManager sharedManager];
    [self setTitle:(NSString *)_ecole.name];
	[_name setText:(NSString *)_ecole.name];
    [_tel setText:(NSString *)_ecole.tel];
    [_adresse setText:[NSString stringWithFormat:@"%@ \n%@, %@",[(MROLieu *)_ecole.lieu adresse],[(MROLieu *)_ecole.lieu cp], [(MROLieu *)_ecole.lieu ville]]];
   
}

-(void) viewWillAppear:(BOOL)animated{
    [self setTitle:(NSString *)_ecole.name];
    [_name setText:(NSString *)_ecole.name];
    [_tel setText:(NSString *)_ecole.tel];
    [_adresse setText:[NSString stringWithFormat:@"%@ \n%@, %@",[(MROLieu *)_ecole.lieu adresse],[(MROLieu *)_ecole.lieu cp], [(MROLieu *)_ecole.lieu ville]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [(MROAMEcoleViewController *)[segue destinationViewController] setEcole:_ecole];
    
}

@end
