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


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:(NSString *)_domaine.name];
    _manager = [MROCoreDataManager sharedManager];
    _selectedEcoles = [[NSMutableArray alloc]init];
    [self reloadEcole];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewWillAppear:(BOOL)animated{
    //[_manager saveContext];
    _selectedEcoles = [[NSMutableArray alloc]init];
    [self reloadEcole];
}


////////////////////////////////////////////
// Gestion Table View -- Liste des domaines
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
    //cell.textLabel.text = @"test";
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_selectedEcoles count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

/////////////////////////////////////

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Search"])
       [(MROSearchViewController *)[segue destinationViewController] setDomaine:_domaine];
    if([segue.identifier isEqualToString:@"EcoleDetails"]){
        [(MROEcoleDetailsViewController *)[segue destinationViewController] setEcole:(MROEcole *)[_selectedEcoles objectAtIndex:[[self.EcoleTable indexPathForCell:sender] row]]];
        [(MROEcoleDetailsViewController *)[segue destinationViewController] setDomaine:(MRODomaine *)_domaineinmanager];
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [(NSMutableArray *)[_domaineinmanager ecoles] removeObject:[_selectedEcoles objectAtIndex:[indexPath row]]];
        [_manager saveContext];
        [self reloadEcole];
        [_EcoleTable reloadData];
    }
}

-(void)reloadEcole{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Domaine" inManagedObjectContext:[_manager managedObjectContext]]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name = %@", [_domaine name]];
    [request setPredicate:predicate];
    _domaineinmanager = [[[_manager managedObjectContext]executeFetchRequest:request error:nil] firstObject];
    NSLog(@"%d",[[_domaineinmanager ecoles] count]) ;
    NSSet * a = [[_domaineinmanager ecoles] copy];
    _selectedEcoles = a.allObjects;
    //_selectedEcoles = (NSArray *)[_domaineinmanager ecoles];
    
    
    /*NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Ecole" inManagedObjectContext:[_manager managedObjectContext]]];
    
    
    _ecoles = [[_manager managedObjectContext]executeFetchRequest:request error:nil];
    NSLog(@"%@",[(MROEcole *)[_ecoles objectAtIndex:0] domaines]);
    for (MROEcole * ecole in _ecoles) {
        if([(NSMutableArray *)ecole.domaines containsObject:_domaine])
        {
            [_selectedEcoles addObject:ecole];
        }
    }*/
    
   // NSLog(@"%@",_selectedEcoles);
    [_EcoleTable reloadData];

}

@end
