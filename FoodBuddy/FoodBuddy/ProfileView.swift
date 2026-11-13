//
//  profileView.swift
//  FoodBuddy
//
//  Created by Chloe Mccarrick on 11/13/26.
//

import SwiftUI

struct ProfileView: View {
    let brandRed = Color(red: 200/255, green: 6/255, blue: 46/255)
    let interests = ["running", "swimming", "basketball", "hiking", "photography"]
    var body: some View {
        VStack{
            ZStack{
                Text("Profile")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity)
                HStack{
                    
                    Button {
                        print("tapped")
                    } label:{
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.black)
                            .font(.title3)
                            .padding()
                    }
                    Spacer()
                    
                    
                }
            }
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1).ignoresSafeArea(edges: .top))
            ScrollView{
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    ZStack{
                        Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        Circle().fill(brandRed.opacity(0.15)).frame(width:100, height:100)
                        
                        Text("A")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(brandRed)
                        
                    }
                    .frame(width:110, height: 110)
                    Text("Alyssa")
                        .font(.title2)
                        .bold()
                    
                    Text("Dining with buddies since September 2026")
                        .foregroundStyle(.secondary)
                }
            }
        }
        }
}

#Preview {
    ProfileView()
}
