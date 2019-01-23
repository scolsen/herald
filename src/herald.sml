val id : 'a -> 'a = 
  fn x => x

val flip : ('a -> 'b -> 'c) -> ('b -> 'a -> 'c) =
  fn f (x, y) => f (y, x)
