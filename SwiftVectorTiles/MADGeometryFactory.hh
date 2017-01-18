//
//  MADGeometryFactory.h
//  SwiftVectorTiles
//
//  Created by William Kamp on 1/18/17.
//  Copyright © 2017 William Kamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADGeometry.hh"

@interface MADGeometryFactory : NSObject

+(MADGeometry* ) geometryWithWellKnownText:(NSString *)text;
+(MADGeometry* ) geometryWithWellKnownBinary:(NSData *)data;

@end
