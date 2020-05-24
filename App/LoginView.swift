//
//  LoginView.swift
//  App
//
//  Created by Кристина Перегудова on 02.04.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var success = false
    
    @State var email = ""
    @State var password = ""
    @State var isHiding = true
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "envelope")
                        .padding()
                    TextField("Enter Email Address", text: $email)
                }.padding(.top)
                
                Divider().padding()
                
                HStack {
                    Image(systemName: "lock")
                        .padding()
                    if self.isHiding {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    
                    Button(action: {
                        self.isHiding.toggle()
                    }) {
                        if self.isHiding {
                            Image(systemName: "eye")
                                .renderingMode(.original)
                        } else {
                            Image(systemName: "eye.slash")
                                .renderingMode(.original)
                        }
                        
                    }.padding()
                }.padding(.bottom, 50)
                
            }.background(Color.white)
            .cornerRadius(15)
            .padding()
            
            Button(action: {
                Auth.auth().signIn(withEmail: self.email, password: self.password) { (res, error) in
                    
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    print("Success")
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    self.success.toggle()
                    
                }
            }) {
                Text("LOGIN")
                    .padding()
                    .font(.body)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width / 3 * 2)
                
            }.background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(15)
                .offset(y: -40)
                .shadow(radius: 20)
            
            Button(action: {
                
            }, label: {
                Text("Forget Password?")
                    .foregroundColor(.white)
                    .padding()
                .offset(y: -30)
            })
                
            
        }
        .sheet(isPresented: self.$success) {
            HomeView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().previewLayout(.sizeThatFits)
    }
}
