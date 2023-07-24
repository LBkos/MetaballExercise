### Задание

Создать круг с метасвойствами, при перетаскивании получается вытащить один круг из другого.

### Решение

Создадим один круг для дальнейшего использования.

```swift
func ball(offset: CGSize = .zero) -> some View {
        Circle()
            .fill(.white)
            .frame(width: 150, height: 150)
            .offset(offset)
    }

```

Для создания отрисовки кругов и трансформации будем использовать **Canvas**.

```swift

@ViewBuilder
    func singleMetaBall() -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.5, color: .white))
            context.addFilter(.blur(radius: 40))
            
            context.drawLayer { ctx in
                for index in [1,2] {
                    if let resolved = context.resolveSymbol(id: index) {
                        ctx.draw(resolved, at: CGPoint(x: size.width / 2, y: size.height / 2))
                    }
                }
            }
        } symbols: {
            ball()
                .tag(1)
            ball(offset: dragOffset)
                .tag(2)
        }
    }

```
Для отслеживания изменений инициализируем State переменную

```swift
@State var dragOffset: CGSize = .zero
```

Для трансформации добавим жесты

```swift
.gesture(
            DragGesture()
                .onChanged({ val in
                    dragOffset = val.translation
                })
                .onEnded({ _ in
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        dragOffset = .zero
                    }
                })
        )
```

вставим все это в view и зададим черный фон

```swift

var body: some View {
        VStack {
            singleMetaBall()
                .preferredColorScheme(.dark)
        }
    }
```