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
    
    override var acceptsFirstResponder: Bool { true }
    
    // Mouse input
    
    // Keyboard input
    override func keyDown(with event: NSEvent) {
        Keyboard.SetKeyPressed(event.keyCode, isOn: true)
    }
    
    override func keyUp(with event: NSEvent) {
        Keyboard.SetKeyPressed(event.keyCode, isOn: false)
    }
    
}
