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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"domaine : %@",[_domaine name]);
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Domaine" inManagedObjectContext:[_manager managedObjectContext]]];

    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name = %@", [_domaine name]];
    [request setPredicate:predicate];
    MRODomaine * d = [[[_manager managedObjectContext]executeFetchRequest:request error:nil] firstObject];
    [[d ecoles] addObject:(MROEcole *)[_ecoles objectAtIndex:[indexPath row]]];
    [_manager saveContext];
    [[_manager managedObjectContext] save:nil];
}

/////////////////////////////////////

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MROEcoleDetailsViewController"]){
        [(MROEcoleDetailsViewController *)[segue destinationViewController] setEcole:(MROEcole *)[_ecoles objectAtIndex:[[self.EcoleTable indexPathForCell:sender] row]]];}
}


@end
