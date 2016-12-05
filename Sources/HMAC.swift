//
//  HMAC.swift
//  CommonCryptoCompat
//
//  API for compatibility with the Swift CommonCrypto wrapper at
//  https://github.com/Bouke/CommonCrypto.git
//
import Foundation
import CryptoSwift

public class HMAC {
	public typealias Algorithm = CryptoSwift.HMAC.Variant

	let hmac: CryptoSwift.HMAC
	var bytes = Array<UInt8>()

	public init(algorithm: Algorithm, key: Data) {
		self.hmac = CryptoSwift.HMAC(key: key.bytes, variant: algorithm)
	}

	@discardableResult
	public func update(_ data: Data) -> Self {
		bytes += data.bytes
		return self
	}

	public func final() -> Data {
		let mac = try! Data(bytes: hmac.authenticate(bytes))
		return mac
	}
}

public extension HMAC.Algorithm {
	/// Alias for the SHA1 algorithm (CommonCrypto compatibility)
	public static var SHA1: HMAC.Algorithm { return .sha1 }

	/// Alias for the SHA256 algorithm (CommonCrypto compatibility)
	public static var SHA256: HMAC.Algorithm { return .sha256 }

	/// Alias for the SHA512 algorithm (CommonCrypto compatibility)
	public static var SHA512: HMAC.Algorithm { return .sha512 }
}
