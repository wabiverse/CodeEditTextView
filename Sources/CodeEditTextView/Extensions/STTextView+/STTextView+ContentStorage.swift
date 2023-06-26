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

import AppKit
import Foundation
import STTextView

extension STTextView
{
  /// Convenience that unwraps `textContentManager` as an `NSTextContentStorage` subclass.
  var textContentStorage: NSTextContentStorage?
  {
    textContentManager as? NSTextContentStorage
  }
}
