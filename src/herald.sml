(* Base *)
fun id (x : 'a) 
  : 'a 
  = x

fun flip (f : ('a -> 'b -> 'c)) 
  : ('b -> 'a -> 'c)
  = fn x => fn y => f y x

fun const (x : 'a) 
  : ('b -> 'a)
  = fn (y) => x
