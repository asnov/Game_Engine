//
//  Math.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class Math {
    
}

extension matrix_float4x4 {
    mutating func translate(direction: SIMD3<Float>) {
        var result = matrix_identity_float4x4
        
        let x: Float = direction.x
        let y: Float = direction.y
        let z: Float = direction.z
        
        result.columns = (
            SIMD4<Float>(1, 0, 0, 0),
            SIMD4<Float>(0, 1, 0, 0),
            SIMD4<Float>(0, 0, 1, 0),
            SIMD4<Float>(x, y, z, 1)
        )
        self = matrix_multiply(self, result)
    }
    
    mutating func scale(axis: SIMD3<Float>) {
        var result = matrix_identity_float4x4
        
        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z
        
        result.columns = (
            SIMD4<Float>(x, 0, 0, 0),
            SIMD4<Float>(0, y, 0, 0),
            SIMD4<Float>(0, 0, z, 0),
            SIMD4<Float>(0, 0, 0, 1)
        )
        self = matrix_multiply(self, result)
    }
}
