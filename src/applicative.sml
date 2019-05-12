open Herald
signature APPLICATIVE =
  sig
    structure Functor : FUNCTOR 
    type 'a f = 'a Functor.f 

    val pure  : 'a -> 'a f
    val apply : ('a -> 'b) f -> 'a f -> 'b f
  end

signature APPLICATIVEEX = 
  sig
    structure Applicative : APPLICATIVE
    type 'a f = 'a Applicative.f

    val apply2   : 'a f -> ('a -> 'b) f -> 'b f
    val discardF : 'a f -> 'b f -> 'b f
    val discardS : 'a f -> 'b f -> 'a f
    
    val lift     : ('a -> 'b) -> 'a f -> 'b f
    val lift'    : ('a -> 'b -> 'c) -> 'a f -> 'b f -> 'c f
  end

functor ApplicativeEx (Applicative : APPLICATIVE) : APPLICATIVEEX =
  struct
    structure Applicative = Applicative
    structure FunctorEx = FunctorEx (Applicative.Functor)
    open FunctorEx
    open Applicative

    fun lift (f:('a -> 'b)) (x:'a f)
      : 'b f
      = apply (pure f) x 
    
    fun lift' (f:('a -> 'b -> 'c)) (x:'a f) (y:'b f) 
      : 'c f
      = apply (fmap f x) y
    
    fun apply2 (x:'a f) (f:('a -> 'b) f) 
      : 'b f
      = apply f x
    
    fun discardF (x:'a f) (y:'b f) 
      : 'b f
      = y (* TBD *)
    
    fun discardS (x:'a f) (y: 'b f) 
      : 'a f
      = (lift' const) x y
  end
