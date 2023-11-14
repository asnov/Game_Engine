//
//  VertexDescriptorLibrary.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

enum VertexDescriptorType {
    case Basic
}

class VertexDescriptorLibrary {
    private static var vertexDescriptors: [VertexDescriptorType: VertexDescriptor] = [:]
    
    public static func initialize() {
        createDefaultVertexDescriptors()
    }
    
    private static func createDefaultVertexDescriptors() {
        vertexDescriptors.updateValue(Basic_VertexDescriptor(), forKey: .Basic)
    }
    
    public static func Descriptor(_ vertexDescriptorType: VertexDescriptorType) -> MTLVertexDescriptor {
        return vertexDescriptors[vertexDescriptorType]!.vertexDescriptor
    }
}

protocol VertexDescriptor {
    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor { get }
}

public struct Basic_VertexDescriptor: VertexDescriptor {
    var name = "Basic Vertex Descriptor"
    
    var vertexDescriptor: MTLVertexDescriptor {
        let vertexDescriptor = MTLVertexDescriptor()
        
        // Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        // Color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = SIMD3<Float>.size
        
        vertexDescriptor.layouts[0].stride = GameView.Vertex.stride // TODO: Check it
        
        return vertexDescriptor
    }
}
