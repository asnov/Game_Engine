//
//  GameView.swift
//  Game Engine
//
//  Created by Alex on 13/11/2023.
//

import simd
import MetalKit

class GameView: MTKView {
    
    private lazy var renderer: Renderer = Renderer()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        Engine.Ignite(device: device)
        self.clearColor = Preferences.ClearColor
        self.colorPixelFormat = Preferences.MainPixelFormat
        self.delegate = renderer
    }
    
    // Mouse input
    
    // Keyboard input
    
}
