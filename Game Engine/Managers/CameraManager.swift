//
//  CameraManager.swift
//  Game Engine
//
//  Created by Alex on 16/11/2023.
//

class CameraManager {
    // Strategy pattern
    private let defaultCamera: DebugCamera = DebugCamera()
    private var _cameras: [CameraTypes: Camera] = [:]
    public var currentCamera: Camera
    
    init() {
        currentCamera = defaultCamera
    }

    public func registerCamera(camera: Camera) {
        _cameras.updateValue(camera, forKey: camera.cameraType)
    }
    
    public func setCamera(_ cameraType: CameraTypes) {
        self.currentCamera = _cameras[cameraType, default: defaultCamera]
    }
    
    internal func update(deltaTime: Float) {
        for camera in _cameras.values {
            camera.update(deltaTime: deltaTime)
        }
    }
}
