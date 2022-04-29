//
//  BreachBypass.metal
//  BreachBypass
//
//  Created by Honma Masaru on 2021/06/02.
//

#include <metal_stdlib>
#include <CoreImage/CoreImage.h>

using namespace metal;

extern "C" {
    namespace coreimage {
        float4 breachBypass(sample_t s, float thresholdR, float thresholdG, float thresholdB) {
            return float4(min(s.r, thresholdR), min(s.g, thresholdG), min(s.b, thresholdB), s.a);
        }
    }
}
