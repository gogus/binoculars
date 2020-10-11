//
//  FilesManager.swift
//  SwiftDemoApp
//
//  Created by Mikołaj Goguła on 10/10/2020.
//  Copyright © 2020 Google. All rights reserved.
//

import Foundation

class FilesManager {
    enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case writtingFailed
        case fileNotExists
        case readingFailed
    }
    let fileManager: FileManager
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    func save(fileNamed: String, data: Data) throws {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        if fileManager.fileExists(atPath: url.absoluteString) {
            throw Error.fileAlreadyExists
        }
        do {
            try data.write(to: url)
        } catch {
            debugPrint(error)
            throw Error.writtingFailed
        }
    }
    private func makeURL(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }
    func read(fileNamed: String) throws -> Data {
       guard let url = makeURL(forFileNamed: fileNamed) else {
           throw Error.invalidDirectory
       }
       guard fileManager.fileExists(atPath: url.absoluteString) else {
           throw Error.fileNotExists
       }
       do {
           return try Data(contentsOf: url)
       } catch {
           debugPrint(error)
           throw Error.readingFailed
       }
   }
}
