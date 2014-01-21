//
//  MRODomaine.m
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MRODomaine.h"

@implementation MRODomaine


- (id)initWithName:(NSString *) newname
{
    self = [super init];
    if (self)  {
        _name = newname;
    }
    return self;
}
@end
