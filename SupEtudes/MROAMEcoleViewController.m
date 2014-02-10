//
//  MROAMEcoleViewController.m
//  SupEtudes
//
//  Created by Developer on 07/02/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROAMEcoleViewController.h"

@interface MROAMEcoleViewController ()

@end

@implementation MROAMEcoleViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [MROCoreDataManager sharedManager];
    
    //ResignFirstResponder on TableView
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    //Modification d'une école passer en Segue
    if(_ecole != nil){
    [_name setText:(NSString *)_ecole.name];
    [_tel setText:(NSString *)_ecole.tel];
    [_adresse setText:[_ecole.lieu adresse]];
    [_cp setText:[_ecole.lieu cp]];
    [_ville setText:[_ecole.lieu ville]];
    NSString * adressLocation = [NSString stringWithFormat:@"%@ \n%@, %@",[(MROLieu *)_ecole.lieu adresse],[(MROLieu *)_ecole.lieu cp], [(MROLieu *)_ecole.lieu ville]];
        
        
        //Localisation de l'école sur la Map
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:adressLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                
                //Ajout d'une annotation en fonction de l'adresse
                CLPlacemark *placemark = [placemarks lastObject];
                Location *l = [[Location alloc] initWithName:[_ecole name] address:adressLocation coordinate:placemark.location.coordinate];
                [_Map addAnnotation:l];
                float spanX = 0.00725;
                float spanY = 0.00725;
                MKCoordinateRegion region;
                region.center.latitude = placemark.location.coordinate.latitude;
                region.center.longitude = placemark.location.coordinate.longitude;
                region.span = MKCoordinateSpanMake(spanX, spanY);
                [_Map setRegion:region animated:YES];
            }}];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Retire le clavier en touchant le UIControl
- (IBAction)onTouchControl:(id)sender {
    [self hideKeyboard];
}

- (IBAction)onSaveEcole:(id)sender {
    //Condition pour whitespace
    if(![[[_adresse text] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] && ![[[_ville text] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] && ![[[_cp text] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] && ![[[_name text] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]){
        
        //Création d'une école de le core data
    MROLieu * l = [NSEntityDescription insertNewObjectForEntityForName:@"Lieu" inManagedObjectContext:[_manager managedObjectContext]];
    [l setAdresse:[_adresse text]];
    [l setVille:[_ville text]];
    [l setCp:[_cp text]];
    
    
    if(_ecole == nil){
    
    _ecole = [NSEntityDescription insertNewObjectForEntityForName:@"Ecole"
                                                 inManagedObjectContext:[_manager managedObjectContext]];
    }

    [_ecole setName:[_name text]];
    [_ecole setTel:[_tel text]];
    [_ecole setLieu:l];
    
    
    [self.navigationController popViewControllerAnimated:true];
        [_manager saveContext];}
    else{
        //AlertView Erreur
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Veuillez saisir les champs obligatoire" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

//Vérification adresse -- Affiche sur la carte un pointeur vers l'adresse
- (IBAction)onVerifAdress:(id)sender {
     if(![[[_adresse text] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] && ![[[_ville text] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] && ![[[_cp text] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] && ![[[_name text] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]){
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSString * adresseLoc = [NSString stringWithFormat:@"%@ \n%@, %@",[_adresse text],[_cp text], [_ville text]];
    [geocoder geocodeAddressString:adresseLoc completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            CLPlacemark *placemark = [placemarks lastObject];
            
            Location *l = [[Location alloc] initWithName:[_name text] address:adresseLoc coordinate:placemark.location.coordinate];
            [_Map addAnnotation:l];
            float spanX = 0.00725;
            float spanY = 0.00725;
            MKCoordinateRegion region;
            region.center.latitude = placemark.location.coordinate.latitude;
            region.center.longitude = placemark.location.coordinate.longitude;
            region.span = MKCoordinateSpanMake(spanX, spanY);
            [_Map setRegion:region animated:YES];
        }}];
         [self hideKeyboard];
         [_EcoleTable scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
     else{
         UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Les champs concernant l'adresse est obligatoire" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }

    

}

- (void) hideKeyboard {
    [_name resignFirstResponder];
    [_adresse resignFirstResponder];
    [_cp resignFirstResponder];
    [_ville resignFirstResponder];
    [_tel resignFirstResponder];
    
}
@end
