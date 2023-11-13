//
//  MyShaders.metal
//  Game Engine
//
//  Created by Alex on 13/11/2023.
//

#include <metal_stdlib>
using namespace metal;

// [[]] - attribute tag
vertex float4 basic_vertex_shader(const device float3 *vertices [[ buffer(0) ]],
                                  uint vertexId                 [[ vertex_id ]]) {
    return float4(vertices[vertexId], 1);
}

fragment half4 basic_fragment_shader() {
    return half4(1);
}
