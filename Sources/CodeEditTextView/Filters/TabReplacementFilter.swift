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
import TextFormation
import TextStory

/// Filter for replacing tab characters with the user-defined indentation unit.
/// - Note: The undentation unit can be another tab character, this is merely a point at which this can be configured.
struct TabReplacementFilter: Filter
{
  let indentOption: IndentOption

  func processMutation(_ mutation: TextMutation, in interface: TextInterface) -> FilterAction
  {
    if mutation.string == "\t", indentOption != .tab, mutation.delta > 0
    {
      interface.applyMutation(TextMutation(insert: indentOption.stringValue,
                                           at: mutation.range.location,
                                           limit: mutation.limit))
      return .discard
    }
    else
    {
      return .none
    }
  }
}
