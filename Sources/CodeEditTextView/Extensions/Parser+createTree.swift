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

extension Parser
{
  /// Creates a tree-sitter tree.
  /// - Parameters:
  ///   - parser: The parser object to use to parse text.
  ///   - readBlock: A callback for fetching blocks of text.
  /// - Returns: A tree if it could be parsed.
  func createTree(readBlock: @escaping Parser.ReadBlock) -> Tree?
  {
    parse(tree: nil, readBlock: readBlock)
  }
}
