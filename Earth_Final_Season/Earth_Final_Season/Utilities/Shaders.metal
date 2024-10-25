//
//  Shaders.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 22/10/24.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 complexWave(float2 position, float time, float2 size, float speed, float strength, float frequency) {
    float2 normalizedPosition = position / size;
    float moveAmount = time * speed;

    position.x += sin((normalizedPosition.x + moveAmount) * frequency) * strength;
    position.y += cos((normalizedPosition.y + moveAmount) * frequency) * strength;

    return position;
}

[[ stitchable ]] float2 nebulaGalaxyWave(float2 position, float time, float2 size, float speed, float strength, float frequency, float spiralFactor) {
    // Normalize the position within the size
    float2 normalizedPosition = position / size;
    
    // Spiral movement factor to mimic a nebula moving through galactic arms
    float moveAmount = time * speed;
    
    // Adjust the position to simulate movement along a spiral path
    float angle = atan2(normalizedPosition.y - 0.5, normalizedPosition.x - 0.5); // Centralize the spiral
    float distance = length(normalizedPosition - float2(0.5, 0.5)); // Distance from the center
    
    // Spiral movement - adding rotation to simulate nebula following a spiral arm
    position.x += sin((angle + moveAmount) * frequency + distance * spiralFactor) * strength;
    position.y += cos((angle + moveAmount) * frequency + distance * spiralFactor) * strength;
    
    // Additional subtle wave to create some randomness in the nebula's motion
    position.x += sin((normalizedPosition.x + moveAmount * 0.5) * frequency * 0.5) * strength * 0.5;
    position.y += cos((normalizedPosition.y + moveAmount * 0.5) * frequency * 0.5) * strength * 0.5;
    
    // Return the updated position
    return position;
}

[[ stitchable ]] float2 nebulaMoveAcrossScreen(float2 position, float time, float2 size, float speed, float strength, float frequency) {
    // Normalize the position within the size
    float2 normalizedPosition = position / size;
    
    // Move the nebula horizontally across the screen
    position.x += time * speed;
    
    // If it goes off-screen, wrap it around
    if (position.x > size.x) {
        position.x = 0.0; // Wrap around to the left
    }

    // Apply wave-like distortion for a dynamic nebula movement
    float moveAmount = time * speed;
    position.y += sin((normalizedPosition.x + moveAmount) * frequency) * strength;
    
    // Add a small vertical oscillation for more dynamic motion
    position.x += sin(moveAmount * 0.5) * strength * 0.5;
    position.y += cos(moveAmount * 0.5) * strength * 0.5;

    // Return the updated position
    return position;
}

[[stitchable]] float2 walk(float2 pos, float time, float width) {
    pos.x -= time * 20.0;

    pos.x = pos.x + width * (pos.x < 0 ? 1 : 0);
    pos.x = pos.x - floor(pos.x / width) * width;

    return pos;
}
