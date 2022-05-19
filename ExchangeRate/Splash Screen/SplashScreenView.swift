//
//  SplashScreenView.swift
//  ExchangeRate
//
//  Created by Arjun on 19/05/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State var start:Bool = false
    @State var moveLiveRateView:Bool = false
    var body: some View {
        
        GeometryReader { gr in
            
            VStack(alignment: .center) {
                
                NavigationLink(destination: LiveRateView(), isActive: $moveLiveRateView,
                               label: { })
                
                Spacer()
                Text("Exchange Rate")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .scaleEffect(self.start ? 1 : 0.2)
                    .opacity(self.start ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 25, damping: 5, initialVelocity: 10).delay(0.1), value: self.start)
                Spacer()
                
                HStack(alignment: .center) {
                    
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 50))
                        .rotationEffect(Angle.degrees(self.start ? 180 : 0))
                        .opacity(self.start ? 1 : 0)
                        .offset(x:self.start ? ((gr.frame(in: .local).midX) - 60) : 0)
                        .animation(.easeInOut(duration: 1).delay(0.2), value: self.start)
                        .onTapGesture {
                            moveLiveRateView.toggle()
                        }
                    
                }.frame(maxWidth: .infinity, alignment: .center)
                    
            }.onAppear {
                self.start.toggle()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
