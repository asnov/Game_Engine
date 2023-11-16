//
//  GameObject.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    private var material = Material()
    
    var mesh: Mesh
    
//    var deltaPosition: Float = 0
    
    init(meshType: MeshTypes) {
        self.mesh = MeshLibrary.Mesh(meshType)
    }

    override func update(deltaTime: Float) {
        updateModelConstants()
    }
    
    private func updateModelConstants() {
        modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
//        renderCommandEncoder.setTriangleFillMode(.lines)
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.PipelineState(.Basic))
        renderCommandEncoder.setDepthStencilState(DepthStencilStateLibrary.DepthStencilState(.Less))
        
        // Vertex shader
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        // Fragment shader
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
        
    }
}

// Material properties
extension GameObject {
    public func setColor(_ color: SIMD4<Float>) {
        self.material.color = color
        self.material.useMaterialColor = true
    }
}
