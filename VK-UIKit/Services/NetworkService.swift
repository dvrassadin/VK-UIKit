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
    
    func getFriends(completion: @escaping ([Friend]) -> Void) {
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
                let friends = try decoder.decode(FriendsResponse.self, from: data).response.items
                completion(friends)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
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
                let groups = try decoder.decode(GroupsResponse.self, from: data).response.items
                completion(groups)
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
                let photos = try decoder.decode(PhotosResponse.self, from: data).response.items
                completion(photos)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getUser(with id: Int? = nil, completion: @escaping ([User]) -> Void) {
        guard var url = baseURL else { return }
        
        url.append(path: "users.get")
        
        if let id {
            url.append(queryItems: [URLQueryItem(name: "user_ids", value: String(id))])
        }
        
        url.append(queryItems: [
            URLQueryItem(name: "fields", value: "photo_400_orig"),
            URLQueryItem(name: "access_token", value: Self.token),
            URLQueryItem(name: "v", value: "5.199")
        ])
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let user = try decoder.decode(UsersResponse.self, from: data).response
                completion(user)
            } catch {
                print(error)
            }
        }.resume()
    }
}
