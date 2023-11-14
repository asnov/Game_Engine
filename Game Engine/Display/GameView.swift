//
//  GameView.swift
//  Game Engine
//
//  Created by Alex on 13/11/2023.
//

import simd
import MetalKit

//public typealias _float2 = SIMD2＜Float＞
//public typealias _float3 = SIMD3＜Float＞
//public typealias _float4 = SIMD4＜Float＞

class GameView: MTKView {
    
    struct Vertex: sizable {
        var position: SIMD3<Float>
        var color: SIMD4<Float>
    }
    
    private lazy var vertices: [Vertex] = createVertices()
    private lazy var vertexBuffer: MTLBuffer? = createBuffer()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        Engine.Ignite(device: device)
        self.clearColor = Preferences.ClearColor
        self.colorPixelFormat = Preferences.MainPixelFormat
    }
    
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
    
    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable, let renderPassDescriptor = self.currentRenderPassDescriptor else {
            return
        }

        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        renderCommandEncoder?.setRenderPipelineState(RenderPipelineStateLibrary.PipelineState(.Basic))
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count) 

        //Send info to rendercommandencoder
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
