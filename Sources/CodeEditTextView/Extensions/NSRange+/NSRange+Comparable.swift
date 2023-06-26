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

extension NSRange: Comparable
{
  public static func == (lhs: NSRange, rhs: NSRange) -> Bool
  {
    lhs.location == rhs.location && lhs.length == rhs.length
  }

  public static func < (lhs: NSRange, rhs: NSRange) -> Bool
  {
    lhs.location < rhs.location
  }
}
