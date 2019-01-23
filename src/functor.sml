signature FUNCTOR = 
  sig
    type 'a t
    
    val identity : 'a t
    val fmap     : ('a -> 'b) -> 'a t -> 'b t
  end

signature FUNCTOREX =
  sig
    structure Functor : FUNCTOR
    val replace : 'a -> 'b Functor.t -> 'a Functor.t
    val flipmap : 'a Functor.t -> ('a -> 'b) -> 'b Functor.t
    val void    : 'a Functor.t -> unit Functor.t 
  end

functor FunctorEx(structure Functor : FUNCTOR) : FUNCTOREX =
  struct
    structure Functor = Functor
    open Functor

    fun replace x   = (fmap o const) x
    fun flipmap f x = flip fmap f x
    fun void x      = replace () x
  end
