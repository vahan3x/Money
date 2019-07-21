import Foundation

/// A unit of measure for money.
///
/// You typically use instances of UnitCurrency to represent specific quantities of money using the 
/// [Measurement](https://developer.apple.com/documentation/foundation/measurement) class.
///
/// Money is any item or verifiable record that is generally accepted as payment for goods and services
/// and repayment of debts, such as taxes, in a particular country or socio-economic context. The main 
/// functions of money are distinguished as: a medium of exchange, a unit of account, a store of value 
/// and sometimes, a standard of deferred payment.[4][5] Any item or verifiable record that fulfils 
/// these functions can be considered as money.
public final class UnitCurrency: Dimension {

    // MARK: - Properties

    // MARK: Class

    /// The United States dollar is the official currency of the United States and its territories.
    public static let USD = UnitCurrency(symbol: "$", code: .USD, converter: UnitConverterLinear(coefficient: 1.0))

    /// The euro is the official currency of 19 of the 28 member states of the European Union.
    public static let EUR = UnitCurrency(symbol: "€", code: .EUR, converter: UnitConverterLinear(coefficient: 1.123349))

    /// The pound sterling is the official currency of the United Kingdom, Jersey, Guernsey, the Isle of Man, 
    /// South Georgia and the South Sandwich Islands, the British Antarctic Territory and Tristan da Cunha.
    public static let GBP = UnitCurrency(symbol: "£", code: .GBP, converter: UnitConverterLinear(coefficient: 1.25025))

    /// The Russian ruble is the currency of the Russian Federation, the two partially recognised republics 
    /// of Abkhazia and South Ossetia and the two unrecognised republics of Donetsk and Luhansk.
    public static let RUR = UnitCurrency(symbol: "₽", code: .RUR, converter: UnitConverterLinear(coefficient: 0.01587))

    /// The yen is the official currency of Japan.
    public static let JPY = UnitCurrency(symbol: "‎¥", code: .JPY, converter: UnitConverterLinear(coefficient: 0.009283))

    /// The Australian dollar is the legal tender of Australia and the currency of three independent Pacific 
    /// Island states, specifically Kiribati, Nauru, and Tuvalu.
    public static let AUD = UnitCurrency(symbol: "A$", code: .AUD, converter: UnitConverterLinear(coefficient: 0.7042))

    /// The Canadian dollar is the currency of Canada.
    public static let CAD = UnitCurrency(symbol: "C$", code: .CAD, converter: UnitConverterLinear(coefficient: 0.764905))

    /// The dram is the monetary unit of Armenia and the neighboring unrecognized Republic of Artsakh.
    public static let AMD = UnitCurrency(symbol: "֏", code: .AMD, converter: UnitConverterLinear(coefficient: 0.00209872))

    // MARK: Instance

    /// A ISO 4217 representation of the currency code.
    public let code: Code

    // MARK: - Methods

    // MARK: Class

    /// Returns the base currency.
    ///
    /// The base currency is `USD`.
    public final override class func baseUnit() -> UnitCurrency { return .USD }

    /// Two currencies are considered equal if their `code` and `symbol` fields match.
    /// If you create two currencies with equal codes and symbols, but with different
    /// converters the behaviour is undefined.
    public static func == (lhs: UnitCurrency, rhs: UnitCurrency) -> Bool {
        return lhs.code == rhs.code && lhs.symbol == rhs.symbol
    }

    // MARK: Instance

    /// The required initializer provided by [`Unit`](https://developer.apple.com/documentation/foundation/unit)
    /// superclass. Unavailable for the current class, use `init(symbol:code:converter:)` instead.
    @available(*, unavailable)
    public required init(symbol: String) {
        fatalError("Use init(symbol:code:converter:) instead.")
    }

    /// The required initializer provided by [`Dimension`](https://developer.apple.com/documentation/foundation/dimension)
    /// superclass. Unavailable for the current class, use `init(symbol:code:converter:)` instead.
    @available(*, unavailable)
    public required init(symbol: String, converter: UnitConverter) {
        fatalError("Use init(symbol:code:converter:) instead.")
    }

    /// Initializes a currency from an [`NSCoder`](https://developer.apple.com/documentation/foundation/nscoder) object.
    public required init?(coder aDecoder: NSCoder) { 
        guard let codeString = aDecoder.decodeObject(forKey: CodingKeys.code.rawValue) as? String,
            let code = Code(rawValue: codeString) else { return nil }
        self.code = code

        super.init(coder: aDecoder)
    }

    /// Initializes a currency with specified symbol, code and converter.
    ///
    /// - Parameters:
    ///   - symbol: The symbol used to represent the currency.
    ///   - code: A `Code` representation of the currency.
    ///   - converter: A unit converter used to represent the currency in terms of the base currency(`USD`).
    public init(symbol: String, code: Code, converter: UnitConverter) {
        self.code = code
        super.init(symbol: symbol, converter: converter)
    }

    /// Encodes the currency to an [`NSCoder`](https://developer.apple.com/documentation/foundation/nscoder) object.
    public override func encode(with aCoder: NSCoder) {
        aCoder.encode(code.rawValue, forKey: CodingKeys.code.rawValue)

        super.encode(with: aCoder)
    }

}

// MARK: - Nested Types

public extension UnitCurrency {

    /// An enumeration of keys used in object encoding/decoding.
    fileprivate enum CodingKeys: String {
        case code
    }

    /// An enumeration of currency codes in ISO 4217 standard.
    enum Code: String {
        case USD
        case EUR
        case GBP
        case RUR
        case JPY
        case AUD
        case CAD
        case AMD
    }
    
}