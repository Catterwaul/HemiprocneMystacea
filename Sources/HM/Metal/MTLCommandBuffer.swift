import Metal

public extension MTLCommandBuffer {
  /// Wait until this command buffer is scheduled for execution on the GPU.
  var schedulingCompletion: Void {
    get async {
      await withUnsafeContinuation { continuation in
        addScheduledHandler { _ in continuation.resume() }
      }
    }
  }

  /// Wait until the GPU has finished executing the commands in this buffer.
  var completion: Void {
    get async {
      await withUnsafeContinuation { continuation in
        addCompletedHandler { _ in continuation.resume() }
      }
    }
  }

  /// Commit this buffer and wait for the GPU to finish executing its commands.
  func complete() async {
    await withUnsafeContinuation { continuation in
      addCompletedHandler { _ in continuation.resume() }
      commit()
    }
  }
}
