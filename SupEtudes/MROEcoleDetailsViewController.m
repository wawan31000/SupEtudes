//
//  MROEcoleDetailsViewController.m
//  SupEtudes
//
//  Created by Developer on 13/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROEcoleDetailsViewController.h"

@interface MROEcoleDetailsViewController ()

@end

@implementation MROEcoleDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [MROCoreDataManager sharedManager];
    [self setTitle:(NSString *)_ecole.name];
	// Do any additional setup after loading the view.
    [_name setText:(NSString *)_ecole.name];
    [_tel setText:(NSString *)_ecole.tel];
    for (MROInformations * info in _ecole.informations) {
       if(info.domaine == _domaine)
       {
           _information = info;
       }
    }
    [_adresse setText:[NSString stringWithFormat:@"%@ \n%@, %@",[(MROLieu *)_ecole.lieu adresse],[(MROLieu *)_ecole.lieu cp], [(MROLieu *)_ecole.lieu ville]]];
    
    [self reloadInformation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadInformation];
    [_InformationTable reloadData];
}

////////////////////////////////////////////
// Gestion Table View -- Liste des domaines
///////////////////////////////////////////
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"Avantages";
    }
    else
    {
        return @"Inconvenients";
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"EcoleAI";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if(indexPath.section == 0){
        cell.textLabel.text = [(MROAvantages *)[_avantages objectAtIndex:[indexPath row]] name] ;
    }
    else{
        cell.textLabel.text = [(MROInconvenients *)[_inconvenients objectAtIndex:[indexPath row]] name] ;
    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger nbRows = 0;
    if(section == 0) nbRows = [_avantages count];
    else nbRows = [_inconvenients count];
    NSLog(@"NB ROW : %d", nbRows);
    return nbRows;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row);
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [(MROModifEcoleDetailsViewController *)segue.destinationViewController setInformation:_information];
}

-(void)reloadInformation{
    NSFetchRequest *requesta = [[NSFetchRequest alloc] init];
    [requesta setEntity:[NSEntityDescription entityForName:@"Avantages" inManagedObjectContext:[_manager managedObjectContext]]];
    
    NSPredicate *predicatea = [NSPredicate predicateWithFormat: @"information = %@", _information];
    [requesta setPredicate:predicatea];
    _avantages = [[_manager managedObjectContext]executeFetchRequest:requesta error:nil];
    
    NSFetchRequest *requesti = [[NSFetchRequest alloc] init];
    [requesti setEntity:[NSEntityDescription entityForName:@"Inconvenients" inManagedObjectContext:[_manager managedObjectContext]]];
    
    NSPredicate *predicatei = [NSPredicate predicateWithFormat: @"information = %@", _information];
    [requesti setPredicate:predicatei];
    _inconvenients = [[_manager managedObjectContext]executeFetchRequest:requesti error:nil];
}

@end
