//
//  Shaders.metal
//  Earth_Final_Season
//
//  Created by Ana Elisa Lima on 23/10/24.
//

#include <metal_stdlib>
using namespace metal;

float random(float2 uv) {
    return fract(sin(dot(uv.xy, float2(12.9898, 78.233))) * 43758.5453);
}

struct VertexOut {
    float4 position [[position]];
    float2 uv;
};

vertex VertexOut vertexShader(uint vertexID [[vertex_id]]) {
    float4 positions[6] = {
        float4(-1.0, -1.0, 0.0, 1.0),
        float4( 1.0, -1.0, 0.0, 1.0),
        float4(-1.0,  1.0, 0.0, 1.0),
        float4( 1.0, -1.0, 0.0, 1.0),
        float4( 1.0,  1.0, 0.0, 1.0),
        float4(-1.0,  1.0, 0.0, 1.0)
    };

    float2 uvs[6] = {
        float2(0.0, 0.0),
        float2(1.0, 0.0),
        float2(0.0, 1.0),
        float2(1.0, 0.0),
        float2(1.0, 1.0),
        float2(0.0, 1.0)
    };

    VertexOut out;
    out.position = positions[vertexID];
    out.uv = uvs[vertexID];
    return out;
}

fragment float4 fragmentShader(VertexOut in [[stage_in]], constant float &time [[buffer(0)]]) {
    float noise = random(in.uv + time * float2(0.1, 0.1));
    noise *= 0.5;
    float alpha = 0.3;
    return float4(noise, noise, noise, alpha * noise);
}
