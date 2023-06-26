/* -----------------------------------------------------------
 * :: :  C  O  S  M  O  :                                   ::
 * -----------------------------------------------------------
 * @wabistudios :: cosmos :: realms
 *
 * CREDITS.
 *
 * T.Furby              @furby-tm       <devs@wabi.foundation>
 *
 *         Copyright (C) 2023 Wabi Animation Studios, Ltd. Co.
 *                                        All Rights Reserved.
 * -----------------------------------------------------------
 *  . x x x . o o o . x x x . : : : .    o  x  o    . : : : .
 * ----------------------------------------------------------- */

/// Represents what to insert on a tab key press.
public enum IndentOption: Equatable
{
  case spaces(count: Int)
  case tab

  var stringValue: String
  {
    switch self
    {
      case let .spaces(count):
        return String(repeating: " ", count: count)
      case .tab:
        return "\t"
    }
  }

  public static func == (lhs: IndentOption, rhs: IndentOption) -> Bool
  {
    switch (lhs, rhs)
    {
      case (.tab, .tab):
        return true
      case let (.spaces(lhsCount), .spaces(rhsCount)):
        return lhsCount == rhsCount
      default:
        return false
    }
  }
}
