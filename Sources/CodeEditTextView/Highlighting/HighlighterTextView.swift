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

/// The object `HighlightProviding` objects are given when asked for highlights.
public protocol HighlighterTextView: AnyObject
{
  /// The entire range of the document.
  var documentRange: NSRange { get }
  /// A substring for the requested range.
  func stringForRange(_ nsRange: NSRange) -> String?
}
