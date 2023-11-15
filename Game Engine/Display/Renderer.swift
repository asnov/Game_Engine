//
//  Renderer.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class Renderer: NSObject {
    
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // When the window is resized
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
