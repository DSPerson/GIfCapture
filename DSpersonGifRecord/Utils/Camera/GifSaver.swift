//
//  GifSaver.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/20.
//  Copyright © 2019 DSperson. All rights reserved.
//

import Foundation
import NSGIF
class GifSaver {
    typealias Completion = (URL?) -> Void
    func save(videoURL : URL, completion : @escaping Completion) {
        NSGIF.optimalGIFfromURL(videoURL, loopCount: 0) { [weak self](url) in
            self?.copy(url: url, completion: completion)
        }

    }
    func copy(url : URL?, completion : @escaping Completion) {
        guard let url = url else {
            completion(nil)
            return
        }
        defer {///最后一步执行
            removeItem(url: url)
        }
        do {
            let gifURL = self.gifURL()
            try FileManager.default.copyItem(at: url, to: gifURL)
            completion(gifURL)
        } catch {
            completion(nil)
        }
    }
    func removeItem(url : URL) {
        try? FileManager.default.removeItem(at: url)
    }
    func gifURL() -> URL {
        let dateString = Utils.formatter.string(from: Date())
        return URL(fileURLWithPath: StatusControlManager.share.savePath)
        .appendingPathComponent(dateString)
        .appendingPathExtension("gif")
    }
}
