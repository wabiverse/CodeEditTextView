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

extension String
{
  static var nativeUTF16Encoding: String.Encoding
  {
    let dataA = "abc".data(using: .utf16LittleEndian)
    let dataB = "abc".data(using: .utf16)?.suffix(from: 2)

    return dataA == dataB ? .utf16LittleEndian : .utf16BigEndian
  }
}
