//
//  MROModifEcoleViewController.m
//  SupEtudes
//
//  Created by Developer on 20/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROModifEcoleViewController.h"

@interface MROModifEcoleViewController ()

@end

@implementation MROModifEcoleViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
     _manager = [MROCoreDataManager sharedManager];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTouchControl:(id)sender {
    [_adresse resignFirstResponder];
    [_ville resignFirstResponder];
    [_name resignFirstResponder];
    [_tel resignFirstResponder];
    [_cp resignFirstResponder];
}

- (IBAction)onSaveEcole:(id)sender {
    MROLieu * l = [NSEntityDescription insertNewObjectForEntityForName:@"Lieu" inManagedObjectContext:[_manager managedObjectContext]];
    [l setAdresse:[_adresse text]];
    [l setVille:[_ville text]];
    [l setCp:[_cp text]];
    
    MROEcole * d = [NSEntityDescription insertNewObjectForEntityForName:@"Ecole"
                                                 inManagedObjectContext:[_manager managedObjectContext]];
    [d setName:[_name text]];
    [d setTel:[_tel text]];
    [d setLieu:l];
    
    NSLog(@"%@",d.lieu);
    
    [_manager saveContext];
}
@end
