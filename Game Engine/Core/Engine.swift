//
//  Engine.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

class Engine {
    
    public static var Device: MTLDevice!    // FIXME
    public static var CommandQueue: MTLCommandQueue!
    
    public static func Ignite(device: MTLDevice?) {
        self.Device = device
        
//        private var commandQueue: MTLCommandQueue!
//        var commandQueue: MTLCommandQueue?
        self.CommandQueue = device?.makeCommandQueue()
        
        ShaderLibrary.Initialize()
        VertexDescriptorLibrary.Initialize()
        DepthStencilStateLibrary.Initialize()
        RenderPipelineDescriptorLibrary.Initialize()
        RenderPipelineStateLibrary.Initialize()
        
        MeshLibrary.Initialize()
        SceneManager.Initialize(Preferences.StartingSceneType)
    }
}
