import Algorithms

@inlinable public func product<Base1: Collection, Base2: Collection, Base3: Collection>(
  _ s1: Base1, _ s2: Base2, _ s3: Base3
) -> some Collection<(Base1.Element, Base2.Element, Base3.Element)> {
  product(s1, product(s2, s3)).lazy.map { ($0, $1.0, $1.1) }
}

@inlinable public func product<
  Base1: Collection, Base2: Collection, Base3: Collection, Base4: Collection
>(
  _ s1: Base1, _ s2: Base2, _ s3: Base3, _ s4: Base4
) -> some Collection<(Base1.Element, Base2.Element, Base3.Element, Base4.Element)> {
  product(s1, product(s2, s3, s4)).lazy.map { ($0, $1.0, $1.1, $1.2) }
}
