import XCTest
@testable import Money

final class MoneyTests: XCTestCase {

    func testConvertion() {
        var amd500 = Measurement<UnitCurrency>(value: 500.0, unit: UnitCurrency.AMD)
        amd500.convert(to: UnitCurrency.USD)

        XCTAssert(amd500.unit == UnitCurrency.USD)
        XCTAssert(amd500.value == 500.0 * 0.00209872)
    }

    func testCoding() {
        let currency = UnitCurrency.EUR
        let kCurrency = "CurrencyKey"

        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(currency, forKey: kCurrency)
        let encodedData = archiver.encodedData


        let unarchiver = NSKeyedUnarchiver(forReadingWith: encodedData)
        guard let decodedCurrency = unarchiver.decodeObject(forKey: kCurrency) as? UnitCurrency else {
            XCTFail("Encoded object is missing in the unarchiver.")
            return
        }

        XCTAssert(decodedCurrency == currency)
    }
    

    static var allTests = [
        ("testConvertion", testConvertion),
        ("testCoding", testCoding)
    ]

}
