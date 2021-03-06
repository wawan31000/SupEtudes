//
//  MROSelectEcoleViewController.h
//  SupEtudes
//
//  Created by Developer on 20/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MROEcole.h"
#import "MROCoreDataManager.h"
#import "MROLieu.h"
#import "MRODomaine.h"
#import "MROEcoleViewController.h"
#import "MROAMEcoleViewController.h"
#import <MapKit/MapKit.h>
#import "Location.h"

@interface MROSelectEcoleViewController : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *adresse;
@property (strong, nonatomic) IBOutlet UILabel *tel;
@property(strong,nonatomic) MROEcole * ecole;
@property(strong,nonatomic) MRODomaine * domaine;
@property (strong, nonatomic) MROCoreDataManager *manager;
@property(strong,nonatomic) MROLieu * lieu;
@property (strong, nonatomic) IBOutlet MKMapView *Map;
@property (strong, nonatomic) NSMutableDictionary *placeDictionary;
@end
