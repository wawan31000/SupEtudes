//
//  MROEcoleViewController.h
//  SupEtudes
//
//  Created by Developer on 17/12/13.
//  Copyright (c) 2013 Maxime Roch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MROEcole.h"
#import "MROCoreDataManager.h"
#import "MRODomaine.h"
#import "MROSearchViewController.h"

@interface MROEcoleViewController : UIViewController
@property (strong, nonatomic) MROCoreDataManager *manager;
@property(strong,nonatomic) MRODomaine * domaineinmanager;
@property(strong,nonatomic) NSArray * ecoles;
@property(strong,nonatomic)NSMutableArray * selectedEcoles;
@property (strong, nonatomic) IBOutlet UITableView *EcoleTable;
@property (strong, nonatomic) MRODomaine * domaine;
-(void) reloadEcole;
@end
