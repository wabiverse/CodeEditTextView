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
import SwiftTreeSitter

extension HighlighterTextView
{
  func createReadBlock() -> Parser.ReadBlock
  {
    { byteOffset, _ in
      let limit = self.documentRange.length
      let location = byteOffset / 2
      let end = min(location + 1024, limit)
      if location > end
      {
        // Ignore and return nothing, tree-sitter's internal tree can be incorrect in some situations.
        return nil
      }
      let range = NSRange(location ..< end)
      return self.stringForRange(range)?.data(using: String.nativeUTF16Encoding)
    }
  }
}
