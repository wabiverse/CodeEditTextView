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

class CEScrollView: NSScrollView
{
  override open var contentSize: NSSize
  {
    var proposedSize = super.contentSize
    proposedSize.width -= verticalRulerView?.requiredThickness ?? 0.0
    return proposedSize
  }

  override func mouseDown(with event: NSEvent)
  {
    if let textView = documentView as? STTextView,
       !textView.visibleRect.contains(event.locationInWindow)
    {
      // If the `scrollView` was clicked, but the click did not happen within the `textView`,
      // set cursor to the last index of the `textView`.

      let endLocation = textView.textLayoutManager.documentRange.endLocation
      let range = NSTextRange(location: endLocation)
      _ = textView.becomeFirstResponder()
      textView.setSelectedTextRange(range)
    }

    super.mouseDown(with: event)
  }
}
