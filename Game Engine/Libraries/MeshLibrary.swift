//
//  MeshLibrary.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

enum MeshTypes {
    case TriangleCustom
    case QuadCustom
}

class MeshLibrary {
    
    private static var meshes: [MeshTypes: Mesh] = [:]
    
    public static func Initialize() {
        createDefaultMeshes()
    }
    
    private static func createDefaultMeshes() {
        meshes.updateValue(TriangleCustomMesh(), forKey: .TriangleCustom)
        meshes.updateValue(QuadCustomMesh(), forKey: .QuadCustom)
    }
    
    public static func Mesh(_ meshType: MeshTypes) -> Mesh {
        return meshes[meshType]!    // FIXME: here
    }
}


protocol Mesh {
    var vertexBuffer: MTLBuffer? { get }
    var vertexCount: Int { get }
}

class CustomMesh: Mesh {
    private lazy var vertices: [Vertex] = createVertices()
    lazy var vertexBuffer: MTLBuffer? = createBuffer()
    var vertexCount: Int { vertices.count }
    
    fileprivate func createVertices() -> [Vertex] {
        [
//            Vertex(position: SIMD3<Float>( 0,  1, 0), color: SIMD4<Float>(1, 0, 0, 1)),
//            Vertex(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 1, 0, 1)),
//            Vertex(position: SIMD3<Float>( 1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)),
        ]
    }
    
    private func createBuffer() -> MTLBuffer? {
        Engine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
}

class TriangleCustomMesh: CustomMesh {
    override func createVertices() -> [Vertex] {
        [
            Vertex(position: SIMD3<Float>( 0,  1, 0), color: SIMD4<Float>(1, 0, 0, 1)), // Top
            Vertex(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 1, 0, 1)), // Bottom left
            Vertex(position: SIMD3<Float>( 1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)), // Bottom right
        ]
    }
}

class QuadCustomMesh: CustomMesh {
    override func createVertices() -> [Vertex] {
        [
            Vertex(position: SIMD3<Float>( 0.5,  0.5, 0), color: SIMD4<Float>(1, 0, 0, 1)), // Top right
            Vertex(position: SIMD3<Float>(-0.5,  0.5, 0), color: SIMD4<Float>(0, 1, 0, 1)), // Top left
            Vertex(position: SIMD3<Float>(-0.5, -0.5, 0), color: SIMD4<Float>(0, 0, 1, 1)), // Bottom left

            Vertex(position: SIMD3<Float>( 0.5,  0.5, 0), color: SIMD4<Float>(1, 0, 0, 1)), // Top right
            Vertex(position: SIMD3<Float>(-0.5, -0.5, 0), color: SIMD4<Float>(0, 0, 1, 1)), // Bottom left
            Vertex(position: SIMD3<Float>( 0.5, -0.5, 0), color: SIMD4<Float>(1, 0, 1, 1)), // Bottom right
        ]
    }
}
