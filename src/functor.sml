signature FUNCTOR = 
  sig
    type 'a f
    
    val fmap : ('a -> 'b) -> 'a f -> 'b f
  end

signature FUNCTOREX =
  sig
    structure Functor : FUNCTOR
    type 'a f = 'a Functor.f

    val fmap2   : 'a f -> ('a -> 'b) -> 'b f
    val replace : 'b f -> 'a -> 'a f
    val void    : 'a f -> unit f
  end

functor FunctorEx(Functor : FUNCTOR) =
  struct
    structure Functor = Functor
    open Functor

    fun fmap2 (x:'a f) (y:('a -> 'b)) 
      : 'b f
      = fmap y x
    
    fun replace (x:'b f) (y:'a) 
      : 'a f
      = fmap (const y) x
    
    fun void (x:'a f) 
      : unit f
      = replace x ()
  end
