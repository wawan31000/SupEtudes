//
//  MROEcoleDetailsViewController.h
//  SupEtudes
//
//  Created by Developer on 13/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MROEcole.h"
#import "MROModifEcoleDetailsViewController.h"
#import "MROCoreDataManager.h"
#import "MRODomaine.h"
#import "MROInformations.h"
#import "Location.h"
#import <MapKit/MapKit.h>

@interface MROEcoleDetailsViewController : UIViewController<MKMapViewDelegate>
@property(strong,nonatomic) MROCoreDataManager* manager;
@property(strong,nonatomic) MROEcole * ecole;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *adresse;
@property (strong, nonatomic) IBOutlet UILabel *tel;
@property(strong,nonatomic) NSArray * avantages;
@property(strong,nonatomic) NSArray * inconvenients;
@property(strong,nonatomic) MROInformations * information;
@property(strong,nonatomic) MRODomaine * domaine;
@property (strong, nonatomic) IBOutlet UITableView *InformationTable;
@property (strong, nonatomic) IBOutlet MKMapView *Map;
@property (strong, nonatomic) NSMutableDictionary *placeDictionary;
-(void)reloadInformation;
@end
