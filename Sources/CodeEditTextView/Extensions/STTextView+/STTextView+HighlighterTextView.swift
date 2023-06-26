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
import STTextView

/// A default implementation for `STTextView` to be passed to `HighlightProviding` objects.
extension STTextView: HighlighterTextView
{
  public var documentRange: NSRange
  {
    NSRange(
      location: 0,
      length: textContentStorage?.textStorage?.length ?? 0
    )
  }

  public func stringForRange(_ nsRange: NSRange) -> String?
  {
    textContentStorage?.textStorage?.mutableString.substring(with: nsRange)
  }
}
