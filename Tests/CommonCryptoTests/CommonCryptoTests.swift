//
//  CommonCryptoTests.swift
//  CommonCryptoCompat
//
//  Tests for API compatibility with the Swift CommonCrypto wrapper at
//  https://github.com/Bouke/CommonCrypto.git
//
import XCTest
import Foundation
@testable import CommonCrypto

private extension Data {
	init(hex value: String) {
		let b = Array<UInt8>(hex: value)
		self.init(bytes: b)
	}
}
final class CommonCryptoTests: XCTestCase {
	func testDigest() {
		let actual = Digest.MD5.hash("password".data(using: .utf8)!)
		let expected = Data(hex: "5f4dcc3b5aa765d61d8327deb882cf99")
		XCTAssertEqual(actual, expected)
	}

	func testHMACCommonCryptoSHA1() {
		let actual = HMAC(algorithm: .SHA1, key: "secret".data(using: .utf8)!).update(Data()).final()
		let expected = Data(hex: "25af6174a0fcecc4d346680a72b7ce644b9a88e8")
		XCTAssertEqual(actual, expected)
		let empty = HMAC(algorithm: .SHA1, key: Data()).update(Data()).final()
		let sha1e = Data(hex: "fbdb1d1b18aa6c08324b7d64b71fb76370690e1d")
		XCTAssertEqual(empty, sha1e)
		let long =  HMAC(algorithm: .SHA1, key: Data(hex: "30313233343536373839303132333435363738393031323334353637383930313233343536373839303132333435363738393031323334353637383930313233")).update(Data(hex: "74657374")).final()
		let sha1 = Data(hex: "23cea58b0c484ed005434938ee70a938d7524e91")
		XCTAssertEqual(long, sha1)
	}

	func testRandom() {
		XCTAssertEqual(generateRandomBytes(count: 64).count, 64)
	}

    static var allTests : [(String, (CommonCryptoTests) -> () throws -> Void)] {
        return [
            ("testDigest",					testDigest),
            ("testHMACCommonCryptoSHA1",	testHMACCommonCryptoSHA1),
            ("testRandom",					testRandom),
        ]
    }
}
