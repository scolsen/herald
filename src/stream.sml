infix :>

signature STREAM =
  sig
    type 'a stream

    val head : 'a stream -> 'a 
    val tail : 'a stream -> 'a stream
    val repeat : 'a -> 'a stream
    val map : ('a -> 'b) -> 'a stream -> 'b stream
    val zip : ('a -> 'b -> 'c) 'a stream -> 'b stream -> 'c stream
    val iterate : ('a -> 'a) -> 'a -> 'a stream
    val scanr : ('a -> 'b -> 'b) -> 'b -> 'a stream -> 'b stream 
    val scanl : ('b -> 'a -> 'b) -> 'b -> 'a stream -> 'b stream
  end

structure StreamF : FUNCTOR =
  struct
    datatype 'a f = :> of 'a * 'a f

    fun fmap f (x:>xs) = f x :> map f xs
  end

structure StreamA : APPLICATIVE =
  struct
    structure Functor = StreamF
    open StreamF
    
    fun pure x = x :> pure x
    fun apply (f:>fs) s = 
      let
        fun join (x:>xs) (y:>ys) = x :> y :> join xs ys 
      in
      join (fmap f s) (apply fs s)
  end

structure Stream : STREAM =
  struct
    open StreamF StreamA
    type 'a stream = 'a f

    val map = fmap
    val repeat = pure
    
    fun head (x:>xs) = x
    fun tail (x:>xs) = xs
    fun repeat x = x :> repeat x
    fun zip f s s' = f (head s) (head s') :> zip f (tail s) (tail s')
    fun iterate f x = f x :> iterate f (f x)
    fun scanr
    fun scanl
  end
