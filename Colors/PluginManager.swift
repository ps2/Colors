//
//  PluginManager.swift
//  Colors
//
//  Created by Pete Schwamb on 8/8/19.
//  Copyright © 2019 Pete Schwamb. All rights reserved.
//

import Foundation

struct AvailablePlugin {
    let name: String
    let bundle: Bundle
}

class PluginManager {
    private let pluginBundles: [Bundle]

    public init() {
        var bundles = [Bundle]()

        if let plugInsURL = Bundle.main.privateFrameworksURL {
            do {
                for pluginURL in try FileManager.default.contentsOfDirectory(at: plugInsURL, includingPropertiesForKeys: nil).filter{$0.path.contains(".framework")} {
                    print("Found plugin at \(pluginURL)")
                    if let bundle = Bundle(url: pluginURL) {
                        bundles.append(bundle)
                    }
                }
            } catch let error {
                print("Error loading plugins: \(String(describing: error))")
            }
        }
        self.pluginBundles = bundles
    }

    var availablePlugins: [AvailablePlugin] {
        return pluginBundles.compactMap({ (bundle) -> AvailablePlugin? in
            guard let name = bundle.object(forInfoDictionaryKey: "PluginName") as? String else {
                    return nil
            }

            return AvailablePlugin(name: name, bundle: bundle)
        })
    }
}
