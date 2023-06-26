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

extension STTextViewController
{
  /// Update the text view's text container if needed.
  ///
  /// Effectively updates the container to reflect the `wrapLines` setting, and to reflect any updates to the ruler,
  /// scroll view, or window frames.
  func updateTextContainerWidthIfNeeded()
  {
    let previousTrackingSetting = textView.widthTracksTextView
    textView.widthTracksTextView = wrapLines
    if wrapLines
    {
      var proposedSize = ((view as? NSScrollView)?.contentSize ?? .zero)
      proposedSize.height = .greatestFiniteMagnitude

      if textView.textContainer.size != proposedSize || textView.frame.size != proposedSize
      {
        textView.textContainer.size = proposedSize
        textView.setFrameSize(proposedSize)
      }
    }
    else
    {
      var proposedSize = textView.frame.size
      proposedSize.width = ((view as? NSScrollView)?.contentSize ?? .zero).width
      if previousTrackingSetting != wrapLines
      {
        textView.textContainer.size = CGSize(
          width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude
        )
        textView.setFrameSize(proposedSize)
        textView.textLayoutManager.textViewportLayoutController.layoutViewport()
      }
    }
  }
}
