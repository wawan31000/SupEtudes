//
//  MROInconvenients.m
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROInconvenients.h"


@implementation MROInconvenients

- (id)initWithName:(NSString *) newName AndInformation:(MROInformations *)info
{
    self = [super init];
    if (self) {
        _name=newName;
        _information = info;
    }
    return self;
}
@end
