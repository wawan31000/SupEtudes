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

@interface MROSelectEcoleViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *adresse;
@property (strong, nonatomic) IBOutlet UILabel *tel;
@property(strong,nonatomic) MROEcole * ecole;
@property(strong,nonatomic) MRODomaine * domaine;
@property (strong, nonatomic) MROCoreDataManager *manager;
- (IBAction)onSelect:(id)sender;
@property(strong,nonatomic) MROLieu * lieu;
@end
