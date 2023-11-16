//
//  SandboxScene.swift
//  Game Engine
//
//  Created by Alex on 15/11/2023.
//

import MetalKit

class SandboxScene: Scene {
    let debugCamera: Camera = DebugCamera()

    override func buildScene() {
        addCamera(debugCamera)

        let ball = Ball()
        ball.position.x = 0
        ball.position.y = 0
        ball.scale = SIMD3<Float>(repeating: 0.1)
        addChild(ball)

        let count: Int = 2
        for x in -count..<count {
            for y in -count..<count {
                let pointer = Pointer(camera: debugCamera)
                pointer.position.x = (Float(x) + 0.5) / Float(count)
                pointer.position.y = (Float(y) + 0.5) / Float(count)
                pointer.scale = SIMD3<Float>(repeating: 0.1)
                addChild(pointer)
            }
        }
    }
    
    // This could be done on the object level
    override func update(deltaTime: Float) {
//        print(Mouse.GetMouseWindowPosition())
//        print(Mouse.GetMouseViewportPosition())
        for child in self.children {
            child.rotation.z += 0.001
        }
        let child = children[0]
        
        if(Mouse.IsMouseButtonPressed(button: .left)) {
            child.rotation.z += 0.02
        }
        if(Mouse.IsMouseButtonPressed(button: .right)) {
            child.rotation.z -= 0.02
        }
        
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
