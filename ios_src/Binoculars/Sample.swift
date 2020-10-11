/* Copyright (c) 2017 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit

enum Sample: CaseIterable {
    case Heatmaps
    case List
}

extension Sample {
  var title: String {
    switch self {
        case .Heatmaps: return "Traffic map"
    case .List: return "List"
    }
  }
  
  var description: String {
    switch self {
        case .Heatmaps: return "Show map of Luxembourg City"
    case .List: return "Show list of places"
    }
  }
  
  var controller: UIViewController.Type {
    switch self {
    case .Heatmaps: return HeatmapViewController.self
    case .List: return ListViewController.self
    }
  }
}
