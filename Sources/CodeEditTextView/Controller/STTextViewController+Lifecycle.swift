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

public extension STTextViewController
{
  override func loadView()
  {
    textView = STTextView()

    let scrollView = CEScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.hasVerticalScroller = true
    scrollView.documentView = textView
    scrollView.automaticallyAdjustsContentInsets = contentInsets == nil

    rulerView = STLineNumberRulerView(textView: textView, scrollView: scrollView)
    rulerView.drawSeparator = false
    rulerView.baselineOffset = baselineOffset
    rulerView.allowsMarkers = false
    rulerView.backgroundColor = .clear
    rulerView.textColor = .secondaryLabelColor

    scrollView.verticalRulerView = rulerView
    scrollView.rulersVisible = true

    textView.typingAttributes = attributesFor(nil)
    textView.typingAttributes[.paragraphStyle] = paragraphStyle
    textView.font = font
    textView.insertionPointWidth = 1.0
    textView.backgroundColor = .clear

    textView.string = text.wrappedValue
    textView.allowsUndo = true
    textView.setupMenus()
    textView.delegate = self

    scrollView.documentView = textView
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.backgroundColor = useThemeBackground ? theme.background : .clear

    view = scrollView

    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    NSEvent.addLocalMonitorForEvents(matching: .keyDown)
    { event in
      self.keyDown(with: event)
      return event
    }

    reloadUI()
    setUpHighlighter()
    setHighlightProvider(highlightProvider)
    setUpTextFormation()

    setCursorPosition(cursorPosition.wrappedValue)
  }

  override func viewDidLoad()
  {
    super.viewDidLoad()

    NotificationCenter.default.addObserver(forName: NSWindow.didResizeNotification,
                                           object: nil,
                                           queue: .main)
    { [weak self] _ in
      guard let self else { return }
      (view as? NSScrollView)?.contentView.contentInsets.bottom = bottomContentInsets
      updateTextContainerWidthIfNeeded()
    }

    NotificationCenter.default.addObserver(
      forName: STTextView.didChangeSelectionNotification,
      object: nil,
      queue: .main
    )
    { [weak self] _ in
      let textSelections = self?.textView.textLayoutManager.textSelections.flatMap(\.textRanges)
      guard self?.lastTextSelections != textSelections
      else
      {
        return
      }
      self?.lastTextSelections = textSelections ?? []

      self?.updateCursorPosition()
      self?.highlightSelectionPairs()
    }

    NotificationCenter.default.addObserver(
      forName: NSView.frameDidChangeNotification,
      object: (view as? NSScrollView)?.verticalRulerView,
      queue: .main
    )
    { [weak self] _ in
      self?.updateTextContainerWidthIfNeeded()
      if self?.bracketPairHighlight == .flash
      {
        self?.removeHighlightLayers()
      }
    }

    systemAppearance = NSApp.effectiveAppearance.name

    NSApp.publisher(for: \.effectiveAppearance)
      .receive(on: RunLoop.main)
      .sink
      { [weak self] newValue in
        guard let self else { return }

        if systemAppearance != newValue.name
        {
          systemAppearance = newValue.name
        }
      }
      .store(in: &cancellables)
  }

  override func viewWillAppear()
  {
    super.viewWillAppear()
    updateTextContainerWidthIfNeeded()
  }
}
