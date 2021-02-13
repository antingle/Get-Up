//
//  ContentView.swift
//  Get Up
//
//  Created by Anthony on 2/13/21.
//

import SwiftUI

struct Card: Identifiable {
  let id = UUID()
  let name: String
}

/* A bunch of modifiers for a special view to edit alarms */
struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

extension UIViewController {
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        self.present(toPresent, animated: true, completion: nil)
    }
}

/* Main View */
struct ContentView: View {
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @State private var cards: [Card] = [Card(name: "alarm")]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(cards) { card in
                    AlarmCard()
                        .padding([.top, .leading, .trailing])
                        .transition(.move(edge: .bottom))
                    
                }
//                .onTapGesture {
//                    self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .partialCurl) {
//
//                    }
//                }
            }
            .navigationBarTitle("Get Up")
            .navigationBarItems(trailing: Button("Add", action: { self.cards.append(Card(name: String(cards.count))) }))
            .background(Image("bg") .resizable() .scaledToFill() .ignoresSafeArea())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
