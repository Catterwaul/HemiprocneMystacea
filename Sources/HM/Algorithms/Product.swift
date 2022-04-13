import Algorithms

public typealias Product3Collection<
  Base1: Collection, Base2: Collection, Base3: Collection
> = LazyMapCollection<
  Product2Sequence<Base1, Product2Sequence<Base2, Base3>>,
  (Base1.Element, Base2.Element, Base3.Element)
>

@inlinable
public func product<Base1, Base2, Base3>(
  _ s1: Base1, _ s2: Base2, _ s3: Base3
) -> Product3Collection<Base1, Base2, Base3> {
  product(s1, product(s2, s3)).lazy.map { ($0, $1.0, $1.1) }
}

public typealias Product4Collection<
  Base1: Collection, Base2: Collection, Base3: Collection, Base4: Collection
> = LazyMapCollection<
  Product2Sequence<Base1, Product3Collection<Base2, Base3, Base4>>,
  (Base1.Element, Base2.Element, Base3.Element, Base4.Element)
>

@inlinable
public func product<Base1, Base2, Base3, Base4>(
  _ s1: Base1, _ s2: Base2, _ s3: Base3, _ s4: Base4
) -> Product4Collection<Base1, Base2, Base3, Base4> {
  product(s1, product(s2, s3, s4)).lazy.map { ($0, $1.0, $1.1, $1.2) }
}
