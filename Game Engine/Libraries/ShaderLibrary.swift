//
//  ShaderLibrary.swift
//  Game Engine
//
//  Created by Alex on 14/11/2023.
//

import MetalKit

enum VertexShaderTypes {
    case Basic
}

enum FragmentShaderTypes {
    case Basic
}

class ShaderLibrary {
    public static var DefaultLibrary: MTLLibrary!
    
    private static var vertexShaders: [VertexShaderTypes:Shader] = [:]
    private static var fragmentShaders: [FragmentShaderTypes:Shader] = [:]
    
    public static func Initialize() {
        DefaultLibrary = Engine.Device.makeDefaultLibrary()
        createDefaultShaders()
    }
    
    public static func createDefaultShaders() {
        vertexShaders.updateValue(Basic_VertexShader(), forKey: .Basic)
        fragmentShaders.updateValue(Basic_FragmentShader(), forKey: .Basic)
    }
    
    public static func Vertex(_ vertexShaderType: VertexShaderTypes) -> MTLFunction {
        return vertexShaders[vertexShaderType, default: Basic_VertexShader()].function
    }
    
    public static func Fragment(_ fragmentShaderType: FragmentShaderTypes) -> MTLFunction {
        return fragmentShaders[fragmentShaderType, default: Basic_FragmentShader()].function
    }
}

protocol Shader {
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction { get }
}

public struct Basic_VertexShader: Shader {
    public var name: String = "Basic Vertex Shader v2"
    //    public var functionName: String = "basic_vertex_shader"
    public var functionName: String = "vertex_shader3"
    public var function: MTLFunction 
    init() {
        function = ShaderLibrary.DefaultLibrary.makeFunction(name: functionName)!
        function.label = name
    }
}

public struct Basic_FragmentShader: Shader {
    public var name: String = "Basic Fragment Shader v2"
    public var functionName: String = "fragment_shader"
    public var function: MTLFunction
    init() {
        function = ShaderLibrary.DefaultLibrary.makeFunction(name: functionName)!
        function.label = name
    }
}
