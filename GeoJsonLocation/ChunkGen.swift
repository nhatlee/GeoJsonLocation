////
////  ChunkGen.swift
////  GeoJsonLocation
////
////  Created by lee on 11/3/16.
////  Copyright © 2016 com.acc.siridemo. All rights reserved.
////
//
import Foundation
//extension Collection {
//    
//    func chunk(withDistance distance: Index.Distance) -> AnySequence<SubSequence> {
//        var index = startIndex
//        let generator: AnyIterator<SubSequence> = AnyIterator {
//            defer { index = index.advancedBy(distance, limit: self.endIndex) }
//            return index != self.endIndex ? self[index ..< index.advancedBy(distance, limit: self.endIndex)] : nil
//        }
//        return AnySequence(generator)
//    }
//    
//}

//public struct ChunkGen<G : IteratorProtocol> : IteratorProtocol {
//    
//    private var g: G
//    private let n: Int
//    private var c: [G.Element]
//    
//    public mutating func next() -> [G.Element]? {
//        var i = n
//        return g.next().map {
//            c = [$0]
//            while i > 0, let next = g.next() { c.append(next) }
//            return c
//        }
//    }
//    
//    private init(g: G, n: Int) {
//        self.g = g
//        self.n = n
//        self.c = []
//        self.c.reserveCapacity(n)
//    }
//}
//
//public struct ChunkSeq<S : Sequence> : Sequence {
//    
//    private let seq: S
//    private let n: Int
//    
//    public func generate() -> ChunkGen<S.Iterator> {
//        return ChunkGen(g: seq.generate(), n: n)
//    }
//}
//
//public extension Sequence {
//    func chunk(n: Int) -> ChunkSeq<Self> {
//        return ChunkSeq(seq: self, n: n)
//    }
//}
