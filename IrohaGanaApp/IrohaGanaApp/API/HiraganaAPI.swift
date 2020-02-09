//
//  HiraganaAPI.swift
//  IrohaGanaApp
//
//  Created by aokita on 2020/02/03.
//  Copyright © 2020 irodori. All rights reserved.
//

import Foundation

///
/// gooラボ　ひらがな化API
///
/// - Note:
/// https://labs.goo.ne.jp/api/jp/hiragana-translation/
///
struct HiraganaAPI {

    /// ひらがな化API - URL
    private static let _ReqUrl: String = "https://labs.goo.ne.jp/api/hiragana"
 
    /// ひらがな化API - アプリケーションID
    private static let _AppID: String = "3ace14d7b52a05c36210d7f1ecb07c72aeb6b54c53d34d0505dca6666b20cdc1"
    
    ///
    /// ルビ取得
    ///
    public static func RequestRuby(text: String, callback: @escaping (Bool, String) -> Void) {
        var request: URLRequest = URLRequest(url: URL(string: HiraganaAPI._ReqUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  
        let postData: ReqParams = ReqParams(app_id: HiraganaAPI._AppID,
                                            request_id: "record_001",
                                            sentence: text,
                                            output_type: "hiragana")
        
        guard let uploadData: Data? = try? JSONEncoder().encode(postData) else {
            IrohaGanaLog.Error("failed to create post data")
            callback(false, "")
            return
        }
        request.httpBody = uploadData
        
        let task: URLSessionUploadTask = URLSession.shared.uploadTask(with: request, from: uploadData){ data, response, error in
            if let error: Error = error {
                IrohaGanaLog.Error(error)
                callback(false, "")
                return
            }
            
            guard let response: HTTPURLResponse = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    IrohaGanaLog.Error("server error")
                    callback(false, "")
                    return
            }
            
            guard let data: Data = data, let jsonData: ResponceData = try? JSONDecoder().decode(ResponceData.self, from: data) else {
                IrohaGanaLog.Error("failed to parse json")
                callback(false, "")
                return
            }

            callback(true, jsonData.converted)
            IrohaGanaLog.Debug(jsonData.converted)
        }
        task.resume()
    }
}

///
/// ひらがな化API - リクエストパラメータ
///
struct ReqParams: Codable {
    var app_id: String
    var request_id: String
    var sentence: String
    var output_type: String
}

///
/// ひらがな化API -  レスポンスデータ
///
struct ResponceData:Codable {
    var request_id: String
    var output_type: String
    var converted: String
}
