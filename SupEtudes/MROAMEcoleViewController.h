//
//  MROAMEcoleViewController.h
//  SupEtudes
//
//  Created by Developer on 07/02/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MROCoreDataManager.h"
#import "MRODomaine.h"
#import "MROLieu.h"
#import "MROEcole.h"

@interface MROAMEcoleViewController : UITableViewController
@property (strong, nonatomic) MROCoreDataManager *manager;
@property (strong, nonatomic) NSArray * ecoles;
@property (strong, nonatomic) MRODomaine * domaine;
@property(strong,nonatomic) MROLieu * lieu;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *adresse;
@property (strong, nonatomic) IBOutlet UITextField *cp;
@property (strong, nonatomic) IBOutlet UITextField *ville;
@property (strong, nonatomic) IBOutlet UITextField *tel;
- (IBAction)onTouchControl:(id)sender;

- (IBAction)onSaveEcole:(id)sender;
@end
