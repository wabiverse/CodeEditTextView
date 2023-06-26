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

/// A newline filter almost entirely similar to `TextFormation`s standard implementation.
struct NewlineFilter: Filter
{
  private let recognizer: ConsecutiveCharacterRecognizer
  let providers: WhitespaceProviders

  init(whitespaceProviders: WhitespaceProviders)
  {
    recognizer = ConsecutiveCharacterRecognizer(matching: "\n")
    providers = whitespaceProviders
  }

  func processMutation(_ mutation: TextStory.TextMutation,
                       in interface: TextFormation.TextInterface) -> TextFormation.FilterAction
  {
    recognizer.processMutation(mutation)

    switch recognizer.state
    {
      case .triggered:
        return filterHandler(mutation, in: interface)
      case .tracking, .idle:
        return .none
    }
  }

  private func filterHandler(_ mutation: TextMutation, in interface: TextInterface) -> FilterAction
  {
    interface.applyMutation(mutation)

    let range = NSRange(location: mutation.postApplyRange.max, length: 0)

    let value = providers.leadingWhitespace(range, interface)

    interface.insertString(value, at: mutation.postApplyRange.max)

    return .discard
  }
}
