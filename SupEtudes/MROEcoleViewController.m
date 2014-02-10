//
//  MROEcoleViewController.m
//  SupEtudes
//
//  Created by Developer on 17/12/13.
//  Copyright (c) 2013 Maxime Roch. All rights reserved.
//

#import "MROEcoleViewController.h"

@interface MROEcoleViewController ()

@end

@implementation MROEcoleViewController

//Affichage des écoles en fonction du domaine
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:(NSString *)_domaine.name];
    _manager = [MROCoreDataManager sharedManager];
    _selectedEcoles = [[NSMutableArray alloc]init];
    [self reloadEcole];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated{
    _selectedEcoles = [[NSMutableArray alloc]init];
    [self reloadEcole];
}


////////////////////////////////////////////
// Gestion Table View -- Liste des écoles
///////////////////////////////////////////
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"Ecole";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    //NSLog(@"test name : %@", [[array objectAtIndex:0] name]);

    
    cell.textLabel.text = [(MROEcole *)[_selectedEcoles objectAtIndex:[indexPath row]] name];
    cell.detailTextLabel.text = [(MROLieu *)[(MROEcole *)[_selectedEcoles objectAtIndex:[indexPath row]] lieu] ville];
    //cell.textLabel.text = @"test";
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_selectedEcoles count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

/////////////////////////////////////

//Double segue -- Condition en fonction du segue appelé
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Search"])
       [(MROSearchViewController *)[segue destinationViewController] setDomaine:_domaine];
    if([segue.identifier isEqualToString:@"EcoleDetails"]){
        [(MROEcoleDetailsViewController *)[segue destinationViewController] setEcole:(MROEcole *)[_selectedEcoles objectAtIndex:[[self.EcoleTable indexPathForCell:sender] row]]];
        [(MROEcoleDetailsViewController *)[segue destinationViewController] setDomaine:(MRODomaine *)_domaineinmanager];
    }
}

   -(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath { return @"Supprimer"; }

//Supression d'une école dans un domaine
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [(NSMutableArray *)[_domaineinmanager ecoles] removeObject:[_selectedEcoles objectAtIndex:[indexPath row]]];
        [_manager saveContext];
        [self reloadEcole];
        [_EcoleTable reloadData];
    }
}


//Chargement des écoles dans un domaine dans un array pour affichage dans la tableView
-(void)reloadEcole{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Domaine" inManagedObjectContext:[_manager managedObjectContext]]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name = %@", [_domaine name]];
    [request setPredicate:predicate];
    _domaineinmanager = [[[_manager managedObjectContext]executeFetchRequest:request error:nil] firstObject];
    NSLog(@"%d",[[_domaineinmanager ecoles] count]) ;
    NSSet * a = [[_domaineinmanager ecoles] copy];
    _selectedEcoles = a.allObjects;

    [_EcoleTable reloadData];

}

@end
