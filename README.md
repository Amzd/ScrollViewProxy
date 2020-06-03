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

The ScrollViewProxy currently has two functions you can call

```swift
/// Scrolls to an edge or corner
public func scrollTo(_ alignment: Alignment, animated: Bool = true)

/// Scrolls the view with ID to an edge or corner
public func scrollTo(_ id: ID, alignment: Alignment = .top, animated: Bool = true)
```

To use the scroll to ID function you have to add a view with that ID to the ScrollViewProxy

```swift
ScrollView { proxy in
    HStack { ... }
        .id("someId", scrollView: proxy)
}
```

## Example

Everything put together in an example

```swift
struct ScrollViewProxySimpleExample: View {
    
    @State var randomInt = Int.random(in: 0..<200)
    @State var proxy: ScrollViewProxy<Int>? = nil
    
    var body: some View {
        VStack {
            ScrollView { proxy in
                ForEach(0..<200) { index in
                    VStack {
                        Text("\(index)").font(.title)
                        Spacer()
                    }
                    .padding()
                    .id(index, scrollView: proxy)
                }.onAppear {
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
