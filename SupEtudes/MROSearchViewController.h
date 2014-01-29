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

@interface MROSearchViewController : UIViewController
@property (strong, nonatomic) MROCoreDataManager *manager;
@property (strong, nonatomic) NSArray * ecoles;
@property(strong,nonatomic) MRODomaine * domaine;
@end
