/* Copyright (c) 2016 Google Inc.
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

import GoogleMaps
import UIKit

// Change this key to a valid key registered with the demo app bundle id.
let mapsAPIKey = "AIzaSyDPAw8Ry_libv-n-dYZpyczu5F73pXsS34"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    if mapsAPIKey.isEmpty {
      fatalError("Please provide an API Key using mapsAPIKey")
    }
    GMSServices.provideAPIKey(mapsAPIKey)
    let masterViewControler = MasterViewController()
    let navigationController = UINavigationController(rootViewController: masterViewControler)
    window?.rootViewController = navigationController
        
    let url = URL(string: "http://127.0.0.1:8000/places")!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }

        let file = "file.txt" //this is the file. we will write to and read from it
        let text = String(data: data, encoding: .utf8) ?? ""

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)

            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}

            //reading
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                print(text2)
            }
            catch {/* error handling here */}
        }
    }

    task.resume()

    return true
  }
}

