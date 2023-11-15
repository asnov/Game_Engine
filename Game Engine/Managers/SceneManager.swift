//
//  SceneManager.swift
//  Game Engine
//
//  Created by Alex on 15/11/2023.
//

import MetalKit

enum SceneTypes {
    case Sandbox
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
        }
    }
    
    public static func TickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        _currentScene.update(deltaTime: deltaTime)
        _currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}