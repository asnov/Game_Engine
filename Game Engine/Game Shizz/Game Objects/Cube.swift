//
//  Cube.swift
//  Game Engine
//
//  Created by Alex on 16/11/2023.
//

import MetalKit

class Cube: GameObject {
    
    init() {
        super.init(meshType: .CubeConTriangle)
    }
    
    override func update(deltaTime: Float) {
        self.rotation.x += (Float.randomZeroToOne * deltaTime)
        self.rotation.y += (Float.randomZeroToOne * deltaTime)
        super.update(deltaTime: deltaTime)
    }
}
