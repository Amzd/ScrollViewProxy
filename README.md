As of June 22nd this is included in the SwiftUI beta. https://developer.apple.com/documentation/swiftui/scrollviewproxy

The Apple implementation uses just `.id(_:)` and I had update issues with that where Views with an id sometimes won't update when their ObservedObject changed. Maybe this has been fixed in the new SwiftUI beta.

Also the Apple implementation only supports iOS 14 so I think this repo is still useful.

# ScrollViewProxy

Adds `ScrollViewReader` and `ScrollViewProxy` that help you scroll to locations in a ScrollView


To get a ScrollViewProxy you can either use the convenience init on ScrollView

```swift
ScrollView { proxy in
    ...
}
```

or add a ScrollViewReader to any View that creates a UIScrollView under the hood

```swift
List {
    ScrollViewReader { proxy in
        ...
    }
}
```

The ScrollViewProxy currently has two functions you can call

```swift
/// Scrolls to an edge or corner
public func scrollTo(_ alignment: Alignment, animated: Bool = true)

/// Scrolls the view with ID to an edge or corner
public func scrollTo(_ id: ID, alignment: Alignment = .top, animated: Bool = true)
```

To use the scroll to ID function you have to add a view with that ID to the view hierarchy

```swift
ScrollView { proxy in
    HStack { ... }
        .scrollId("someId")
}
```

You can also read the scroll offset

```swift
ScrollView { proxy in
    Text("\(self.offset.debugDescription)").onAppear {
        self.proxy = proxy
        DispatchQueue.main.async {
            self.proxy?.onScroll = { offset in 
                self.offset = offset
            }
        }
    }
}
```

## Example

Everything put together in an example

```swift

struct ScrollViewProxySimpleExample: View {
    @State var randomInt = Int.random(in: 0 ..< 200)
    @State var offset = CGPoint()
    @State var proxy: ScrollViewProxy<Int>?

    var numbers: some View {
        ForEach(0 ..< 200) { index in
            VStack {
                Text("\(index)").font(.title)
                Spacer()
            }
            .padding()
            .scrollId(index)
        }
    }

    var body: some View {
        VStack {
            Text(offset.debugDescription)
            ScrollView {
                ScrollViewReader { (proxy: ScrollViewProxy<Int>) in 
                    self.numbers.onAppear {
                        self.proxy = proxy
                        // Avoid undefined behavior by assigning in the next tick
                        DispatchQueue.main.async {
                            self.proxy?.onScroll = { offset in 
                                self.offset = offset
                            }
                        }
                    }
                }
            }
            HStack {
                Button(action: {
                    self.proxy?.scrollTo(self.randomInt, alignment: .center)
                    self.randomInt = Int.random(in: 0 ..< 200)
                }, label: {
                    Text("Go to \(self.randomInt)")
                })
                Spacer()
                Button(action: { self.proxy?.scrollTo(.top) }, label: {
                    Text("Top")
                })
                Spacer()
                Button(action: { self.proxy?.scrollTo(.center) }, label: {
                    Text("Center")
                })
                Spacer()
                Button(action: { self.proxy?.scrollTo(.bottom) }, label: {
                    Text("Bottom")
                })
            }
        }
    }
}
```
