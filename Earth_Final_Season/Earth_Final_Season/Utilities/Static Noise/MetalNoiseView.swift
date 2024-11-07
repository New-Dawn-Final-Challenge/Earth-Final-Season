//
//  MetalNoiseView.swift
//  Earth_Final_Season
//
//  Created by Ana Elisa Lima on 23/10/24.
//

import SwiftUI
import MetalKit

struct MetalStaticNoiseView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.framebufferOnly = false
        return mtkView
    }

    func updateUIView(_ uiView: MTKView, context: Context) { }

    class Coordinator: NSObject, MTKViewDelegate {
        var parent: MetalStaticNoiseView
        var pipelineState: MTLRenderPipelineState?
        var commandQueue: MTLCommandQueue?
        var time: Float = 0.0
        
        init(_ parent: MetalStaticNoiseView) {
            self.parent = parent
            super.init()
            setupMetal()
        }
        
        func setupMetal() {
            guard let device = MTLCreateSystemDefaultDevice(),
                  let library = device.makeDefaultLibrary() else {
                return
            }

            let pipelineDescriptor = MTLRenderPipelineDescriptor()
            pipelineDescriptor.vertexFunction = library.makeFunction(name: "vertexShader")
            pipelineDescriptor.fragmentFunction = library.makeFunction(name: "fragmentShader")
            pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

            do {
                pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
                commandQueue = device.makeCommandQueue()
            } catch {
                print("Failed to create pipeline state, error \(error)")
            }
        }

        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }

        func draw(in view: MTKView) {
            guard let drawable = view.currentDrawable,
                  let pipelineState = pipelineState,
                  let commandQueue = commandQueue else { return }

            time += 0.01

            let commandBuffer = commandQueue.makeCommandBuffer()
            let renderPassDescriptor = view.currentRenderPassDescriptor
            
            if let renderPassDescriptor = renderPassDescriptor {
                let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
                renderEncoder?.setRenderPipelineState(pipelineState)
                renderEncoder?.setFragmentBytes(&time, length: MemoryLayout<Float>.stride, index: 0)

                renderEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 6)
                renderEncoder?.endEncoding()
                
                commandBuffer?.present(drawable)
                commandBuffer?.commit()
            }
        }
    }
}
