//
//  Random.swift
//  CommonCryptoCompat
//
//  API for compatibility with the Swift CommonCrypto wrapper at
//  https://github.com/Bouke/CommonCrypto.git
//
import Foundation

public func generateRandomBytes(count: Int) -> Data {
	var data = Data(count: count)
	data.withUnsafeMutableBytes { (pData: UnsafeMutablePointer<UInt8>) in
		#if os(Linux) || os(Android) || os(FreeBSD)
			let fd = open("/dev/urandom", O_RDONLY)
			assert(fd >= 0)
			defer { close(fd) }
			assert(read(fd, pData, count) == count)
		#else
			var p = pData
			for _ in 0..<count {
				p.pointee = UInt8(arc4random_uniform(UInt32(UInt8.max) + 1))
				p += 1
			}
		#endif
	}
	return data
}
