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
    if(_ecole != nil){
    [_name setText:(NSString *)_ecole.name];
    [_tel setText:(NSString *)_ecole.tel];
    [_adresse setText:[_ecole.lieu adresse]];
    [_cp setText:[_ecole.lieu cp]];
    [_ville setText:[_ecole.lieu ville]];
    }
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
    if([_adresse hasText] && [_ville hasText] && [_cp hasText] && [_name hasText]){
    MROLieu * l = [NSEntityDescription insertNewObjectForEntityForName:@"Lieu" inManagedObjectContext:[_manager managedObjectContext]];
    [l setAdresse:[_adresse text]];
    [l setVille:[_ville text]];
    [l setCp:[_cp text]];
    
    
    if(_ecole == nil){
    
    _ecole = [NSEntityDescription insertNewObjectForEntityForName:@"Ecole"
                                                 inManagedObjectContext:[_manager managedObjectContext]];
    }
    else{
    }
    [_ecole setName:[_name text]];
    [_ecole setTel:[_tel text]];
    [_ecole setLieu:l];
    
    
    [self.navigationController popViewControllerAnimated:true];
        [_manager saveContext];}
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Veuillez saisir les champs obligatoire" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
@end
