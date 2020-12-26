As of June 22nd this is included in the SwiftUI 2 beta. [https://developer.apple.com/documentation/swiftui/scrollviewproxy](https://developer.apple.com/documentation/swiftui/scrollviewproxy)

The Apple implementation uses just `.id(_:)` and I had update issues with that where Views with an id sometimes won't update when their ObservedObject changed. Maybe this has been fixed in the new SwiftUI 2 beta.

Also the Apple implementation only supports iOS 14 so I think this repo is still useful for backwards compatibility.

# ScrollViewProxy

Adds `ScrollViewReader` and `ScrollViewProxy` that help you scroll to locations in a ScrollView


To get a ScrollViewProxy you can either use the conveinience init on ScrollView

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

The ScrollViewProxy currently has one variable and two functions you can call

```swift
/// A publisher that publishes changes to the scroll views offset
public var offset: OffsetPublisher

/// Scrolls to an edge or corner
public func scrollTo(_ alignment: Alignment, animated: Bool = true)

/// Scrolls the view with ID to an edge or corner
public func scrollTo(_ id: ID, alignment: Alignment = .top, animated: Bool = true)
```

To use the scroll to ID function you have to add an ID to the view you want to scroll to

```swift
ScrollView { proxy in
    HStack { ... }
        .scrollId("someId")
}
```
*This is the only part that is different from the SwiftUI 2.0 implementation because I don't know how to access Views by ID from the `.id(_:)` function*

## Example

Everything put together in an example

```swift
struct ScrollViewProxyExample: View {
    
    @State var randomInt = Int.random(in: 0..<200)
    @State var proxy: ScrollViewProxy? = nil
    @State var offset: CGPoint = .zero
    
    var body: some View {
        // GeometryReader for safeAreaInsets on Sticky View
        GeometryReader { geometry in 
            VStack {
                ScrollView { proxy in
                    Text("Sticky View")
                        .background(Color.white)
                        .onReceive(proxy.offset) { self.offset = $0 }
                        .offset(x: offset.x, y: offset.y + geometry.safeAreaInsets.top)
                        .zIndex(1)
                    
                    VStack(spacing: 20) {
                        ForEach(0..<200) { index in
                            HStack {
                                Spacer()
                                Text("Item: \(index)").font(.title)
                                Spacer()
                            }.scrollId(index)
                        }
                    }
                    .zIndex(0)
                    .onAppear {
                        self.proxy = proxy
                    }
                }
                HStack {
                    Button(action: {
                        self.proxy?.scrollTo(self.randomInt, alignment: .center)
                        self.randomInt = Int.random(in: 0..<200)
                    }, label: {
                        Text("Go to \(self.randomInt)")
                    })
                    Spacer()
                    Button(action: { self.proxy?.scrollTo(.bottom) }, label: {
                        Text("Bottom")
                    })
                    Spacer()
                    Button(action: { self.proxy?.scrollTo(.center) }, label: {
                        Text("Center")
                    })
                }.padding()
            }
        }
    }
}
```

## Deintegrate

Want to drop iOS 13 support and move to the SwiftUI 2.0 version?

1. Remove the Package
2. Add this extension:

```swift
extension View {
    public func scrollId<ID: Hashable>(_ id: ID) -> some View {
        id(id)
    } 
}
```

(Or replace all .scrollId with .id)
