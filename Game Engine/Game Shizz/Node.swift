//
//  Node.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class Node {
    
    var position = SIMD3<Float>(repeating: 0.0)
    var scale = SIMD3<Float>(repeating: 1.0)
    var rotation = SIMD3<Float>(repeating: 0)

    var modelMatrix: matrix_float4x4 {
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.translate(direction: position)
        modelMatrix.rotate(angle: rotation.x, axis: X_AXIS)
        modelMatrix.rotate(angle: rotation.y, axis: Y_AXIS)
        modelMatrix.rotate(angle: rotation.z, axis: Z_AXIS)
        modelMatrix.scale(axis: scale)
        return modelMatrix
    }

    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
    }

}
