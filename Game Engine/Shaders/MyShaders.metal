//
//  MyShaders.metal
//  Game Engine
//
//  Created by Alex on 13/11/2023.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

struct RasterizerData {
    float4 position [[ position ]];
    float4 color;
};

// [[]] - attribute tag - attribute qualifier?
vertex float4 basic_vertex_shader(const device VertexIn *vertices [[ buffer(0) ]],
                                  uint vertexId                 [[ vertex_id ]]) {
    return float4(vertices[vertexId].position, 1);
}

vertex RasterizerData vertex_shader(const device VertexIn *vertices [[ buffer(0) ]],
                                    uint vertexId   [[ vertex_id]]) {
    RasterizerData rd;
    
    rd.position = float4(vertices[vertexId].position, 1);
    rd.color = vertices[vertexId].color;
    
    return rd;
}

vertex RasterizerData vertex_shader2(const VertexIn vIn [[ stage_in ]],
                                     constant float &deltaPosition [[ buffer(1) ]]) {
    RasterizerData rd;
    
    rd.position = float4(vIn.position, 1);
    rd.position.x += deltaPosition;
    rd.color = vIn.color;
    
    return rd;
}


struct ModelConstants {
    float4x4 modelMatrix;
};

struct SceneConstants {
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};

struct Material {
    float4 color;
    bool useMaterialColor;
};

vertex RasterizerData vertex_shader3(const VertexIn vIn [[ stage_in ]],
                                     constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                     constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
//    rd.position = float4(vIn.position, 1);
    // The order is important: https://youtu.be/hvA0tTyH7JA?t=1611
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.color = vIn.color;
    
    return rd;
}


fragment half4 basic_fragment_shader() {
    return half4(1);
}

fragment half4 fragment_shader(RasterizerData rd [[ stage_in ]],
                               constant Material &material [[ buffer(1) ]]) {
//    float4 position = rd.position;
    float4 color = material.useMaterialColor ? material.color : rd.color;
//    float4 color = float4(0,1,0,1); // Red Channel
//    float4 color = float4(color.r, color.g, color.b, color.a);
    
    return half4(color.r, color.g, color.b, color.a);
//    return half4(color.g, color.b, color.a, color.r);
//    return half4(color.r, color.g, color.b, position.b);
//    return half4(position.r, position.g, position.b, position.a);
    
//    float r = position.x,
//        g = position.y,
//        b = position.z,
//        a = position.w;
//    return half4(r, g, b, a);
}
