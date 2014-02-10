//
//  MROModifEcoleDetailsViewController.m
//  SupEtudes
//
//  Created by Developer on 20/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROModifEcoleDetailsViewController.h"

@interface MROModifEcoleDetailsViewController ()

@end

@implementation MROModifEcoleDetailsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [MROCoreDataManager sharedManager];
    _typeInfo = [NSArray arrayWithObjects:@"Avantage",@"Inconvenient", nil];
    [self reloadInformation];
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

// Affiche les avantages & inconvénients pour l'école

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
    return nbRows;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row);
}


//Affichage d'une alertview custom affichant un champ texte et un picker pour l'ajout d'information
- (IBAction)AddInformation:(id)sender {
    CustomIOS7AlertView * alertView = [[CustomIOS7AlertView alloc]init];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 270, 20)];
    [title setText:@"Nouvelle Information"];
    [view addSubview:title];
    
    _infoName = [[UITextField alloc]initWithFrame:CGRectMake(15, 60, 270, 40)];
    _infoName.borderStyle = UITextBorderStyleRoundedRect;
    _infoName.autocorrectionType = UITextAutocorrectionTypeNo;
    _infoName.keyboardType = UIKeyboardTypeDefault;
    _infoName.returnKeyType = UIReturnKeyDone;
    _infoName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _infoName.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:_infoName];
    
     _pw = [[UIPickerView alloc]initWithFrame:CGRectMake(15, 70, 270, 100)];
    _pw.showsSelectionIndicator = YES;
    _pw.hidden = NO;
    _pw.delegate = self;
    [view addSubview:_pw];
    [alertView setContainerView:view];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Annuler", @"Enregistrer", nil]];
    [alertView setDelegate:self];
    [alertView setUseMotionEffects:true];
    [alertView show];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return (NSString *)[_typeInfo objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _pwSelectedIndex = &row;
}

//Ajout de l'information (onClick) dans le core data
-(void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1){
        if(![[[_infoName text] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]){
        if([_pw selectedRowInComponent:0] == 0){
            MROAvantages * er = [NSEntityDescription insertNewObjectForEntityForName:@"Avantages" inManagedObjectContext:[_manager managedObjectContext]];
            [er setName:_infoName.text];
            [er setInformation:_information];
            
        }
        else
        {
            MROInconvenients * ite = [NSEntityDescription insertNewObjectForEntityForName:@"Inconvenients" inManagedObjectContext:[_manager managedObjectContext]];
            [ite setName:_infoName.text];
            
            [ite setInformation:_information];
        }
        [_manager.managedObjectContext save:nil];
        [self reloadInformation];
        [_InformationTable reloadData];
        }
        else
        {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Veuillez saisir les champs obligatoire" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
        }
    }
    [alertView close];
}

   -(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath { return @"Supprimer"; }


//Supprimer une information
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(indexPath.section == 0){
        NSManagedObject *managedObject = [_avantages objectAtIndex:[indexPath row]];
        [[_manager managedObjectContext] deleteObject:managedObject];
        [_manager saveContext];
        }
        else{
            NSManagedObject *managedObject = [_inconvenients objectAtIndex:[indexPath row]];
            [[_manager managedObjectContext] deleteObject:managedObject];
            [_manager saveContext];
        }
        [self reloadInformation];
        [_InformationTable reloadData];
    }
}


// Requete sur core data pour récuperer les informations
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
