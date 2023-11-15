//
//  GameObject.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    
    var mesh: Mesh
    
//    var deltaPosition: Float = 0
    
    init(meshType: MeshTypes) {
        self.mesh = MeshLibrary.Mesh(meshType)
    }

    var time: Float = 0
    func update(deltaTime: Float ) {
        time += deltaTime
//        deltaPosition = cos(time)
        self.position.x = cos(time)
        updateModelConstants()
    }
    
    private func updateModelConstants() {
        modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
//        renderCommandEncoder.setTriangleFillMode(.lines)
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 1)
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.PipelineState(.Basic))
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
        
    }
}
