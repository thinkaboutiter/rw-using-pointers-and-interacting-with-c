//: Playground - noun: a place where people can play

import Foundation

/**
 Memory Layouts
 */
// Memory Layouts of basic types
MemoryLayout<Int>.size          // returns 8 (on 64-bit)
MemoryLayout<Int>.alignment     // returns 8 (on 64-bit)
MemoryLayout<Int>.stride        // returns 8 (on 64-bit)

MemoryLayout<Int16>.size        // returns 2
MemoryLayout<Int16>.alignment   // returns 2
MemoryLayout<Int16>.stride      // returns 2

MemoryLayout<Bool>.size         // returns 1
MemoryLayout<Bool>.alignment    // returns 1
MemoryLayout<Bool>.stride       // returns 1

MemoryLayout<Float>.size        // returns 4
MemoryLayout<Float>.alignment   // returns 4
MemoryLayout<Float>.stride      // returns 4

MemoryLayout<Double>.size       // returns 8
MemoryLayout<Double>.alignment  // returns 8
MemoryLayout<Double>.stride     // returns 8

// Memory Layouts of structs
struct EmptyStruct {}

MemoryLayout<EmptyStruct>.size      // returns 0
MemoryLayout<EmptyStruct>.alignment // returns 1
MemoryLayout<EmptyStruct>.stride    // returns 1

struct SampleStruct {
    let number: UInt32
    let flag: Bool
}

MemoryLayout<SampleStruct>.size       // returns 5
MemoryLayout<SampleStruct>.alignment  // returns 4
MemoryLayout<SampleStruct>.stride     // returns 8

// Memory Layouts on classes
class EmptyClass {}

MemoryLayout<EmptyClass>.size      // returns 8 (on 64-bit)
MemoryLayout<EmptyClass>.stride    // returns 8 (on 64-bit)
MemoryLayout<EmptyClass>.alignment // returns 8 (on 64-bit)

class SampleClass {
    let number: Int64 = 0
    let flag: Bool = false
}

MemoryLayout<SampleClass>.size      // returns 8 (on 64-bit)
MemoryLayout<SampleClass>.stride    // returns 8 (on 64-bit)
MemoryLayout<SampleClass>.alignment // returns 8 (on 64-bit)

/**
 Using Raw Pointers
 */
let count = 2
let stride = MemoryLayout<Int>.stride
let alignment = MemoryLayout<Int>.alignment
let byteCount = stride * count

do {
    print("Raw pointers")
    
    let pointer = UnsafeMutableRawPointer.allocate(bytes: byteCount, alignedTo: alignment)
    defer {
        pointer.deallocate(bytes: byteCount, alignedTo: alignment)
    }
    
    pointer.storeBytes(of: 42, as: Int.self)
    pointer.advanced(by: stride).storeBytes(of: 6, as: Int.self)
    pointer.load(as: Int.self)
    pointer.advanced(by: stride).load(as: Int.self)
    
    // UnsafeRawBufferPointer lets you access memory as if it was a collection of bytes
    let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
    for (index, byte) in bufferPointer.enumerated() {
        print("byte \(index): \(byte)")
    }
}
