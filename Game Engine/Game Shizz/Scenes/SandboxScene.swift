//
//  SandboxScene.swift
//  Game Engine
//
//  Created by Alex on 15/11/2023.
//

import MetalKit

class SandboxScene: Scene {
    
    override func buildScene() {
        for x in -2..<2 {
            for y in -2..<2 {
                let player = Player()
                player.position.x = (Float(x) + 0.5) / 2
                player.position.y = (Float(y) + 0.5) / 2
                player.scale = SIMD3<Float>(repeating: 0.1)
                addChild(player)
            }
        }
    }
    
    // This could be done on the object level
    override func update(deltaTime: Float) {
        for child in self.children {
            child.rotation.z += 0.001
        }
        let child = children[0]
        child.rotation.z += 0.01
        
        if(Keyboard.isKeyPressed(.rightArrow)) {
            child.position.x += deltaTime
        }
        if(Keyboard.isKeyPressed(.leftArrow)) {
            child.position.x -= deltaTime
        }
        if(Keyboard.isKeyPressed(.upArrow)) {
            child.position.y += deltaTime
        }
        if(Keyboard.isKeyPressed(.downArrow)) {
            child.position.y -= deltaTime
        }
        
        super.update(deltaTime: deltaTime)
    }
    
}
