//
//  MRODomaine.h
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MROInformations.h"

@interface MRODomaine : NSObject
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSMutableArray * ecoles;
@property(strong,nonatomic)NSMutableArray * informations;
- (id)initWithName:(NSString *) newname;
@end
