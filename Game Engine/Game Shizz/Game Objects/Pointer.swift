//
//  Pointer.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class Pointer: GameObject  {
    
    private var camera: Camera
    init(camera: Camera) {
        self.camera = camera
        super.init(meshType: .HighTriangleCustom)
    }
    
    override func update(deltaTime: Float) {
        self.rotation.z = -atan2f(Mouse.GetMouseViewportPosition().x - position.x + camera.position.x,
                                  Mouse.GetMouseViewportPosition().y - position.y + camera.position.y)
        super.update(deltaTime: deltaTime)
    }
}
