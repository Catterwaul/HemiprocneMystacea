import AsyncAlgorithms
import HeapModule

public extension AsyncSequence {
  @available(iOS 18, macOS 15, tvOS 18, visionOS 2, watchOS 11, *)
  @inlinable func forEach(_ body: (Element) async throws(Failure) -> Void) async throws(Failure) {
    for try await element in self {
      try await body(element)
    }
  }
}

@inlinable public func withTaskGroup<ChildTaskResult: Sendable, GroupResult, Error>(
  of childTaskResultType: ChildTaskResult.Type = ChildTaskResult.self,
  returning returnType: GroupResult.Type = GroupResult.self,
  body: (inout ThrowingTaskGroup<ChildTaskResult, any Swift.Error>) async throws(Error) -> GroupResult
) async throws(Error) -> GroupResult {
  do {
    return try await withThrowingTaskGroup(
      of: childTaskResultType,
      returning: returnType,
      body: body
    )
  } catch {
    throw error as! Error
  }
}

@available(iOS 18, macOS 15, tvOS 18, visionOS 2, watchOS 11, *)
public extension Sequence where Element: Sendable {
  /// Transform a sequence asynchronously, and potentially in parallel.
  /// - Returns: An `AsyncSequence` which returns transformed elements, in their original order,
  /// as soon as they become available.
  func mapWithTaskGroup<Transformed>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async -> Transformed
  ) -> some AsyncSequence<Transformed, Never> {
    let channel = AsyncChannel<Transformed>()
    Task { await mapWithTaskGroup(channel: channel, transform) }
    return channel
  }

  /// Transform a sequence asynchronously, and potentially in parallel.
  /// - Returns: An `AsyncSequence` which returns transformed elements, in their original order,
  /// as soon as they become available.
  func mapWithThrowingTaskGroup<Transformed: Sendable, Error: Swift.Error>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws(Error) -> Transformed
  ) -> some AsyncSequence<Transformed, any Swift.Error> {
    let channel = AsyncThrowingChannel<Transformed, any Swift.Error>()
    Task {
      do {
        try await mapWithTaskGroup(channel: channel, transform)
      } catch {
        channel.fail(error)
      }
    }
    return channel
  }

  func compactMapWithTaskGroup<Transformed: Sendable>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async -> Transformed?
  ) async -> [Transformed] {
    await .init(mapWithTaskGroup(transform).compacted())
  }

  func compactMapWithTaskGroup<Transformed: Sendable, Error: Swift.Error>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws(Error) -> Transformed?
  ) async throws(any Swift.Error) -> [Transformed] {
    try await .init(mapWithThrowingTaskGroup(transform).compacted())
  }
}

// MARK: - private
private protocol AsyncChannelProtocol<Element, Failure> {
  associatedtype Element
  associatedtype Failure: Error
  func send(_: Element) async
  func finish()
}

extension AsyncChannel: AsyncChannelProtocol { }
extension AsyncThrowingChannel: AsyncChannelProtocol { }

private extension Sequence where Element: Sendable {
  private func mapWithTaskGroup<Transformed: Sendable, Error>(
    channel: some AsyncChannelProtocol<Transformed, Error>,
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws(Error) -> Transformed
  ) async throws(Error) {
    typealias ChildTaskResult = Heap<Int>.ElementValuePair<Transformed>
    try await withTaskGroup { group throws(Error) in
      for (offset, element) in enumerated() {
        group.addTask(priority: priority) {
          ChildTaskResult(offset, try await transform(element))
        }
      }

      var heap = Heap<ChildTaskResult>()
      var lastSentOffset = -1
      try await forceCastError(Error.self) {
        for try await childTaskResult in group {
          heap.insert(childTaskResult)
          // Send as many in-order `Transformed`s as possible.
          while heap.min?.delegate == lastSentOffset + 1 {
            await channel.send(heap.removeMin().value)
            lastSentOffset += 1
          }
        }
      }

      channel.finish()
    }
  }
}
