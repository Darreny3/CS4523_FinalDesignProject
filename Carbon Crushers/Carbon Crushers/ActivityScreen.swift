//
//  ActivityScreen.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 11/15/22.
//

import SwiftUI

var activity: String = ""

struct PowerActivities: View {
    
    var body: some View {
        Menu {
            Button {
                activity = "Light"
            } label: {
                Text("Light")
                Image(systemName: "bolt.shield")
            }
            Button {
                activity = "Heat"
            } label: {
                Text("Heat")
                Image(systemName: "thermometer")
            }
        } label: {
             Text("Power Type")
             Image(systemName: "lightbulb")
        }
    }
}

struct TravelActivities: View {
    var body: some View {
        Menu {
            Button {
                activity = "Car"
            } label: {
                Text("Car")
                Image(systemName: "car")
            }
            Button {
                activity = "Plane"
            } label: {
                Text("Plane")
                Image(systemName: "airplane.departure")
            }
            Button {
                activity = "Bus"
            } label: {
                Text("Bus")
                Image(systemName: "bus")
            }
            Button {
                activity = "Boat"
            } label: {
                Text("Boat")
                Image(systemName: "ferry")
            }
            Button {
                activity = "Walk"
            } label: {
                Text("Bicycle/Walk")
                Image(systemName: "bicycle")
            }
        } label: {
             Text("Travel Type")
             Image(systemName: "figure.walk")
        }
    }
}

struct ActivityScreen: View {
    @State var isTravel: Bool = false
    @State var duration = ""
    @EnvironmentObject var viewModel: SignInViewModel
    @State var successAdd: Bool = false
    var body: some View {
        ZStack{
            VStack{
                Menu {
                    Button {
                        isTravel = true
                    } label: {
                        Text("Travel")
                        Image(systemName: "airplane")
                    }
                    Button {
                        isTravel = false
                    } label: {
                        Text("Power")
                        Image(systemName: "bolt")
                    }
                } label: {
                     Text("Activity Type")
                     Image(systemName: "tram.circle")
                }
                if isTravel {
                  TravelActivities()
                }
                else {
                 PowerActivities()
                }

                if (isTravel) {
                    TextField("Number of Miles Traveled", text: $duration)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .foregroundColor(.black)
                }
                else {
                    TextField("Duration of Activity", text: $duration)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .foregroundColor(.black)
                }
                
                Button (action: {
                    var category: String = self.isTravel ? "Travel" : "Power"
                    self.viewModel.addActivity(token: tok_string, category: category, activity: activity, duration: self.duration)
                    self.successAdd = self.viewModel.successfulAdd
                }) {
                    SubmitButton()
                }
                if (self.successAdd) {
                    Text("Success! Click back to return or continue adding activities")
                        .foregroundColor(Color.green)
                }
            }
            .alert(isPresented: $viewModel.hasError) {
                        Alert(
                            title: Text("Activity Creation Failed"),
                            message: Text("Input Invalid."),
                            dismissButton: .default(Text("OK"), action: {
                            })
                        )
                    }
        }
        
    }
}



struct ActivityScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActivityScreen().environmentObject(viewModel)
    }
}

struct SubmitButton: View {
    var body: some View {
        Text("SUBMIT")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}
