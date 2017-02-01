//
//  MadGeometry.swift
//  SwiftVectorTiles
//
//  Created by William Kamp on 1/22/17.
//  Copyright © 2017 William Kamp. All rights reserved.
//

import Foundation

public class MadGeometry {

    weak var owner: MadGeometry?
    let ptr: OpaquePointer
    fileprivate var wkt: String?
    fileprivate var wkb: Data?

    internal init(_ ptr: OpaquePointer, owner: MadGeometry? = nil) {
        self.ptr = ptr
        self.owner = owner
    }
    
    public func covers(other: MadGeometry) -> Bool {
        return GEOSCovers(ptr, other.ptr) == CChar("1")
    }

    public func intersection(other: MadGeometry) -> MadGeometry? {
        guard let ptr = GEOSIntersection_r(GeosContext, ptr, other.ptr) else {
            return nil
        }
        return MadGeometryFactory.madGeometry(ptr)
    }
    
    public func intersects(other: MadGeometry) -> Bool {
        return GEOSIntersects(ptr, other.ptr) == CChar("1")
    }
    
    public func empty() -> Bool {
        return GEOSisEmpty_r(GeosContext, ptr) == CChar("1")
    }
    
    public func wellKnownText() -> String? {
        if let text = wkt {
            return text
        }
        let wktWriter = GEOSWKTWriter_create_r(GeosContext)
        let wktData = GEOSWKTWriter_write_r(GeosContext, wktWriter, ptr)
        GEOSWKTWriter_destroy_r(GeosContext, wktWriter)
        if let wktData = wktData {
            wkt = String(cString: wktData)
            GEOSFree_r(GeosContext, wktData)
        }
        return wkt
    }
    
    public func wellKnownBinary() -> Data? {
        if let bin = wkb {
            return bin
        }
        let wkbWriter = GEOSWKBWriter_create_r(GeosContext)
        var size :Int = 0
        let wkbData = GEOSWKBWriter_write_r(GeosContext, wkbWriter, ptr, &size)
        GEOSWKBWriter_destroy_r(GeosContext, wkbWriter)
        if let wkbData = wkbData {
            wkb = Data(bytes: wkbData, count: size)
            GEOSFree_r(GeosContext, wkbData)
        }
        return wkb
    }
    
    public func geometryType() -> MadGeometryType {
        return MadGeometryType.typeFromPtr(ptr: ptr)
    }
    
    public func coordinateSequence() -> MadCoordinateSequence? {
        guard let seq = GEOSGeom_getCoordSeq_r(GeosContext, ptr) else {
            return nil
        }
        return MadCoordinateSequence(seq)
    }

    public func coordinates() -> [MadCoordinate] {
        guard let seq = coordinateSequence() else {
            return [MadCoordinate]()
        }

        return [MadCoordinate](seq)
    }
    
    public func transform(_ t: MadCoordinateTransform) -> Self? {
        fatalError("abstract")
    }
    
    deinit {
        if owner != nil {
            GEOSGeom_destroy_r(GeosContext, ptr)
        }
    }
    
}
