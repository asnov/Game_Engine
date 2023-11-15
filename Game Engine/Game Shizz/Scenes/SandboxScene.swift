//
//  SandboxScene.swift
//  Game Engine
//
//  Created by Alex on 15/11/2023.
//

import MetalKit

class SandboxScene: Scene {
    
    let player = Player()

    override func buildScene() {
        addChild(player)
    }
    
}
