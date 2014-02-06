//
//  MROInformations.h
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MROAvantages.h"
#import "MROInconvenients.h"
#import "MRODomaine.h"

@class MRODomaine;
@interface MROInformations : NSObject

@property (nonatomic) int note;
@property(strong,nonatomic) NSMutableArray * avantages;
@property(strong,nonatomic) NSMutableArray * inconvenients;
@property(strong,nonatomic) MRODomaine * domaine;
- (id)initWithNote:(int) newNote;

@end
