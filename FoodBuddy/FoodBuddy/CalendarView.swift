//
//  CalanderView.swift
//  FoodBuddy
//
//  Created by Chloe Mccarrick on 11/7/26.
//

import SwiftUI

struct CalendarView: View {
    @State private var month = Date()
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let symbols = Calendar.current.veryShortWeekdaySymbols
    var daysInMonth: Int{
        Calendar.current.range(of: .day, in:.month, for: month)?.count ?? 30
    }
    var firstOfMonth: Date{
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: month)) ?? month
    
    }
    var blanks: Int{
        Calendar.current.component(.weekday, from: firstOfMonth)-1
    }


    var body: some View {
            VStack{
            HStack{
                
                Text(month.formatted(.dateTime.month(.wide).year()))
                    .font(.title2)
                    .bold()
                Spacer()
                Button{
                    month = Calendar.current.date(byAdding: .month, value: -1, to:month) ?? month
                }label: {
                    Image(systemName: "chevron.left")
                }
                Button{
                    month = Calendar.current.date(byAdding: .month, value: 1, to: month) ?? month
                }label: {
                    Image(systemName: "chevron.right")
                }
                
                
            }
            .padding()
            
        
        LazyVGrid(columns: columns){
            ForEach(0..<7,id: \.self){i in
                Text(symbols[i])
                
            }
        }
                LazyVGrid(columns: columns){
                    ForEach(0..<blanks+daysInMonth, id: \.self){ i in
                        if i < blanks{
                            Text("")
                        }else{
                            Text("\(i-blanks+1)")
                        }
                        }
                    
                    
                }
        }
        
    
    
    }
}

#Preview {
    CalendarView()
}
