//
//  MROSelectEcoleViewController.m
//  SupEtudes
//
//  Created by Developer on 20/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROSelectEcoleViewController.h"

@interface MROSelectEcoleViewController ()

@end

@implementation MROSelectEcoleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [MROCoreDataManager sharedManager];
    
    //Affiche les données de l'école sur les label en question
    [self setTitle:(NSString *)_ecole.name];
	[_name setText:(NSString *)_ecole.name];
    [_tel setText:(NSString *)_ecole.tel];
    [_adresse setText:[NSString stringWithFormat:@"%@ \n%@, %@",[(MROLieu *)_ecole.lieu adresse],[(MROLieu *)_ecole.lieu cp], [(MROLieu *)_ecole.lieu ville]]];
    
    //Place un marqueur qui localise l'école en fonction de son adresse
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:[_adresse text] completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            CLPlacemark *placemark = [placemarks lastObject];
            Location *l = [[Location alloc] initWithName:[_ecole name] address:[_adresse text] coordinate:placemark.location.coordinate];
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


//Suite à la modification, retour de segue, réaffiche les bonnes informations de l'école
-(void) viewWillAppear:(BOOL)animated{
    [self setTitle:(NSString *)_ecole.name];
    [_name setText:(NSString *)_ecole.name];
    [_tel setText:(NSString *)_ecole.tel];
    [_adresse setText:[NSString stringWithFormat:@"%@ \n%@, %@",[(MROLieu *)_ecole.lieu adresse],[(MROLieu *)_ecole.lieu cp], [(MROLieu *)_ecole.lieu ville]]];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:[_adresse text] completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            CLPlacemark *placemark = [placemarks lastObject];
            Location *l = [[Location alloc] initWithName:[_ecole name] address:[_adresse text] coordinate:placemark.location.coordinate];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Passage de l'école pour modification
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [(MROAMEcoleViewController *)[segue destinationViewController] setEcole:_ecole];
    
}

@end
