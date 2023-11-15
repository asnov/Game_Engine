//
//  SandboxScene.swift
//  Game Engine
//
//  Created by Alex on 15/11/2023.
//

import MetalKit

class SandboxScene: Scene {
    
    override func buildScene() {
        for x in -3..<3 {
            for y in -3..<3 {
                let player = Player()
                player.position.x = (Float(x) + 0.5) / 3
                player.position.y = (Float(y) + 0.5) / 3
                player.scale = SIMD3<Float>(repeating: 0.1)
                addChild(player)
            }
        }
    }
    
    // This could be done on the object level
    override func update(deltaTime: Float) {
        for child in self.children {
            child.rotation.z += 0.02
        }
        super.update(deltaTime: deltaTime)
    }
    
}
