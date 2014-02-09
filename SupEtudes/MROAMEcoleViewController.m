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
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    if(_ecole != nil){
    [_name setText:(NSString *)_ecole.name];
    [_tel setText:(NSString *)_ecole.tel];
    [_adresse setText:[_ecole.lieu adresse]];
    [_cp setText:[_ecole.lieu cp]];
    [_ville setText:[_ecole.lieu ville]];
    NSString * adressLocation = [NSString stringWithFormat:@"%@ \n%@, %@",[(MROLieu *)_ecole.lieu adresse],[(MROLieu *)_ecole.lieu cp], [(MROLieu *)_ecole.lieu ville]];
        
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:adressLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTouchControl:(id)sender {
    [_adresse resignFirstResponder];
    [_ville resignFirstResponder];
    [_name resignFirstResponder];
    [_tel resignFirstResponder];
    [_cp resignFirstResponder];
}

- (IBAction)onSaveEcole:(id)sender {
    if([_adresse hasText] && [_ville hasText] && [_cp hasText] && [_name hasText]){
    MROLieu * l = [NSEntityDescription insertNewObjectForEntityForName:@"Lieu" inManagedObjectContext:[_manager managedObjectContext]];
    [l setAdresse:[_adresse text]];
    [l setVille:[_ville text]];
    [l setCp:[_cp text]];
    
    
    if(_ecole == nil){
    
    _ecole = [NSEntityDescription insertNewObjectForEntityForName:@"Ecole"
                                                 inManagedObjectContext:[_manager managedObjectContext]];
    }
    else{
    }
    [_ecole setName:[_name text]];
    [_ecole setTel:[_tel text]];
    [_ecole setLieu:l];
    
    
    [self.navigationController popViewControllerAnimated:true];
        [_manager saveContext];}
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Veuillez saisir les champs obligatoire" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
- (IBAction)onVerifAdress:(id)sender {
    if([_adresse hasText] && [_ville hasText] && [_cp hasText] && [_name hasText]){
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
        [_name resignFirstResponder];
        [_adresse resignFirstResponder];
        [_cp resignFirstResponder];
        [_ville resignFirstResponder];
        [_tel resignFirstResponder];
        [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, -30) animated:YES];
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
