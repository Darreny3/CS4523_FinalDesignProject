//
//  user.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 12/9/22.
//

import Foundation

struct Records: Decodable, Identifiable {
    let leaderboard: [User]
    let id = UUID()
}

//struct for user data in leaderboard
struct User: Decodable, Identifiable{
    let id = UUID()
    let rank: Int
    let user: String
    let sharing: Bool
    let footprint: Double
}

//struct for user data
struct UserStruct: Decodable {
    let username: String
    let email: String
    let sharing: Bool
}

//struct for successful activity post
struct activityResponse: Decodable {
    let username: String
    let timestamp: String
    let category: String
    let activity: String
    let usage: Double
    let emission: Double
    let id: Int
    let user: UserStruct
}

//Struct for user profile page
struct UserPageData: Decodable {
    let rank: Int
    let user: String
    let sharing: Bool
    let footprint: Double
}


//Struct for line graph
struct LineData: Decodable, Identifiable {
    let id = UUID()
    let username: String
    let timestamp: String
    let category: String?
    let activity: String?
    let usage: Double?
    let emission: Double
}

struct ResponseObject<T: Decodable>: Decodable {
    let form: T
}
