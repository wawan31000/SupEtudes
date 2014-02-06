//
//  MROEcole.h
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MROLieu.h"
#import "MROInformations.h"

@interface MROEcole : NSObject
@property(strong,nonatomic) NSString * name;
@property(strong,nonatomic) NSString * tel;
@property(strong,nonatomic) MROLieu * lieu;
@property(strong, nonatomic) NSMutableArray * domaines;
@property(strong,nonatomic) MROInformations * information;
- (id)initWithName:(NSString *) newname andTel:(NSString *) newtel andLieu:(MROLieu *) newlieu;

@end
