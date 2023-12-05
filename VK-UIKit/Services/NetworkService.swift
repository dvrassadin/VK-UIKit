//
//  NetworkService.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 21/11/23.
//

import Foundation

enum NetworkError: Error {
    case  invalidURL, invalidData, noData
}

final class NetworkService {
    static var token = ""
    private let baseURL = URL(string: "https://api.vk.com/method")
    private let dataService = DataService()
    
    func getFriends(completion: @escaping (Result<[Friend], NetworkError>) -> Void) {
        guard var url = baseURL else {
            completion(.failure(.invalidURL))
            return
        }
        
        url.append(path: "friends.get")
        
        url.append(queryItems: [
            URLQueryItem(name: "fields", value: "photo_200,online"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "access_token", value: Self.token),
            URLQueryItem(name: "v", value: "5.199")
        ])
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let friends = try decoder.decode(FriendsResponse.self, from: data).response.items
                self.dataService.add(friends: friends)
                completion(.success(friends))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    func getGroups(completion: @escaping (Result<[Group], NetworkError>) -> Void) {
        guard var url = baseURL else {
            completion(.failure(.invalidURL))
            return
        }
        
        url.append(path: "groups.get")
        
        url.append(queryItems: [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "access_token", value: Self.token),
            URLQueryItem(name: "v", value: "5.199")
        ])
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let groups = try decoder.decode(GroupsResponse.self, from: data).response.items
                self.dataService.add(groups: groups)
                completion(.success(groups))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    func getPhotos(completion: @escaping (Result<[Photo], NetworkError>) -> Void) {
        guard var url = baseURL else {
            completion(.failure(.invalidURL))
            return
        }
        
        url.append(path: "photos.getAll")
        
        url.append(queryItems: [
            URLQueryItem(name: "access_token", value: Self.token),
            URLQueryItem(name: "v", value: "5.199")
        ])
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let photos = try decoder.decode(PhotosResponse.self, from: data).response.items
                completion(.success(photos))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    func getUser(with id: Int? = nil, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard var url = baseURL else {
            completion(.failure(.invalidURL))
            return
        }
        
        url.append(path: "users.get")
        
        if let id {
            url.append(queryItems: [URLQueryItem(name: "user_ids", value: String(id))])
        }
        
        url.append(queryItems: [
            URLQueryItem(name: "fields", value: "photo_400_orig"),
            URLQueryItem(name: "access_token", value: Self.token),
            URLQueryItem(name: "v", value: "5.199")
        ])
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let user = try decoder.decode(UsersResponse.self, from: data).response
                completion(.success(user))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}
