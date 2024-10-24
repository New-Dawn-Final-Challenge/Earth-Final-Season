//
//  Wave.metal
//  Earth_Final_Season
//
//  Created by Ana Elisa Lima on 24/10/24.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 wave(
    float2 pos, float t) {
        pos.y += sin(t * 5 + pos.y) * 5;
        return pos;
}
