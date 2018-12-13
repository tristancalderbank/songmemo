//
//  FileSystem.swift
//  songmemo
//
//  Created by testuser1 on 2018-12-12.
//  Copyright © 2018 songmemo. All rights reserved.
//

import Foundation

func getDocumentsURL() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = paths.first!
    return documentDirectory
}

func getDirectoryContents(url: URL) -> [URL] {
    do {
        let directoryContents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        return directoryContents
    }
    catch {
        print(error.localizedDescription)
    }
    return []
}

func getAudioFiles() -> [URL] {
    return getDirectoryContents(url: getDocumentsURL()).filter{ $0.pathExtension == "m4a" }
}

func getFileName(url: URL) -> String {
    return url.deletingPathExtension().lastPathComponent
}

func deleteFile(url: URL) {
    let fileManager = FileManager.default
    do {
        try fileManager.removeItem(atPath: url.path)
    }
    catch {
        print("Failed to delete file")
    }
}

func getFileModifiedDate(url: URL) -> Date? {
    do {
        let attr = try FileManager.default.attributesOfItem(atPath: url.path)
        return attr[FileAttributeKey.modificationDate] as? Date
    } catch {
        return nil
    }
}

//
//func getFilenames() {
//
//    let m4aFileNames = m4aFiles.map{ $0.deletingPathExtension().lastPathComponent }
//    print("m4a list:", m4aFileNames)
//}


