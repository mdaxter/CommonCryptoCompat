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

	/// Return the digest length of the chosen algorithm (CommonCrypto compatibility)
	public var length: Int {
		switch self {
		case .sha1:		return Int(CC_SHA1_DIGEST_LENGTH)
		case .sha256:	return Int(CC_SHA256_DIGEST_LENGTH)
		case .sha384:	return Int(CC_SHA384_DIGEST_LENGTH)
		case .sha512:	return Int(CC_SHA512_DIGEST_LENGTH)
		case .md5:		return Int(CC_MD5_DIGEST_LENGTH)
		}
	}
}
