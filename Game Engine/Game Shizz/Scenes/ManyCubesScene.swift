//
//  ManyCubesScene.swift
//  Game Engine
//
//  Created by Alex on 16/11/2023.
//

import MetalKit

class ManyCubesScene: Scene {
    var debugCamera: Camera = DebugCamera()
    
    override func buildScene() {
        addCamera(debugCamera)
        
        debugCamera.position.z = 13
        
        addCubes()
    }
    
    func addCubes() {
        for x in -8..<8 {
            let posX = Float(x) + 0.5
            for y in -5..<5 {
                let posY = Float(y) + 0.5
                let cube = Cube()
                cube.position.x = posX
                cube.position.y = posY
                cube.scale = SIMD3<Float>(repeating: 0.3)
                cube.setColor(ColorUtil.randomColor)
                addChild(cube)
            }
        }
    }
}
