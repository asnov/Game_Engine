//
//  Types.swift
//  Game Engine
//
//  Created by Alex on 13/11/2023.
//

import simd

protocol sizable {
    static func size(_ count: Int) -> Int
    static func stride(_ count: Int) -> Int
}

extension sizable {
    static var size: Int {
        get {
            self._size()
        }
    }

    static var stride: Int {
        get {
            self._stride()
        }
    }

    static func _size() -> Int {
        MemoryLayout<Self>.size
    }
    
    static func _stride() -> Int {
        MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int) -> Int {
        MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int) -> Int {
        MemoryLayout<Self>.stride * count
    }
}

extension SIMD3: sizable { }
