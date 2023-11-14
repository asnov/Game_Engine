//
//  Renderable.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

protocol Renderable {
     
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder)

}
