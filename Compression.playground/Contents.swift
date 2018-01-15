//: Playground - noun: a place where people can play

import Foundation
import Compression

enum CompressionAlgorithm {
    case lz4   // speed is critical
    case lz4a  // space is critical
    case zlib  // reasonable speed and space
    case lzfse // better speed and space
}

enum CompressionOperation {
    case compression, decompression
}

// return compressed or uncompressed data depending on the operation
func perform(_ operation: CompressionOperation,
             on input: Data,
             using algorithm: CompressionAlgorithm,
             workingBufferSize: Int = 2000) -> Data?  {
    return nil
}

// Compressed keeps the compressed data and the algorithm
// together as one unit, so you never forget how the data was
// compressed.

struct Compressed {
    
    let data: Data
    let algorithm: CompressionAlgorithm
    
    init(data: Data, algorithm: CompressionAlgorithm) {
        self.data = data
        self.algorithm = algorithm
    }
    
    // Compress the input with the specified algorithm. Returns nil if it fails.
    static func compress(input: Data,
                         with algorithm: CompressionAlgorithm) -> Compressed? {
        guard let data = perform(.compression, on: input, using: algorithm) else {
            return nil
        }
        return Compressed(data: data, algorithm: algorithm)
    }
    
    // Uncompressed data. Returns nil if the data cannot be decompressed.
    func decompressed() -> Data? {
        return perform(.decompression, on: data, using: algorithm)
    }
}

// For discoverability, add a compressed method to Data
extension Data {
    
    // Returns compressed data or nil if compression fails.
    func compressed(with algorithm: CompressionAlgorithm) -> Compressed? {
        return Compressed.compress(input: self, with: algorithm)
    }
}

// Example usage:

let input = Data(bytes: Array(repeating: UInt8(123), count: 10000))

let compressed = input.compressed(with: .lzfse)
compressed?.data.count // in most cases much less than orginal input count

let restoredInput = compressed?.decompressed()
input == restoredInput // true
