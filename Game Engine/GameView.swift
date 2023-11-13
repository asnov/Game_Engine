//
//  GameView.swift
//  Game Engine
//
//  Created by Alex on 13/11/2023.
//

import Cocoa
import MetalKit

class GameView: MTKView {
    
//    private var commandQueue: MTLCommandQueue!
//    var commandQueue: MTLCommandQueue?
    private lazy var commandQueue = makeCommandQueue()
    private lazy var renderPipelineState = createRenderPilelineState()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        self.clearColor = MTLClearColor(red: 0.43, green: 0.73, blue: 0.35, alpha: 1.0)
        self.colorPixelFormat = .bgra8Unorm
        self.commandQueue = device?.makeCommandQueue()
    }
    
    private func makeCommandQueue() -> MTLCommandQueue? {
        return device?.makeCommandQueue()
    }
    
    func createRenderPilelineState() -> MTLRenderPipelineState? {
        let library = device?.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        let renderPipelineState: MTLRenderPipelineState?
        do {
            renderPipelineState = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch let error as NSError {
            print(error)
            renderPipelineState = nil
        }
        return renderPipelineState
    }

    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable, let renderPassDescriptor = self.currentRenderPassDescriptor else {
            return
        }

        let commandBuffer = commandQueue?.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState!)

        //Send info to rendercommandencoder
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
