//
//  MROLieu.m
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROLieu.h"

@implementation MROLieu
- (id)initWithAdresse:(NSString*) newAdresse andVille:(NSString*) newVille andCP:(NSString *)newCP
{
    self = [super init];
    if (self) {
        _adresse=newAdresse;
        _ville=newVille;
        _cp = newCP;
        _ecoles = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
