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

/// This class represents a range to highlight, as well as the capture name for syntax coloring.
public class HighlightRange
{
  init(range: NSRange, capture: CaptureName?)
  {
    self.range = range
    self.capture = capture
  }

  let range: NSRange
  let capture: CaptureName?
}
