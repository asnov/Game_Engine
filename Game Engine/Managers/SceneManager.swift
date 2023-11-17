//
//  SceneManager.swift
//  Game Engine
//
//  Created by Alex on 15/11/2023.
//

import MetalKit

enum SceneTypes {
    case Sandbox
    case Sandbox3D
    case ManyCubes
}

class SceneManager {
    
    public static var _currentScene: Scene! // FIXME: !
    
    public static func Initialize(_ sceneType: SceneTypes) {
        SetScene(sceneType)
    }
    
    public static func SetScene(_ sceneType: SceneTypes) {
        switch sceneType {
        case .Sandbox:
            _currentScene = SandboxScene()
        case .Sandbox3D:
            _currentScene = SandboxScene3D()
        case .ManyCubes:
            _currentScene = ManyCubesScene()
        }
    }
    
    public static func TickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        _currentScene.update(deltaTime: deltaTime)
        _currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}
