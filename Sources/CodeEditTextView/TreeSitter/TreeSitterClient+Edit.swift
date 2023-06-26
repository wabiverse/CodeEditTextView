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

import CodeEditLanguages
import Foundation
import SwiftTreeSitter

extension TreeSitterClient
{
  /// This class contains an edit state that can be resumed if a parser hits a timeout.
  class EditState
  {
    var edit: InputEdit
    var rangeSet: IndexSet
    var layerSet: Set<LanguageLayer>
    var touchedLayers: Set<LanguageLayer>
    var completion: (IndexSet) -> Void

    init(
      edit: InputEdit,
      minimumCapacity: Int = 0,
      completion: @escaping (IndexSet) -> Void
    )
    {
      self.edit = edit
      rangeSet = IndexSet()
      layerSet = Set(minimumCapacity: minimumCapacity)
      touchedLayers = Set(minimumCapacity: minimumCapacity)
      self.completion = completion
    }
  }

  /// Applies the given edit to the current state and calls the editState's completion handler.
  /// - Parameters:
  ///   - editState: The edit state to apply.
  ///   - startAtLayerIndex: An optional layer index to start from if some work has already been done on this edit
  ///                        state object.
  ///   - runningAsync: Determine whether or not to timeout long running parse tasks.
  func applyEdit(editState: EditState, startAtLayerIndex: Int? = nil, runningAsync: Bool = false)
  {
    guard let readBlock, let textView, let state else { return }
    stateLock.lock()

    // Loop through all layers, apply edits & find changed byte ranges.
    let startIdx = startAtLayerIndex ?? 0
    for layerIdx in (startIdx ..< state.layers.count).reversed()
    {
      let layer = state.layers[layerIdx]

      if layer.id != state.primaryLayer.id
      {
        // Reversed for safe removal while looping
        for rangeIdx in (0 ..< layer.ranges.count).reversed()
        {
          layer.ranges[rangeIdx].applyInputEdit(editState.edit)

          if layer.ranges[rangeIdx].length <= 0
          {
            layer.ranges.remove(at: rangeIdx)
          }
        }
        if layer.ranges.isEmpty
        {
          state.removeLanguageLayer(at: layerIdx)
          continue
        }

        editState.touchedLayers.insert(layer)
      }

      layer.parser.includedRanges = layer.ranges.map(\.tsRange)
      do
      {
        try editState.rangeSet.insert(
          ranges: layer.findChangedByteRanges(
            textView: textView,
            edit: editState.edit,
            timeout: runningAsync ? nil : Constants.parserTimeout,
            readBlock: readBlock
          )
        )
      }
      catch
      {
        // Timed out, queue an async edit with any data already computed.
        if !runningAsync
        {
          applyEditAsync(editState: editState, startAtLayerIndex: layerIdx)
        }
        stateLock.unlock()
        return
      }

      editState.layerSet.insert(layer)
    }

    // Update the state object for any new injections that may have been caused by this edit.
    editState.rangeSet.formUnion(
      state.updateInjectedLayers(textView: textView, touchedLayers: editState.touchedLayers)
    )

    stateLock.unlock()
    if runningAsync
    {
      DispatchQueue.main.async
      {
        editState.completion(editState.rangeSet)
      }
    }
    else
    {
      editState.completion(editState.rangeSet)
    }
  }

  /// Enqueues the given edit state to be applied asynchronously.
  /// - Parameter editState: The edit state to enqueue.
  func applyEditAsync(editState: EditState, startAtLayerIndex: Int)
  {
    queuedEdits.append
    {
      self.applyEdit(editState: editState, startAtLayerIndex: startAtLayerIndex, runningAsync: true)
    }
    beginTasksIfNeeded()
  }
}
