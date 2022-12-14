//
//  Singin.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 12/12/22.
//


import Combine
import Foundation

class SignInViewModel: ObservableObject {
        
    @Published var hasError = false
    
    @Published var canSignIn = false
    
    @Published var records: Records = Records(leaderboard: [])
    @Published var lineHist: [LineData] = []
    @Published var barHist: [LineData] = []
    @Published var catHist: [LineData] = []

    @Published var username: String = ""
    @Published var rank: Int = 0
    @Published var sharing: Bool = true
    @Published var footprint: Double = 0.0
    
    @Published var successfulAdd: Bool = false
    
    var token_string : String = ""
    
    struct jsonResponse: Decodable {
        // MARK: - Properties
        let access_token, token_type: String
    }
    
    //Authenticate existing users
    func signIn(username: String, password: String) {
        self.canSignIn = false
        self.hasError = false
        
        guard !username.isEmpty && !password.isEmpty else {
            return
        }
        
        let url = URL(string: "https://carbon-crushers.glitch.me/auth")!
        
        let finalBody = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        self.canSignIn = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    self.hasError = true
                    self.canSignIn = false
                    print(response.debugDescription)
                } else if let data = data {
                    do {
                        let jsonResponse = try JSONDecoder().decode(jsonResponse.self, from: data)
                        print(jsonResponse)
                        self.token_string = jsonResponse.access_token
                    }
                    catch {
                        self.canSignIn = false
                        print("Unable to Decode Response \(error)")
                    }
                    
                }
                tok_string = self.token_string
            }
        }.resume()
    }
    
    //Create accounts
    func signUp(username: String, password: String, email: String)  {
        self.canSignIn = false
        self.hasError = false
        guard !email.isEmpty && !password.isEmpty && !username.isEmpty && isValidEmail(email) else {
            return
        }
        
        let url = URL(string: "https://carbon-crushers.glitch.me/signup")!
        
        
        let paramDict: [String: Any] = [
            "username": username,
            "password": password,
            "email": email,
            "sharing" : true
        ]
        
        let finalBody = try! JSONSerialization.data(withJSONObject: paramDict)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.canSignIn = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    self.hasError = true
                    self.canSignIn = false
                } else if let data = data {
                    do {
                        let jsonResponse = try JSONDecoder().decode(jsonResponse.self, from: data)
                        self.token_string = jsonResponse.access_token
                        print(self.token_string)
                    }
                    catch {
                        self.canSignIn = false
                        print("Unable to Decode Response \(error)")
                    }
                }
                tok_string = self.token_string
            }
        }.resume()
    }
    
    //Retrieve leaderboard data
    func getRecords(token: String) {
        guard let url = URL(string: "https:carbon-crushers.glitch.me/leaderboard") else { fatalError("Missing URL") }

        //This object allows us to determine what kind of request we make
        var urlRequest = URLRequest(url: url)
        //This sets the value to look for json content
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //Determine the request type
        urlRequest.httpMethod = "GET"
        
        //Authorization
        //Authorization is required for GET requests
        urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            //If we successfully get a response we can let the data be read in otherwise we stop and return
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        //Decode takes JSON data and tries to give us data in the form of a struct we specify
                        let decodedRecords = try JSONDecoder().decode(Records.self, from: data)
                        self.records = decodedRecords
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    //Add an activity
    func addActivity(token: String, category: String, activity: String, duration: String) {
        self.successfulAdd = false
        guard !duration.isEmpty && !category.isEmpty && !activity.isEmpty else {
            self.hasError = true
            return
        }
        var true_duration = Int(duration)
        var date = Date()
        let dateFormat = DateFormatter()

        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dt = dateFormat.string(from: date)
        
        var activityDict: [String: Any] = [
        "timestamp": dt,
        "category": category,
        "activity": activity,
        "usage": duration
        ]
        
        let url = URL(string: "https://carbon-crushers.glitch.me/footprint")!

        let finalBody = try! JSONSerialization.data(withJSONObject: activityDict)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
//        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.successfulAdd = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    self.hasError = true
                    self.successfulAdd = false
                    print(response.debugDescription)
                } else if let data = data {
                    do {
                        let activityResponse = try JSONDecoder().decode(activityResponse.self, from: data)
                        print(activityResponse)
                    }
                    catch {
                        self.successfulAdd = false
                        self.hasError = true
                        print("Unable to Decode Response \(error)")
                    }
                }
            }
        }.resume()

    }
    
    //Acquire data from the user
    func getUserData(token: String) {
        let url = URL(string:"https://carbon-crushers.glitch.me/user")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    print(response.debugDescription)
                } else if let data = data {
                    do {
                        let UserPageData = try JSONDecoder().decode(UserPageData.self, from: data)
                        self.username = UserPageData.user
                        self.rank = UserPageData.rank
                        self.sharing = UserPageData.sharing
                        self.footprint = UserPageData.footprint
                        print(UserPageData)
                    }
                    catch {
                        print("Unable to Decode Response \(error)")
                    }
                }
            }
        }.resume()
    }
    
    //Acquire line chart data
    func getLineData(token: String) {
        let url = URL(string:"https://carbon-crushers.glitch.me/account/trend?agg=date")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.httpBody = finalBody
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    print(response.debugDescription)
                } else if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode([LineData].self, from: data)
                        self.lineHist = decodedData
                        print(self.lineHist)
                    }
                    catch {
                        print("Unable to Decode Response \(error)")
                    }
                }
            }
        }.resume()
    }
    
    //Acquire bar graph data
    func getBarData(token: String) {
        let url = URL(string:"https://carbon-crushers.glitch.me/account/trend?agg=activity")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.httpBody = finalBody
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    print(response.debugDescription)
                } else if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode([LineData].self, from: data)
                        self.barHist = decodedData
                        print(self.barHist)
                    }
                    catch {
                        print("Unable to Decode Response \(error)")
                    }
                }
            }
        }.resume()
    }
    
    func getCatData(token: String) {
        let url = URL(string:"https://carbon-crushers.glitch.me/account/trend?agg=category")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    print(response.debugDescription)
                } else if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode([LineData].self, from: data)
                        self.catHist = decodedData
                        print(self.catHist)
                    }
                    catch {
                        print("Unable to Decode Response \(error)")
                    }
                }
            }
        }.resume()
    }
}


func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
