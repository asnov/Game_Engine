//
//  SandboxScene3D.swift
//  Game Engine
//
//  Created by Alex on 16/11/2023.
//

import MetalKit

class SandboxScene3D: Scene {
    var debugCamera: Camera = DebugCamera()
    
    let cube = Cube()
    
    override func buildScene() {
        addCamera(debugCamera)
        
        debugCamera.position.z = 1
        
        cube.scale = SIMD3<Float>(repeating: 0.2)
        addChild(cube)
    }
    
    // This could be done on the object level
    override func update(deltaTime: Float) {
        cube.rotation.x += deltaTime
        cube.rotation.y += deltaTime / 2
        cube.rotation.z += deltaTime / 4
        
        if(Mouse.IsMouseButtonPressed(button: .left)) {
            cube.rotation.x += 0.02
        }
        if(Mouse.IsMouseButtonPressed(button: .right)) {
            cube.rotation.y += 0.02
        }
        
        super.update(deltaTime: deltaTime)
    }
    
}
