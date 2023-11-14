//
//  RenderPipelineDescriptor.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

enum RenderPipelineDescriptorTypes {
    case Basic
}

class RenderPipelineDescriptorLibrary {

    private static var renderPipelineDescriptors: [RenderPipelineDescriptorTypes: RenderPipelineDescriptor] = [:]
    
    public static func initialize() {
        createDefaultRenderPipelineDescriptor()
    }
    
    private static func createDefaultRenderPipelineDescriptor() {
        renderPipelineDescriptors.updateValue(Basic_RenderPipelineDescriptor(), forKey: .Basic)
    }
    
    public static func Descriptor(_ renderPipelineDescriptorType: RenderPipelineDescriptorTypes) -> MTLRenderPipelineDescriptor {
        return renderPipelineDescriptors[renderPipelineDescriptorType]!.renderPipelineDescriptor
    }
}

protocol RenderPipelineDescriptor {
    var name: String { get }
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor { get }
}


public struct Basic_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Basic Render Pipeline Descriptor"
    
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.Vertex(.Basic)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.Fragment(.Basic)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.Descriptor(.Basic)
        
        return renderPipelineDescriptor
    }
    
}