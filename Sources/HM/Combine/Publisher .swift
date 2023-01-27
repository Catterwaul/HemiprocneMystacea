import Combine

public extension Sequence where Element: Publisher {
  var merged: Publishers.MergeMany<Element> {
    Publishers.MergeMany(self)
  }
}

public extension Publisher {
  func sink(_ subject: some Subject<Output, Failure>) -> AnyCancellable {
    sink(
      receiveCompletion: subject.send,
      receiveValue: subject.send
    )
  }
}
