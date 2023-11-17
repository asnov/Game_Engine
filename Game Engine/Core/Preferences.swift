//
//  Preferences.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

public enum ClearColors {
    static let White = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let Gree_ = MTLClearColor(red: 0.22, green: 0.55, blue: 0.34, alpha: 1.0)
    static let Green = MTLClearColor(red: 0.43, green: 0.73, blue: 0.35, alpha: 1.0)
    static let Grey = MTLClearColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    static let LightGrey = MTLClearColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
    static let Black = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1)
}

class Preferences {

    public static var ClearColor: MTLClearColor = ClearColors.LightGrey
    
    public static var MainPixelFormat: MTLPixelFormat = MTLPixelFormat.bgra8Unorm
    
    public static var MainDepthPixelFormat: MTLPixelFormat = MTLPixelFormat.depth32Float
    
    public static var StartingSceneType: SceneTypes = SceneTypes.ManyCubes
}
