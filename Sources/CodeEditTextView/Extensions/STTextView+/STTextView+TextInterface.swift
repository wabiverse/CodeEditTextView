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
import STTextView
import TextFormation
import TextStory

extension STTextView: TextInterface
{
  public var selectedRange: NSRange
  {
    get
    {
      self.selectedRange()
    }
    set
    {
      guard let textContentStorage
      else
      {
        return
      }
      if let textRange = NSTextRange(newValue, provider: textContentStorage)
      {
        setSelectedTextRange(textRange)
      }
    }
  }

  public var length: Int
  {
    textContentStorage?.length ?? 0
  }

  public func substring(from range: NSRange) -> String?
  {
    textContentStorage?.substring(from: range)
  }

  public func applyMutation(_ mutation: TextStory.TextMutation)
  {
    if let manager = undoManager
    {
      let inverse = inverseMutation(for: mutation)

      manager.registerUndo(withTarget: self, handler: { storable in
        storable.applyMutation(inverse)
      })
    }

    textContentStorage?.performEditingTransaction
    {
      textContentStorage?.applyMutation(mutation)
    }

    textDidChange(nil)
  }
}
