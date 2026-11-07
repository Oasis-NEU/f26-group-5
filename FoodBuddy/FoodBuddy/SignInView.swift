// xcode: set sdk=iOS

//
//  SignInView.swift
//  FoodBuddy
//
//  Created by Chloe Mccarrick on 11/7/26.
//

import SwiftUI

struct SignInView: View {
    @State private var errorMessage = ""
    var body: some View {
        VStack{
            
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
            Spacer()
            if(!errorMessage.isEmpty){
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }
            Button{
                print("tapped")
            } label:{
                Text("Sign in with Google")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Text("Northeastern Students Only")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(red: 246/255, green: 245/255, blue: 241/255).ignoresSafeArea())
    }
}


#Preview {
    SignInView()
}
