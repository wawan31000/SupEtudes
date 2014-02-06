//
//  MROAvantages.h
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MROInformations.h"
#import "MROCoreDataManager.h"

@class MROInformations;
@interface MROAvantages : NSObject

@property (strong, nonatomic) NSString * name;
@property (nonatomic,retain) MROInformations * information;

- (id)initWithName:(NSString *) newName AndInformation:(MROInformations *)info;
@end
