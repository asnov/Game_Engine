//
//  GameObject.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class GameObject {
    
    private lazy var vertices: [Vertex] = createVertices()
    private lazy var vertexBuffer: MTLBuffer? = createBuffer()
    
    private func createVertices() -> [Vertex] {
        [
            Vertex(position: SIMD3<Float>( 0,  1, 0), color: SIMD4<Float>(1, 0, 0, 1)),
            Vertex(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 1, 0, 1)),
            Vertex(position: SIMD3<Float>( 1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)),
        ]
    }
    
    private func createBuffer() -> MTLBuffer? {
        Engine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.PipelineState(.Basic))
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
}
