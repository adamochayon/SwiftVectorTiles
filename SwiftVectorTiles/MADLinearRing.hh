//
//  MADPolygon.h
//  SwiftVectorTiles
//
//  Created by William Kamp on 1/17/17.
//  Copyright © 2017 William Kamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADGeometry.hh"

@interface MADLinearRing : MADGeometry

-(BOOL) isCCW;
-(MADLinearRing *)reverse;

@end
