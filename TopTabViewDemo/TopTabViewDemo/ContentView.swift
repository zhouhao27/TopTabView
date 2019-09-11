//
//  ContentView.swift
//  TopTabViewDemo
//
//  Created by Hao Zhou on 11/9/19.
//  Copyright © 2019 Hao Zhou. All rights reserved.
//

import SwiftUI
import TopTabView

struct ContentView: View {
  @State var selectedSegment = 0
  
  var body: some View {
    return TopTabView(items: [
      TopTabView.Item(title: "Arrow up", icon: Image(systemName:"square.and.arrow.up")),
      TopTabView.Item(title: "Folder", icon: Image(systemName:"folder.badge.plus")),
      TopTabView.Item(title: "Trash", icon: Image(systemName:"trash"))
      ], selection: $selectedSegment, onSelected:  {
        index in
        self.selectedSegment = index
    }) {
      if self.selectedSegment == 0 {
        VStack {
          Text("Tab 1")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.yellow)
        .transition(.move(edge: .leading))
        .animation(.linear(duration: 0.3))
      } else if self.selectedSegment == 1 {
        VStack {
          Text("Tab 2")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.orange)
        .transition(.move(edge: .leading))
        .animation(.linear(duration: 0.3))
      } else {
        VStack {
          Text("Tab 3")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.blue)
        .transition(.move(edge: .leading))
        .animation(.linear(duration: 0.3))
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
