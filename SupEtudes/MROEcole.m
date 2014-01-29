//
//  MROEcole.m
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROEcole.h"

@implementation MROEcole

- (id)initWithName:(NSString *) newname andTel:(NSString *) newtel andLieu:(NSMutableArray *)lieux
{
    self = [super init];
    if (self) {
        _name = newname;
        _tel = newtel;
        _lieux = [[NSMutableArray alloc] init];
        _domaines = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
