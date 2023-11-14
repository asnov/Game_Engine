//
//  Node.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class Node {
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
    }

}
