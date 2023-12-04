//
//  DataConvertor.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/4/23.
//

import Foundation

final class DataConvertor {
    static func convertDataToDictionary(data: Data) -> [String : Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return json as? [String : Any]
        } catch let error as NSError {
            print("======== DataConvertor convertDataToDictionary : \(error)")
            return nil
        }
    }
    
    static func convertDictionaryToCodable<T>(dict: [String : Any]) -> T? where T : Decodable {
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: [])
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("======== DataConvertor convertDictionaryToCodable : \(error)")
            return nil
        }
    }
}
