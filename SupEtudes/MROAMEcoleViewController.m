//
//  MROAMEcoleViewController.m
//  SupEtudes
//
//  Created by Developer on 07/02/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROAMEcoleViewController.h"

@interface MROAMEcoleViewController ()

@end

@implementation MROAMEcoleViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [MROCoreDataManager sharedManager];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    [self.navigationController popViewControllerAnimated:true];
    [_manager saveContext];
}
@end
