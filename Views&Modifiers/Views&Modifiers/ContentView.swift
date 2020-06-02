//
//  ContentView.swift
//  Views&Modifiers
//
//  Created by Ashutosh Dave on 08/05/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import SwiftUI

struct CapsuleText: View {
	var text: String

	var body: some View {
		Text(text)
			.font(.largeTitle)
			.padding()
			.foregroundColor(.white)
			.background(Color.blue)
			.clipShape(Capsule())
	}

}

struct Title: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle)
			.padding()
			.foregroundColor(.white)
			.background(Color.blue)
			.clipShape(RoundedRectangle(cornerRadius: 10))
	}
}

extension View {
	func titleStyle() -> some View {
		self.modifier(Title())
	}
}

struct Watermark: ViewModifier {
	var text: String
	
	func body(content: Content) -> some View {
		ZStack(alignment: .bottomTrailing) {
			content
			
			Text(text)
				.font(.caption)
				.foregroundColor(.white)
				.padding(5)
				.background(Color.black)
		}
	}
}

extension View {
	func watermarked(with text: String) -> some View {
		self.modifier(Watermark(text: text))
	}
}

struct GridStack<Content: View>: View {
	let rows: Int
	let columns: Int
	let content: (Int, Int) -> Content
	
	var body: some View {
		VStack {
			ForEach(0 ..< rows) { row in
				HStack {
					ForEach(0 ..< self.columns) { column in
						self.content(row, column)
						
					}
				}
			}
		}
	}
	
	init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
		self.rows = rows
		self.columns = columns
		self.content = content
	}
}

struct ContentView: View {
    var body: some View {
		GridStack(rows: 4, columns: 4) { row, col in
			Image(systemName: "\(row * 4 + col).circle")
			Text("R\(row) C\(col)")
		}
//		VStack(spacing: 10) {
//			CapsuleText(text: "First")
//			CapsuleText(text: "Second")
//			Color.blue
//				.frame(width: 300, height: 300)
//				.watermarked(with: "Made by Ashu")
//		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
