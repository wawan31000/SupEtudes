//
//  MROSearchViewController.m
//  SupEtudes
//
//  Created by Developer on 17/12/13.
//  Copyright (c) 2013 Maxime Roch. All rights reserved.
//

#import "MROSearchViewController.h"

@interface MROSearchViewController ()

@end

@implementation MROSearchViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	_manager = [MROCoreDataManager sharedManager];
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Ecole"];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@" %@ IN domaines", _domaine];
    //[fr setPredicate:predicate];
    _ecoles = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Ecole"];
    _ecoles = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
    [_EcoleTable reloadData];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *managedObject = [_ecoles objectAtIndex:[indexPath row]];
        [[_manager managedObjectContext] deleteObject:managedObject];
        [_manager saveContext];
        NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Ecole"];
        _ecoles = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
        [_EcoleTable reloadData];
    }
}

////////////////////////////////////////////
// Gestion Table View -- Liste des domaines
///////////////////////////////////////////
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"EcoleSearch";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [(MROEcole *)[_ecoles objectAtIndex:[indexPath row]] name];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_ecoles count];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    //[self performSegueWithIdentifier:@"SelectEcole" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Domaine" inManagedObjectContext:[_manager managedObjectContext]]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name = %@", [_domaine name]];
    [request setPredicate:predicate];
    MRODomaine * d = [[[_manager managedObjectContext]executeFetchRequest:request error:nil] firstObject];
    [[d ecoles] addObject:(MROEcole *)[_ecoles objectAtIndex:[indexPath row]]];

    //ecoles in domaaine
    //[_domaine.ecoles addObject:[_ecoles objectAtIndex:[indexPath row]]];
    //////////////
        
    //[[[_ecoles objectAtIndex:[indexPath row]] domaines] addObject:_domaine];
    
    MROInformations * e = [NSEntityDescription insertNewObjectForEntityForName:@"Informations" inManagedObjectContext:[_manager managedObjectContext]];
    [e setDomaine:_domaine];
    [[[_ecoles objectAtIndex:[indexPath row]] informations] addObject:e];
    //[_manager saveContext];
    NSError *error = nil;
    if (![_manager.managedObjectContext save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
    }
    [self.navigationController popViewControllerAnimated:TRUE ];
}



/////////////////////////////////////

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SelectEcole"]){
        [(MROSelectEcoleViewController *)[segue destinationViewController] setEcole:(MROEcole *)[_ecoles objectAtIndex:[[self.EcoleTable indexPathForCell:sender] row]]];
        [(MROSelectEcoleViewController *)[segue destinationViewController] setDomaine:(MRODomaine *)_domaine];
    }
}


@end
