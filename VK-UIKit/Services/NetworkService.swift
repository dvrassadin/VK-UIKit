//
//  NetworkService.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 21/11/23.
//

import Foundation

final class NetworkService {
    static var token = ""
    private let baseURL = URL(string: "https://api.vk.com/method")
    
    func getFriends(completion: @escaping ([User]) -> Void) {
        guard var url = baseURL else { return }
        
        url.append(path: "friends.get")
        
        url.append(queryItems: [
            URLQueryItem(name: "fields", value: "photo_200,online"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "access_token", value: Self.token),
            URLQueryItem(name: "v", value: "5.199")
        ])
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let users = try decoder.decode(VKResponse<User>.self, from: data).response.items
                completion(users)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroups() {
        guard var url = baseURL else { return }
        
        url.append(path: "groups.get")
        
        url.append(queryItems: [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "access_token", value: Self.token),
            URLQueryItem(name: "v", value: "5.199")
        ])
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let users = try decoder.decode(VKResponse<Group>.self, from: data).response.items
                print("------Groups------")
                users.forEach { print($0) }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getPhotos(completion: @escaping ([Photo]) -> Void) {
        guard var url = baseURL else { return }
        
        url.append(path: "photos.getAll")
        
        url.append(queryItems: [
            URLQueryItem(name: "access_token", value: Self.token),
            URLQueryItem(name: "v", value: "5.199")
        ])
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let users = try decoder.decode(VKResponse<Photo>.self, from: data).response.items
                completion(users)
            } catch {
                print(error)
            }
        }.resume()
    }
}
