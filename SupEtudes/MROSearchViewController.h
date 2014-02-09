//
//  MROSearchViewController.h
//  SupEtudes
//
//  Created by Developer on 17/12/13.
//  Copyright (c) 2013 Maxime Roch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MROCoreDataManager.h"
#import "MROEcole.h"
#import "MRODomaine.h"
#import "MROInformations.h"
#import "MROEcoleDetailsViewController.h"
#import "MROSelectEcoleViewController.h"
#import "SBJson.h"
#import <MapKit/MapKit.h>

@interface MROSearchViewController : UIViewController
- (IBAction)onEscape:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *SearchBar;
- (IBAction)onSearch:(UITextField *)sender;
@property (strong, nonatomic) MROCoreDataManager *manager;
@property (strong, nonatomic) NSArray * ecoles;
@property (strong, nonatomic) IBOutlet UITableView *EcoleTable;
@property(strong,nonatomic) MRODomaine * domaine;
-(void)fetchJson;
-(void)SaveEcoleInManagedContext:(NSString *)nom adresse:(NSString *)adress cp:(NSString *)cp ville:(NSString *)ville;
@end
