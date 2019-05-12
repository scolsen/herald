(* Base *)

infix 0 $
infix 0 &

signature HERALD =
  sig 
    type ('a, 'b) product 
    type ('a, 'b) either 
    val $ : ('a -> 'b) * 'a -> 'b
    val id : 'a -> 'a
    val flip : ('a -> 'b -> 'c) -> ('b -> 'a -> 'c)
    val const : 'a -> ('b -> 'a)
    val until : ('a -> bool) -> ('a -> 'a) -> 'a -> 'a
    val first : ('a * 'b) -> 'a
    val second : ('a * 'b) -> 'b
  end

structure Herald : HERALD =
  struct
    datatype ('a, 'b) product = & of 'a * 'b
    datatype ('a, 'b) either = Left of 'a | Right of 'b

    fun f $ x = f x
    fun id x = x
    fun flip f = fn x => fn y => f y x
    fun const x = fn y => x 
    fun until p f x = if p x then x else until p f (f x)
    fun first (x, _) = x
    fun second (_, y) = y
  end
