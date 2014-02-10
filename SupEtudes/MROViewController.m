//
//  MROViewController.m
//  SupEtudes
//
//  Created by Developer on 17/12/13.
//  Copyright (c) 2013 Maxime Roch. All rights reserved.
//

#import "MROViewController.h"

@interface MROViewController ()

@end

@implementation MROViewController


//Affichage des domaines  ou  ajout d'un domaine par défaut si aucun domaine
- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [MROCoreDataManager sharedManager];
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Domaine"];
    _domaines = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
    if([_domaines count] == 0)
    {
        MRODomaine * d = [NSEntityDescription insertNewObjectForEntityForName:@"Domaine"
                                                       inManagedObjectContext:[_manager managedObjectContext]];
        
        [d setName:@"Default"];
        [_manager saveContext];
        NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Domaine"];
        _domaines = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
        [_DomainTable reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Domaine"];
    _domaines = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
    [_manager saveContext];
    [_DomainTable reloadData];
}

//Lancement d'une AlertView permettant d'enregistrer un nouveau domaine
- (IBAction)addDomain:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nouveau Domaine" message:@"Saisir le nom du domaine:" delegate:self cancelButtonTitle:@"Annuler"
        otherButtonTitles:@"Enregistrer", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}


//Validation de l'alertView -- Ajout du domaine dans core data // Sécurisation du NSString envoyé
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1)
    {
        NSString * field = [[[alertView textFieldAtIndex:0] text] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if(![field isEqualToString:@""])
        {
        MRODomaine * d = [NSEntityDescription insertNewObjectForEntityForName:@"Domaine"
                                                       inManagedObjectContext:[_manager managedObjectContext]];
        
        [d setName:[[alertView textFieldAtIndex:0] text]];
        [_manager saveContext];
        NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Domaine"];
        _domaines = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
        [_DomainTable reloadData];
        }
        else{
            UIAlertView * alertError = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Saisir le champ" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] ;
            [alertError show];
        }
    }
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
    cell.textLabel.text = [(MRODomaine *)[_domaines objectAtIndex:[indexPath row]] name];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_domaines count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

   -(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath { return @"Supprimer"; }

//Suppression d'un domaine
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       NSManagedObject *managedObject = [_domaines objectAtIndex:[indexPath row]];
        [[_manager managedObjectContext] deleteObject:managedObject];
        [_manager saveContext];
        NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Domaine"];
        _domaines = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
        [_DomainTable reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [(MROEcoleViewController *)[segue destinationViewController] setDomaine:(MRODomaine *)[_domaines objectAtIndex:[[self.DomainTable indexPathForCell:sender] row]]];
}


/////////////////////////////////////


@end
