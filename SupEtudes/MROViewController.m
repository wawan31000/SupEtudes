//
//  MROViewController.m
//  SupEtudes
//
//  Created by Developer on 17/12/13.
//  Copyright (c) 2013 Maxime Roch. All rights reserved.
//

#import "MROViewController.h"
#include "MROCoreDataManager.h"
#include "MRODomaine.h"

@interface MROViewController ()

@end

@implementation MROViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MROCoreDataManager * _manager = [MROCoreDataManager sharedManager];
    NSManagedObjectModel *managedObjectModel = [_manager managedObjectModel];
    NSEntityDescription *theEntity = [[managedObjectModel entitiesByName] objectForKey:@"Domaine"];
    NSManagedObject *newObject = [[NSManagedObject alloc]initWithEntity:theEntity
                                         insertIntoManagedObjectContext:[_manager managedObjectContext]];
    MRODomaine * d = [NSEntityDescription insertNewObjectForEntityForName:@"Domaine"
                                                inManagedObjectContext:[_manager managedObjectContext]];
    [d setName:@"Informatique"];
    [_manager saveContext];
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Domaine"];
    NSArray * _domaines = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
    NSLog(@"count : %lu", _domaines.count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addDomain:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nouveau Domaine" message:@"Saisir le nom du domaine:" delegate:self cancelButtonTitle:@"Annuler"
        otherButtonTitles:@"Enregistrer", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1)
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
}


////////////////////////////////////////////
// Gestion Table View -- Liste des domaines
///////////////////////////////////////////
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"Domain";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = @"test";
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
}

/////////////////////////////////////


@end
