import XCTest
@testable import PerfectJWTTests

XCTMain([
     testCase(Base64TranscoderTests.all),
     testCase(ClaimTests.all),
     testCase(EncodingTests.all),
     testCase(JWTTests.all),
     testCase(SignerTests.all),
])
