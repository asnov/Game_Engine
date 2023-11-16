//
//  Player.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class Player: GameObject  {
    
    init() {
        super.init(meshType: .HighTriangleCustom)
    }
    
    override func update(deltaTime: Float) {
        self.rotation.z = -atan2f(Mouse.GetMouseViewportPosition().x - position.x, Mouse.GetMouseViewportPosition().y - position.y)
        super.update(deltaTime: deltaTime)
    }
}
