//
//  HMAC.swift
//  CommonCryptoCompat
//
//  API for compatibility with the Swift CommonCrypto wrapper at
//  https://github.com/Bouke/CommonCrypto.git
//
import CryptoSwift

public typealias HMAC = CryptoSwift.HMAC

public extension HMAC {
	/// CommonCrypto compatibility alias for HMAC.Variant
	public typealias Algorithm = Variant
}


public extension HMAC.Algorithm {
	/// Alias for the SHA1 algorithm (CommonCrypto compatibility)
	public static var SHA1: HMAC.Algorithm { return .sha1 }

	/// Alias for the SHA256 algorithm (CommonCrypto compatibility)
	public static var SHA256: HMAC.Algorithm { return .sha256 }

	/// Alias for the SHA512 algorithm (CommonCrypto compatibility)
	public static var SHA512: HMAC.Algorithm { return .sha512 }
}
