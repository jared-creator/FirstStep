//
//  BubbleBackgroundView.swift
//  FirstStep
//
//  Created by JaredMurray on 4/18/24.
//

import SwiftUI

struct BubbleBackgroundView: View {
    let color1: UIColor = UIColor(red: 255/255, green: 75/255, blue: 145/255, alpha: 1)
    let color2: UIColor = UIColor(red: 255/255, green: 118/255, blue: 118/255, alpha: 1)
    let color3: UIColor = UIColor(red: 255/255, green: 205/255, blue: 75/255, alpha: 1)
    let blueColor: UIColor = UIColor(red: 8/255, green: 2/255, blue: 163/255, alpha: 1)
    @State var size: CGFloat = 1000
    @State var size2: CGFloat = 2000
    var repeatingAnimation: Animation {
        Animation
            .easeInOut(duration: 5)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Circle()
            .fill(Color(color1))
            .frame(width: 25, height: 25)
            .offset(x: 150, y: size - 500)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size = -1000
                }
            }
        Circle()
            .fill(Color(color2))
            .frame(width: 25, height: 25)
            .offset(x: 50, y: size - 250)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size = -1000
                }
            }
        Circle()
            .fill(Color(color3))
            .frame(width: 25, height: 25)
            .offset(x: -20, y: size - 100)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size = -1000
                }
            }
        Circle()
            .fill(Color(color2))
            .frame(width: 25, height: 25)
            .offset(x: -130, y: size)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size = -1000
                }
            }
        Circle()
            .fill(Color(color1))
            .frame(width: 25, height: 25)
            .offset(x: 15, y: size - 500)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size = -1000
                }
            }
        Circle()
            .fill(Color(color3))
            .frame(width: 25, height: 25)
            .offset(x: -20, y: size - 100)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size = -1000
                }
            }
        
        Circle()
            .fill(Color(color1))
            .frame(width: 25, height: 25)
            .offset(x: -150, y: size2 - 500)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size2 = -1000
                }
            }
        Circle()
            .fill(Color(color2))
            .frame(width: 25, height: 25)
            .offset(x: -50, y: size2 - 250)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size2 = -1000
                }
            }
        Circle()
            .fill(Color(color3))
            .frame(width: 25, height: 25)
            .offset(x: 20, y: size2 - 100)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size2 = -1000
                }
            }
        Circle()
            .fill(Color(color2))
            .frame(width: 25, height: 25)
            .offset(x: 130, y: size2)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size2 = -1000
                }
            }
        Circle()
            .fill(Color(color1))
            .frame(width: 25, height: 25)
            .offset(x: -15, y: size2 - 500)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size2 = -1000
                }
            }
        Circle()
            .fill(Color(color3))
            .frame(width: 25, height: 25)
            .offset(x: 20, y: size2 - 100)
            .onAppear() {
                withAnimation(self.repeatingAnimation) {
                    self.size2 = -1000
                }
            }
    }
    
    func createCircle() -> some View {
        Rectangle()
            .frame(width: 50, height: 50)
    }
}

#Preview {
    BubbleBackgroundView()
}
