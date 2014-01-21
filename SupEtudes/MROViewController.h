//
//  MROViewController.h
//  SupEtudes
//
//  Created by Developer on 17/12/13.
//  Copyright (c) 2013 Maxime Roch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MROCoreDataManager.h"
#import "MRODomaine.h"
#import "MROEcoleViewController.h"

@interface MROViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *DomainTable;
@property (strong, nonatomic) MROCoreDataManager *manager;
@property (strong, nonatomic) NSArray * domaines;
- (IBAction)addDomain:(id)sender;
@end
