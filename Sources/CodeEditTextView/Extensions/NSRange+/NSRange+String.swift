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

extension String
{
  /// make string subscriptable with NSRange
  subscript(value: NSRange) -> Substring?
  {
    let upperBound = String.Index(utf16Offset: Int(value.upperBound), in: self)
    let lowerBound = String.Index(utf16Offset: Int(value.lowerBound), in: self)
    if upperBound <= endIndex
    {
      return self[lowerBound ..< upperBound]
    }
    else
    {
      return nil
    }
  }
}
