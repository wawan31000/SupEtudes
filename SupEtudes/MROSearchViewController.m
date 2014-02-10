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

    //Affichage de toutes les écoles par défaut
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Ecole"];
    _ecoles = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Vider bar de recherche / Recharger les informations par défaut
-(void)viewWillAppear:(BOOL)animated{
    [_SearchBar setText:@""];
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Ecole"];
    _ecoles = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
    [_EcoleTable reloadData];
}

//Thread permettant d'ajouter les écoles du fichier JSON sans freezer l'appli (Si aucune école ajoutée)
-(void)viewDidAppear:(BOOL)animated{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        if([_ecoles count]==0){
            [self fetchJson];
        }
    });

}

//Suppresion d'une école

   -(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath { return @"Supprimer"; }

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
// Gestion Table View -- Liste des écoles
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
    cell.detailTextLabel.text = [(MROLieu *)[(MROEcole *)[_ecoles objectAtIndex:[indexPath row]] lieu] ville];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_ecoles count];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    //[self performSegueWithIdentifier:@"SelectEcole" sender:self];
}

// Ajout d'une école dans un domaine et création d'un objet informations lié entre le domaine et l'école
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Domaine" inManagedObjectContext:[_manager managedObjectContext]]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name = %@", [_domaine name]];
    [request setPredicate:predicate];
    MRODomaine * d = [[[_manager managedObjectContext]executeFetchRequest:request error:nil] firstObject];
    [[d ecoles] addObject:(MROEcole *)[_ecoles objectAtIndex:[indexPath row]]];
    
    MROInformations * e = [NSEntityDescription insertNewObjectForEntityForName:@"Informations" inManagedObjectContext:[_manager managedObjectContext]];
    [e setDomaine:_domaine];
    [[[_ecoles objectAtIndex:[indexPath row]] informations] addObject:e];
    [_manager saveContext];
    NSError *error = nil;
    if (![_manager.managedObjectContext save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
    }
    [self.navigationController popViewControllerAnimated:TRUE ];
}



/////////////////////////////////////

//Passage a d'autre viewController // Condition correspondant au segue appelé
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SelectEcole"]){
        [(MROSelectEcoleViewController *)[segue destinationViewController] setEcole:(MROEcole *)[_ecoles objectAtIndex:[[self.EcoleTable indexPathForCell:sender] row]]];
        [(MROSelectEcoleViewController *)[segue destinationViewController] setDomaine:(MRODomaine *)_domaine];
    }
}

//Récuperation du JSON et enregistrement des écoles
-(void)fetchJson{
    
    //Récupération du fichier JSON en local
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"listEcole" ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:nil error:NULL];
    if (!myJSON) {
        NSLog(@"File couldn't be read!");
        return;
    }
    //Parsage du JSON à l'aide du framework importé
    NSArray *json    = [myJSON JSONValue];
    
    for (NSDictionary *ecole in json)
    {
        
        //Transformation des données de coordonnées en adresse via l'API Google Maps
        NSString * gpsx =[[ecole objectForKey:@"GPS_X"] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        NSString * gpsy =[[ecole objectForKey:@"GPS_Y"] stringByReplacingOccurrencesOfString:@"," withString:@"."];
        
        NSString *urlAsString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=false", gpsx,gpsy];
        NSURL *url = [[NSURL alloc] initWithString:urlAsString];
        
        //Formatage du JSON de l'API Google Maps et récupération des données nécessaires
        NSString * jsonMap = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
        NSDictionary *jsonMapEncode = [jsonMap JSONValue];

        NSString * formatedadress;
        NSDictionary *result = [jsonMapEncode objectForKey:@"results"];
        for (NSDictionary *t in result) {
            formatedadress = [t objectForKey:@"formatted_address"];
            
            //Récupération de l'adresse en fonction d'un adresse formatée // Split permettant de récuperer les bonnes informations dans la donnée en NSString
            NSArray * address = [formatedadress componentsSeparatedByString:@","];
            NSString * adresseText = [address objectAtIndex:0];
            NSArray * villecp = [[address objectAtIndex:1] componentsSeparatedByString:@" "];
            NSString * cpText = [villecp objectAtIndex:1];
            NSString * villeText;
            
            //Récupération du nom de la ville pouvant posséder des espaces
            if([villecp count]>=3)
            {
            villeText =[villecp objectAtIndex:2];
                if([villecp count] > 3){
            for (int i = 3; i<[villecp count]; i++) {
                villeText = [villeText stringByAppendingString:[NSString stringWithFormat:@" %@",[villecp objectAtIndex:i]]];
            }
                }
            }
            
            //Thread permettant l'ajout des écoles dans le core data
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                     (unsigned long)NULL), ^(void) {
                [self SaveEcoleInManagedContext:[ecole objectForKey:@"SIGLE_ETABLISSEMENT"] adresse:adresseText cp:cpText ville:villeText];
                
            });
            

            break;
        }

       }
}

//Sauvegarde d'une école dans le core data + Reload des données dans la tableView
-(void)SaveEcoleInManagedContext:(NSString *)nom adresse:(NSString *)adress cp:(NSString *)cp ville:(NSString *)ville{
        MROLieu * l = [NSEntityDescription insertNewObjectForEntityForName:@"Lieu" inManagedObjectContext:[_manager managedObjectContext]];
        [l setAdresse:adress];
        [l setVille:ville];
        [l setCp:cp];
    
            
        MROEcole *  ecole = [NSEntityDescription insertNewObjectForEntityForName:@"Ecole"
                                                   inManagedObjectContext:[_manager managedObjectContext]];
        [ecole setName:nom];
        [ecole setLieu:l];
    
        [_manager saveContext];
    
        NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Ecole"];
        _ecoles = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
        [_EcoleTable reloadData];
    }

- (IBAction)onEscape:(id)sender {
    [_SearchBar resignFirstResponder];
}

// Requete des écoles en fonction du texte envoyé via la barre de recherche + Reload
- (IBAction)onSearch:(UITextField *)sender {
    
    NSFetchRequest * fr = [NSFetchRequest fetchRequestWithEntityName:@"Ecole"];
    if([sender hasText]){
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name beginswith[c] %@", [sender text]];
        [fr setPredicate:predicate];
    }
    _ecoles = [[_manager managedObjectContext]executeFetchRequest:fr error:nil];
    [_EcoleTable reloadData];
    
}
@end
