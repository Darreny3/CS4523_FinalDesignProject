//import UIKit
//
////struct Book: Decodable {
////    // MARK: - Properties
////    let username: String
////    let email: String
////    let sharing: Bool
//////    let hello: String
////}
//
//struct Book: Decodable {
//    let username: String
//    let email: String
//    let password: String
//    let sharing: Bool
//}
//
//struct ResponseObject<T: Decodable>: Decodable {
//    let form: T    // often the top level key is `data`, but in the case of https://httpbin.org, it echos the submission under the key `form`
//}
//
//let loginString = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuZWQiLCJleHAiOjE2NzA3OTAyNDd9.rEGAseNBWwHaT8RH_YPnRrBGdc5vm_jDm6bu733crnA"
//
//let loginData = Data(loginString.utf8)
//let base64LoginString = loginData.base64EncodedString()
//
//let base_url = URL(string: "https://amusing-honeysuckle-tungsten.glitch.me/")!
//
//var request = URLRequest(url: base_url)
//
//func makeGetCall() {
//    request.httpMethod = "GET"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let data = data {
//            if let books = try? JSONDecoder().decode(Book.self, from: data) {
//                print(books)
//            } else {
//                print(response.debugDescription)
//                print("Invalid Response")
//            }
//        } else if let error = error {
//            print("HTTP Request Failed \(error)")
//        }
//    }
//    task.resume()
//}
//
//func makePostCall() {
//
//}
//
////request.httpMethod = "POST"
//
//let parameters: [String: Any] = [
//    "username" : "jesus",
//    "email" : "jesus@nyu.edu",
//    "password" : "1234567890abcDEF!",
//    "sharing" : true
//]
//
//
//
//
////request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuZWQiLCJleHAiOjE2NzA3OTAyNDd9.rEGAseNBWwHaT8RH_YPnRrBGdc5vm_jDm6bu733crnA", forHTTPHeaderField: "Authorization")
//
//
//
//
////do {
////    // convert parameters to Data and assign dictionary to httpBody of request
////    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
////  } catch let error {
////    print(error.localizedDescription)
////    throw(error)
////  }
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//    if let error = error {
//        print("Post Request Error: \(error.localizedDescription)")
//        return
//    }
//
//    // ensure there is valid response code returned from this HTTP response
//    guard let httpResponse = response as? HTTPURLResponse,
//          (200...299).contains(httpResponse.statusCode)
//    else {
//        print("Invalid Response received from the server")
//        return
//    }
//
//    // ensure there is data returned
//    guard let responseData = data else {
//        print("nil Data received from the server")
//        return
//    }
//
//    do {
//        // create json object from data or use JSONDecoder to convert to Model stuct
//        if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
//            print(jsonResponse)
//            // handle json response
//        } else {
//            print("data maybe corrupted or in wrong format")
//            throw URLError(.badServerResponse)
//        }
//    } catch let error {
//        print(error.localizedDescription)
//    }
//}
//  // perform the task
////  task.resume()
