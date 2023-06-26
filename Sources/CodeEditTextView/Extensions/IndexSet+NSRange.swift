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

import Foundation

extension NSRange
{
  /// Convenience getter for safely creating a `Range<Int>` from an `NSRange`
  var intRange: Range<Int>
  {
    location ..< NSMaxRange(self)
  }
}

/// Helpers for working with `NSRange`s and `IndexSet`s.
extension IndexSet
{
  /// Initializes the  index set with a range of integers
  init(integersIn range: NSRange)
  {
    self.init(integersIn: range.intRange)
  }

  /// Remove all the integers in the `NSRange`
  mutating func remove(integersIn range: NSRange)
  {
    remove(integersIn: range.intRange)
  }

  /// Insert all the integers in the `NSRange`
  mutating func insert(integersIn range: NSRange)
  {
    insert(integersIn: range.intRange)
  }

  /// Returns true if self contains all of the integers in range.
  func contains(integersIn range: NSRange) -> Bool
  {
    contains(integersIn: range.intRange)
  }
}
