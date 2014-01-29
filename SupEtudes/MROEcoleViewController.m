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
    _manager = [MROCoreDataManager sharedManager];
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Ecole"];
    _ecoles = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
    for (MROEcole *object in _ecoles) {
        if([[object domaines] containsObject:_domaine])
        {
            [_selectedEcoles addObject:object];
        }
    }

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
    
    cell.textLabel.text = [(MROEcole *)[_selectedEcoles objectAtIndex:[indexPath row]] name];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_selectedEcoles count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",[indexPath row]);
}

/////////////////////////////////////


@end
