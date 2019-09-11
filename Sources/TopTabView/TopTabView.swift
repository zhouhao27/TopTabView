//
//  TopTabView.swift
//  TopTabViewDemo
//
//  Created by Hao Zhou on 9/9/19.
//  Copyright © 2019 Hao Zhou. All rights reserved.
//

import SwiftUI
import Combine

@available(iOS 13, *)
struct Tab: View {
  
  var index: Int
  var title: String
  var icon: Image?
  var width: CGFloat = 100
  @Binding var isSelected: Bool
  var action: (_ index:Int) -> Void
    
  var body: some View {
    
    return VStack {
      Button(action: {
        self.action(self.index)
      }) {
        HStack {
          icon
          Text("\(title)")
        }
        if isSelected {
          Rectangle().fill(Color.orange).frame(width: self.width, height: 5)
        } else {
          Rectangle().fill(Color.white).frame(width: self.width, height: 5)
        }
      }
    }
  }
}

@available(iOS 13, *)
public struct TopTabView<Content>: View where Content: View {
  public struct Item {
    var title: String
    var icon: Image?
    
    public init(title: String, icon: Image?) {
      self.title = title
      self.icon = icon
    }
  }

  private var items: [Item]
  @Binding var selection: Int
  private var onSelected: ((Int) -> Void)?
  private var content: Content
  
  private func changeTab(to index: Int) {
    selection = index
  }
  
  public init(items:[Item], selection: Binding<Int> = .constant(0), onSelected:((Int)->Void)? = nil, @ViewBuilder content: @escaping () -> Content) {
    self.items = items
    self._selection = selection
    self.onSelected = onSelected
    self.content = content()
  }
  
  public var body: some View {
    let width = UIScreen.main.bounds.size.width / CGFloat(items.count) - 10
    
    return VStack {
      HStack(alignment: .top, spacing: 0) {
        ForEach(0..<items.count,id:\.self) {
          index in
          Tab(index: index,
              title:self.items[index].title,
              icon: self.items[index].icon,
              width: width,
              isSelected: .constant(self.selection == index)) {
            selectedIndex in
                
                self.changeTab(to: selectedIndex)
                if let call = self.onSelected {
                  call(selectedIndex)
                }
          }
        }
      }
      content
    }
  }
}

@available(iOS 13, *)
struct TopTabView_Previews: PreviewProvider {
  static var previews: some View {
    TopTabView(items: [
      TopTabView.Item(title: "Tab 1", icon: Image(systemName: "square.and.arrow.up")),
      TopTabView.Item(title: "Tab 2", icon: Image(systemName:"folder.badge.plus")),
      TopTabView.Item(title: "Tab 3", icon: Image(systemName:"folder.badge.plus"))
    ]) {
      Text("Hi")
    }
  }
}
