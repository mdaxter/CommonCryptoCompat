//
//  Digest.swift
//  CommonCryptoCompat
//
//  API for compatibility with the Swift CommonCrypto wrapper at
//  https://github.com/Bouke/CommonCrypto.git
//
import Foundation
import CryptoSwift

public let CC_MD5_DIGEST_LENGTH: CInt = 16
public let CC_SHA1_DIGEST_LENGTH: CInt = 20
public let CC_SHA512_DIGEST_LENGTH: CInt = 64

public enum Digest {
	case MD5
	case SHA1
	case SHA512

	public var length: Int {
		switch self {
		case .MD5: return Int(CC_MD5_DIGEST_LENGTH)
		case .SHA1: return Int(CC_SHA1_DIGEST_LENGTH)
		case .SHA512: return Int(CC_SHA512_DIGEST_LENGTH)
		}
	}

	var f: (Array<UInt8>) -> Array<UInt8> {
		switch self {
		case .MD5: return CryptoSwift.Digest.md5
		case .SHA1: return CryptoSwift.Digest.sha1
		case .SHA512: return CryptoSwift.Digest.sha512
		}
	}

	public func hash(_ data: Data) -> Data {
		let digest = Data(bytes: f(data.bytes))
		return digest
	}
}
