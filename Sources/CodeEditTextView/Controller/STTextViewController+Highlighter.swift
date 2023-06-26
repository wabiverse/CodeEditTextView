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
import SwiftTreeSitter

extension STTextViewController
{
  /// Configures the `Highlighter` object
  internal func setUpHighlighter()
  {
    highlighter = Highlighter(
      textView: textView,
      highlightProvider: highlightProvider,
      theme: theme,
      attributeProvider: self,
      language: language
    )
  }

  /// Sets the highlight provider and re-highlights all text. This method should be used sparingly.
  internal func setHighlightProvider(_ highlightProvider: HighlightProviding? = nil)
  {
    var provider: HighlightProviding?

    if let highlightProvider
    {
      provider = highlightProvider
    }
    else
    {
      let textProvider: ResolvingQueryCursor.TextProvider = { [weak self] range, _ -> String? in
        self?.textView.textContentStorage?.textStorage?.mutableString.substring(with: range)
      }

      provider = TreeSitterClient(textProvider: textProvider)
    }

    if let provider
    {
      self.highlightProvider = provider
      highlighter?.setHighlightProvider(provider)
    }
  }

  /// Gets all attributes for the given capture including the line height, background color, and text color.
  /// - Parameter capture: The capture to use for syntax highlighting.
  /// - Returns: All attributes to be applied.
  public func attributesFor(_ capture: CaptureName?) -> [NSAttributedString.Key: Any]
  {
    [
      .font: font,
      .foregroundColor: theme.colorFor(capture),
      .baselineOffset: baselineOffset,
      .paragraphStyle: paragraphStyle,
      .kern: kern,
    ]
  }
}
