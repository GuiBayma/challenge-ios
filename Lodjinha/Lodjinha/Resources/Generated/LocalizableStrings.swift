// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// About
  internal static let aboutTab = L10n.tr("Localizable", "ABOUT_TAB")
  /// Back
  internal static let backNavigationButton = L10n.tr("Localizable", "BACK_NAVIGATION_BUTTON")
  /// Best sellers
  internal static let bestSellersSectionTitle = L10n.tr("Localizable", "BEST_SELLERS_SECTION_TITLE")
  /// a Lodjinha
  internal static let brandName = L10n.tr("Localizable", "BRAND_NAME")
  /// Categories
  internal static let categoriesSectionTitle = L10n.tr("Localizable", "CATEGORIES_SECTION_TITLE")
  /// Category: %@
  internal static func categoryTitleLabel(_ p1: String) -> String {
    return L10n.tr("Localizable", "CATEGORY_TITLE_LABEL", p1)
  }
  /// Now %@
  internal static func currentPriceLabel(_ p1: String) -> String {
    return L10n.tr("Localizable", "CURRENT_PRICE_LABEL", p1)
  }
  /// Guilherme Bayma
  internal static let developerName = L10n.tr("Localizable", "DEVELOPER_NAME")
  /// June 08, 2019
  internal static let developmentDate = L10n.tr("Localizable", "DEVELOPMENT_DATE")
  /// Home
  internal static let homeTab = L10n.tr("Localizable", "HOME_TAB")
  /// Was: %@
  internal static func oldPriceLabel(_ p1: String) -> String {
    return L10n.tr("Localizable", "OLD_PRICE_LABEL", p1)
  }
  /// Reserve
  internal static let reserveButtonTitle = L10n.tr("Localizable", "RESERVE_BUTTON_TITLE")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
