//
//  Renderer.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class Renderer: NSObject {
    public static var ScreenSize = SIMD2<Float>(repeating: 0.0)
    
    init(_ view: MTKView) {
        super.init()
        updateScreenSize(view)
    }
}

extension Renderer: MTKViewDelegate {
    
    func updateScreenSize(_ view: MTKView) {
        Renderer.ScreenSize = SIMD2<Float>(Float(view.bounds.width), Float(view.bounds.height))
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // When the window is resized
        updateScreenSize(view)
    }
    
    func draw(in view: MTKView) {
        guard
            let drawable = view.currentDrawable,
            let renderPassDescriptor = view.currentRenderPassDescriptor,
            let commandBuffer = Engine.CommandQueue.makeCommandBuffer(),
            let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else {
            return
        }

        SceneManager.TickScene(renderCommandEncoder: renderCommandEncoder, deltaTime: 1 / Float(view.preferredFramesPerSecond))
        
        //Send info to rendercommandencoder
        renderCommandEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
