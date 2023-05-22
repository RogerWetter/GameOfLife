//
//  ContentView.swift
//  Conway’s Game of Life
//
//  Created by roger wetter on 14.04.23.
//

import SwiftUI

let 🫷🏼 = 10
let 🤏🏼 = 10


func createRandomField() -> [[Int]] {
    var field = [[Int]](repeating: [Int](repeating: 0, count: 🫷🏼), count: 🤏🏼)
    for 👉🏼 in 0..<10 {
        for 👆🏼 in 0..<10 {
            field[👉🏼][👆🏼] = Int(arc4random() % 2)
        }
    }
    return field
}

func createNewField(oldField: [[Int]]) -> [[Int]] {
    var field = [[Int]](repeating: [Int](repeating: 0, count: 🫷🏼), count: 🤏🏼)
    for 👉🏼 in 0..<10 {
        for 👆🏼 in 0..<10 {
            let 👀 = get👀(oldField: oldField, 👉🏼: 👉🏼, 👆🏼: 👆🏼)
            if (oldField[👉🏼][👆🏼] == 0) {
                if (👀 == 3) {field[👉🏼][👆🏼] = 1}
            } else {
                switch 👀 {
                case 2, 3:
                    field[👉🏼][👆🏼] = 1
                default:
                    break
                }
            }
        }
    }
    return field
}

func get👀(oldField: [[Int]], 👉🏼: Int, 👆🏼: Int) -> Int {
    var 👀 = 0
    for i in 👉🏼 - 1...👉🏼+1 {
        for j in 👆🏼 - 1...👆🏼+1 {
            if (i >= 0 && j >= 0 && i < 🤏🏼 && j < 🫷🏼 && !(i==👉🏼 && j==👆🏼)) {
                if (oldField[i][j] == 1) {👀 = 👀+1}
            }
        }
    }
    return 👀
}

struct ContentView: View {
    
    @State var oldField = [[Int]](repeating: [Int](repeating: 0, count: 🫷🏼), count: 🤏🏼)
    @State var newField = [[Int]](repeating: [Int](repeating: 0, count: 🫷🏼), count: 🤏🏼)
    
    var body: some View {
        VStack(spacing: 14.0) {
            Text("Conway’s Game of Life").font(Font.headline)
            Text("Old").font(Font.subheadline)
            FieldView(field: oldField)
            Text("New").font(Font.subheadline)
            FieldView(field: newField)
            HStack() {
                Button("random") {
                    oldField = createRandomField()
                    newField = createNewField(oldField: oldField)
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                Button("next") {
                    oldField = newField
                    newField = createNewField(oldField: oldField)
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            }.padding()
        }
        .padding()
    }
}

struct FieldView: View {
    var field: [[Int]]
    var body: some View {
        Grid {
            ForEach(0..<10) {
                👉🏼 in
                GridRow {
                    ForEach(0..<10) {
                        👆🏼 in
                        IconView(alive: field[👉🏼][👆🏼])
                    }
                }
            }
        }
    }
}

struct IconView: View {
    let alive: Int
    var body: some View {
        if (alive == 1) {
            Image(systemName: "heart.fill").frame(width: 20, height: 20)
        } else {
            Image(systemName: "cross").frame(width: 20, height: 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
