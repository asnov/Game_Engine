//
//  Node.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class Node {
    
    var position: SIMD3<Float> = SIMD3<Float>()

    var modelMatrix: matrix_float4x4 {
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.translate(direction: position)
        return modelMatrix
    }

    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
    }

}
