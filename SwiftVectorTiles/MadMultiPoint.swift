//
//  MadMultiPoing.swift
//  SwiftVectorTiles
//
//  Created by William Kamp on 1/25/17.
//  Copyright © 2017 William Kamp. All rights reserved.
//

import Foundation

public protocol MultiPoint : MultiGeometry {

}

internal class GeosMultiPoint : GeosMultiGeometry, MultiPoint {
    
}
