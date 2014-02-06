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

@interface MROEcoleDetailsViewController : UIViewController
@property(strong,nonatomic) MROEcole * ecole;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *adresse;
@property (strong, nonatomic) IBOutlet UILabel *tel;
@property(strong,nonatomic) NSArray * avantages;
@property(strong,nonatomic) NSArray * inconvenients;
@end
