//
//  MROEcole.h
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MROLieu.h"

@interface MROEcole : NSObject
@property(strong,nonatomic) NSString * name;
@property(strong,nonatomic) NSString * tel;
@property(strong,nonatomic) NSMutableArray * lieux;
@property(strong, nonatomic) NSMutableArray * domaines;
- (id)initWithName:(NSString *) newname andTel:(NSString *) newtel andLieu:(NSMutableArray *) lieux;

@end