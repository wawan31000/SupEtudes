//
//  MROSelectEcoleViewController.h
//  SupEtudes
//
//  Created by Developer on 20/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MROEcole.h"

@interface MROSelectEcoleViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *lieu;
@property (strong, nonatomic) IBOutlet UILabel *tel;
@property(strong,nonatomic) MROEcole * ecole;
@end
