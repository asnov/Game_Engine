//
//  ColorUtil.swift
//  Game Engine
//
//  Created by Alex on 16/11/2023.
//

class ColorUtil {
    
    public static var randomColor: SIMD4<Float> {
        SIMD4<Float>(Float.randomZeroToOne, Float.randomZeroToOne, Float.randomZeroToOne, 1.0)
    }
}
