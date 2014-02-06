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
    NSLog(@"%@",[_domaine name]);
    _manager = [MROCoreDataManager sharedManager];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Domaine" inManagedObjectContext:[_manager managedObjectContext]]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name = %@", [_domaine name]];
    [request setPredicate:predicate];
    _domaineinmanager = [[[_manager managedObjectContext]executeFetchRequest:request error:nil] firstObject];
    NSLog(@"count ecole : %d", [[_domaineinmanager ecoles] count]);
    NSSet * a = [[_domaineinmanager ecoles] copy];
    _selectedEcoles = a.allObjects;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
    return [[_domaineinmanager ecoles]  count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

/////////////////////////////////////

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Search"])
       [(MROSearchViewController *)[segue destinationViewController] setDomaine:_domaineinmanager];
    if([segue.identifier isEqualToString:@"EcoleDetails"])
        [(MROEcoleDetailsViewController *)[segue destinationViewController] setEcole:(MROEcole *)[_selectedEcoles objectAtIndex:[[self.EcoleTable indexPathForCell:sender] row]]];
}

@end
