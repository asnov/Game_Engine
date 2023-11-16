//
//  Scene.swift
//  Game Engine
//
//  Created by Alex on 15/11/2023.
//

import MetalKit

class Scene: Node {

    var cameraManager = CameraManager()
    var sceneConstants = SceneConstants()
    
    override init() {
        super.init()
        buildScene()
    }
    
    func buildScene() { }
    
    func addCamera(_ camera: Camera, _ isCurrentCamera: Bool = true) {
        cameraManager.registerCamera(camera: camera)
        if(isCurrentCamera) {
            cameraManager.setCamera(camera.cameraType)  // TODO: move this to CameraManager
        }
    }
    
    private func updateSceneConstants() {
        sceneConstants.viewMatrix = cameraManager.currentCamera.viewMatrix
        sceneConstants.projectionMatrix = cameraManager.currentCamera.projectionMatrix
    }
    
    private func updateCameras(deltaTime: Float) {
        cameraManager.update(deltaTime: deltaTime)
    }
    
    override func update(deltaTime: Float) {
        updateCameras(deltaTime: deltaTime)
        updateSceneConstants()
        super.update(deltaTime: deltaTime)
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
}
