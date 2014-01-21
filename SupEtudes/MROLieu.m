//
//  MROLieu.m
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROLieu.h"

@implementation MROLieu
- (id)initWithAdresse:(NSString*) newAdresse andVille:(NSString*) newVille
{
    self = [super init];
    if (self) {
        _adresse=newAdresse;
        _ville=newVille;
    }
    return self;
}
@end
