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
    
//    private var commandQueue: MTLCommandQueue!
//    var commandQueue: MTLCommandQueue?
    private lazy var commandQueue = makeCommandQueue()
    private lazy var renderPipelineState = createRenderPilelineState()

    private lazy var vertices: [Vertex] = createVertices()
    private lazy var vertexBuffer = createBuffer()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        self.clearColor = MTLClearColor(red: 0.43, green: 0.73, blue: 0.35, alpha: 1.0)
        self.colorPixelFormat = .bgra8Unorm
        self.commandQueue = device?.makeCommandQueue()
    }
    
    private func createVertices() -> [Vertex] {
        [
            Vertex(position: SIMD3<Float>( 0,  1, 0), color: SIMD4<Float>(1, 0, 0, 1)),
            Vertex(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 1, 0, 1)),
            Vertex(position: SIMD3<Float>( 1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)),
        ]
    }
    
    private func makeCommandQueue() -> MTLCommandQueue? {
        return device?.makeCommandQueue()
    }
    
    func createRenderPilelineState() -> MTLRenderPipelineState? {
        let library = device?.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "vertex_shader2")
        let fragmentFunction = library?.makeFunction(name: "fragment_shader")
        
        let vertexDescriptor = MTLVertexDescriptor()
        
        // Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        // Color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = SIMD3<Float>.size
        
        vertexDescriptor.layouts[0].stride = Vertex.stride
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        let renderPipelineState: MTLRenderPipelineState?
        do {
            renderPipelineState = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch let error as NSError {
            print(error)
            renderPipelineState = nil
        }
        return renderPipelineState
    }

    private func createBuffer() -> MTLBuffer? {
        return device?.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable, let renderPassDescriptor = self.currentRenderPassDescriptor else {
            return
        }

        let commandBuffer = commandQueue?.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState!)
        
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count) 

        //Send info to rendercommandencoder
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
