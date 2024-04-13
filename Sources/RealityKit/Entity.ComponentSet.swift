import RealityKit

extension Entity.ComponentSet {
  subscript<Component: RealityKit.Component>(_: ComponentMetatypeProvider<Component>) -> Component? {
    get { self[Component.self] }
    set { self[Component.self] = newValue }
  }
}

// TODO: Use macros.
struct ComponentMetatypeProvider<Component> {
  private init() { }
}

extension ComponentMetatypeProvider<PhysicsBodyComponent> {
  static var physicsBody: Self { .init() }
}

extension ComponentMetatypeProvider<ModelComponent> {
  static var model: Self { .init() }
}
