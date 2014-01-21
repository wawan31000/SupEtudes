//
//  MROLieu.h
//  SupEtudes
//
//  Created by Developer on 21/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MROLieu : NSObject
@property(strong,nonatomic) NSString * adresse;
@property(strong,nonatomic) NSString * ville;
- (id)initWithAdresse:(NSString*) newAdresse andVille:(NSString*) newVille;
@end
