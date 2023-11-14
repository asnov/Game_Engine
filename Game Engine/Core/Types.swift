//
//  Types.swift
//  Game Engine
//
//  Created by Alex on 13/11/2023.
//

import simd

//public typealias _float2 = SIMD2＜Float＞
//public typealias _float3 = SIMD3＜Float＞
//public typealias _float4 = SIMD4＜Float＞

protocol sizable { }

extension sizable {
    static var size: Int {
        MemoryLayout<Self>.size
    }
    
    static var stride: Int {
        MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int) -> Int {
        MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int) -> Int {
        MemoryLayout<Self>.stride * count
    }
}

extension SIMD3: sizable { }

struct Vertex: sizable {
    var position: SIMD3<Float>
    var color: SIMD4<Float>
}
