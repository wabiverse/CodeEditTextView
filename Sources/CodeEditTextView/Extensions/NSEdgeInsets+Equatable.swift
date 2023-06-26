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

extension NSEdgeInsets: Equatable
{
  public static func == (lhs: NSEdgeInsets, rhs: NSEdgeInsets) -> Bool
  {
    lhs.bottom == rhs.bottom &&
      lhs.top == rhs.top &&
      lhs.left == rhs.left &&
      lhs.right == rhs.right
  }
}
