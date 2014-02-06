//
//  MROModifEcoleDetailsViewController.h
//  SupEtudes
//
//  Created by Developer on 20/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MROInformations.h"
#import "MROAvantages.h"
#import "MROInconvenients.h"
#import "CustomIOS7AlertView.h"
@interface MROModifEcoleDetailsViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,CustomIOS7AlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *InformationTable;
@property(strong,nonatomic) MROInformations * information;
@property(strong,nonatomic) NSArray * avantages;
@property(strong,nonatomic)NSArray * inconvenients;
@property(strong,nonatomic)NSArray * typeInfo;
@property(strong,nonatomic)UITextField *infoName;
@property(strong,nonatomic)UIPickerView *pw;
- (IBAction)AddInformation:(id)sender;
@end
