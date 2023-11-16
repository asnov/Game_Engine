//
//  MeshLibrary.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

enum MeshTypes {
    case TriangleCustom
    case HighTriangleCustom
    case QuadCustom
    case CubeCustom
    case CubeConTriangle
}

class MeshLibrary {
    
    private static var meshes: [MeshTypes: Mesh] = [:]
    
    public static func Initialize() {
        createDefaultMeshes()
    }
    
    private static func createDefaultMeshes() {
        meshes.updateValue(TriangleCustomMesh(), forKey: .TriangleCustom)
        meshes.updateValue(HighTriangleCustomMesh(), forKey: .HighTriangleCustom)
        meshes.updateValue(QuadCustomMesh(), forKey: .QuadCustom)
        meshes.updateValue(CubeCustomMesh(), forKey: .CubeCustom)
        meshes.updateValue(CubeConTriangleMesh(), forKey: .CubeConTriangle)
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

class HighTriangleCustomMesh: CustomMesh {
    override func createVertices() -> [Vertex] {
        [
            Vertex(position: SIMD3<Float>(   0,  1, 0), color: SIMD4<Float>(1, 0, 0, 1)), // Top
            Vertex(position: SIMD3<Float>(-0.5, -1, 0), color: SIMD4<Float>(0, 1, 0, 1)), // Bottom left
            Vertex(position: SIMD3<Float>( 0.5, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)), // Bottom right
        ]
    }
}

class QuadCustomMesh: CustomMesh {
    override func createVertices() -> [Vertex] {
        [
            Vertex(position: SIMD3<Float>( 1,  1, 0), color: SIMD4<Float>(1, 0, 0, 1)), // Top right
            Vertex(position: SIMD3<Float>(-1,  1, 0), color: SIMD4<Float>(0, 1, 0, 1)), // Top left
            Vertex(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)), // Bottom left
            
            Vertex(position: SIMD3<Float>( 1,  1, 0), color: SIMD4<Float>(1, 0, 0, 1)), // Top right
            Vertex(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)), // Bottom left
            Vertex(position: SIMD3<Float>( 1, -1, 0), color: SIMD4<Float>(1, 0, 1, 1)), // Bottom right
        ]
    }
}

class CubeCustomMesh: CustomMesh {
    override func createVertices() -> [Vertex] {
        [
            //Left - blue
            Vertex(position: SIMD3<Float>(-1.0,-1.0,-1.0), color: SIMD4<Float>(0.0, 0.0, 1.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0,-1.0, 1.0), color: SIMD4<Float>(0.0, 0.0, 0.9, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0, 1.0, 1.0), color: SIMD4<Float>(0.0, 0.0, 0.9, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0,-1.0,-1.0), color: SIMD4<Float>(0.0, 0.0, 1.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0, 1.0, 1.0), color: SIMD4<Float>(0.0, 0.0, 0.9, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0, 1.0,-1.0), color: SIMD4<Float>(0.0, 0.0, 0.9, 1.0)),
            
            //RIGHT - green
            Vertex(position: SIMD3<Float>( 1.0, 1.0, 1.0), color: SIMD4<Float>(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0,-1.0,-1.0), color: SIMD4<Float>(0.0, 0.9, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0, 1.0,-1.0), color: SIMD4<Float>(0.0, 0.9, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0,-1.0,-1.0), color: SIMD4<Float>(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0, 1.0, 1.0), color: SIMD4<Float>(0.0, 0.9, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0,-1.0, 1.0), color: SIMD4<Float>(0.0, 0.9, 0.0, 1.0)),
            
            //TOP - yellow
            Vertex(position: SIMD3<Float>( 1.0, 1.0, 1.0), color: SIMD4<Float>(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0, 1.0,-1.0), color: SIMD4<Float>(0.9, 0.9, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0, 1.0,-1.0), color: SIMD4<Float>(0.9, 0.9, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0, 1.0, 1.0), color: SIMD4<Float>(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0, 1.0,-1.0), color: SIMD4<Float>(0.9, 0.9, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0, 1.0, 1.0), color: SIMD4<Float>(0.9, 0.9, 0.0, 1.0)),
            
            //BOTTOM - white
            Vertex(position: SIMD3<Float>( 1.0,-1.0, 1.0), color: SIMD4<Float>(1.0, 1.0, 1.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0,-1.0,-1.0), color: SIMD4<Float>(0.9, 0.9, 0.9, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0,-1.0,-1.0), color: SIMD4<Float>(0.9, 0.9, 0.9, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0,-1.0, 1.0), color: SIMD4<Float>(1.0, 1.0, 1.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0,-1.0, 1.0), color: SIMD4<Float>(0.9, 0.9, 0.9, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0,-1.0,-1.0), color: SIMD4<Float>(0.9, 0.9, 0.9, 1.0)),
            
            //BACK - orange
            Vertex(position: SIMD3<Float>( 1.0, 1.0,-1.0), color: SIMD4<Float>(1.0, 0.6, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0,-1.0,-1.0), color: SIMD4<Float>(0.9, 0.7, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0, 1.0,-1.0), color: SIMD4<Float>(0.9, 0.7, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0, 1.0,-1.0), color: SIMD4<Float>(1.0, 0.6, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0,-1.0,-1.0), color: SIMD4<Float>(0.9, 0.7, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0,-1.0,-1.0), color: SIMD4<Float>(0.9, 0.7, 0.0, 1.0)),
            
            //FRONT - red
            Vertex(position: SIMD3<Float>(-1.0, 1.0, 1.0), color: SIMD4<Float>(1.0, 0.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0,-1.0, 1.0), color: SIMD4<Float>(0.9, 0.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0,-1.0, 1.0), color: SIMD4<Float>(0.9, 0.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0, 1.0, 1.0), color: SIMD4<Float>(1.0, 0.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.0, 1.0, 1.0), color: SIMD4<Float>(0.9, 0.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.0,-1.0, 1.0), color: SIMD4<Float>(0.9, 0.0, 0.0, 1.0))
        ]
    }
}

class CubeConTriangleMesh: CubeCustomMesh {
    
    override func createVertices() -> [Vertex] {
        super.createVertices() + [
            // Left - green
            Vertex(position: SIMD3<Float>(-1.001, 0.0, 0.5), color: SIMD4<Float>(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.001,-0.5,-0.5), color: SIMD4<Float>(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-1.001, 0.5,-0.5), color: SIMD4<Float>(0.0, 1.0, 0.0, 1.0)),
            // Right - blue
            Vertex(position: SIMD3<Float>( 1.001, 0.0, 0.5), color: SIMD4<Float>(0.0, 0.0, 1.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.001,-0.5,-0.5), color: SIMD4<Float>(0.0, 0.0, 1.0, 1.0)),
            Vertex(position: SIMD3<Float>( 1.001, 0.5,-0.5), color: SIMD4<Float>(0.0, 0.0, 1.0, 1.0)),
            // Top - green
            Vertex(position: SIMD3<Float>( 0.0, 1.001, 0.5), color: SIMD4<Float>(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-0.5, 1.001,-0.5), color: SIMD4<Float>(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 0.5, 1.001,-0.5), color: SIMD4<Float>(0.0, 1.0, 0.0, 1.0)),
            // Bottom - dark
            Vertex(position: SIMD3<Float>( 0.0,-1.001, 0.5), color: SIMD4<Float>(0.1, 0.1, 0.1, 1.0)),
            Vertex(position: SIMD3<Float>(-0.5,-1.001,-0.5), color: SIMD4<Float>(0.1, 0.1, 0.1, 1.0)),
            Vertex(position: SIMD3<Float>( 0.5,-1.001,-0.5), color: SIMD4<Float>(0.1, 0.1, 0.1, 1.0)),
            // Back - yellow
            Vertex(position: SIMD3<Float>( 0.0, 0.5, -1.001), color: SIMD4<Float>(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-0.5,-0.5, -1.001), color: SIMD4<Float>(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 0.5,-0.5, -1.001), color: SIMD4<Float>(1.0, 1.0, 0.0, 1.0)),
            // Front - yellow
            Vertex(position: SIMD3<Float>( 0.0, 0.5, 1.001), color: SIMD4<Float>(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>(-0.5,-0.5, 1.001), color: SIMD4<Float>(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: SIMD3<Float>( 0.5,-0.5, 1.001), color: SIMD4<Float>(1.0, 1.0, 0.0, 1.0)),
        ]
    }
}
