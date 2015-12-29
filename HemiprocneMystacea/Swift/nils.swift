func nils<
   Arguments1, Return1,
   Arguments2, Return2
>() -> (
   Arguments1 -> Return1?,
   Arguments2 -> Return2?
) {
   return ({_ in nil}, {_ in nil})
}

func nils<
   Arguments1, Return1,
   Arguments2, Return2,
   Arguments3, Return3
>() -> (
   Arguments1 -> Return1?,
   Arguments2 -> Return2?,
   Arguments3 -> Return3?
) {
   return ({_ in nil}, {_ in nil}, {_ in nil})
}

func nils<
   Arguments1, Return1,
   Arguments2, Return2,
   Arguments3, Return3,
   Arguments4, Return4
>() -> (
   Arguments1 -> Return1?,
   Arguments2 -> Return2?,
   Arguments3 -> Return3?,
   Arguments4 -> Return4?
) {
   return ({_ in nil}, {_ in nil}, {_ in nil}, {_ in nil})
}