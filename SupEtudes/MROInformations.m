//
//  MROInformations.m
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROInformations.h"

@implementation MROInformations

- (id)initWithNote:(int) newNote
{
    self = [super init];
    if (self) {
        _note=newNote;
    }
    return self;
}
@end
