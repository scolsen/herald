(* Monads *)

signature MONAD = 
  sig
    structure Applicative : APPLICATIVE 
    type 'a m = 'a Applicative.f

    val bind   : 'a m -> ('a -> 'b m) -> 'b m
  end 

signature MONADEX =
  sig
    structure Monad : MONAD
    type 'a m = 'a Monad.m

    exception MonadicException of string
    val return   : 'a -> 'a m
    val bind2    : ('a -> 'b m) -> 'a m -> 'b m
    val ignore   : 'a m -> 'b m -> 'b m 
    val fail     : string -> 'a m
    
    val liftm    : ('a -> 'b) -> 'a m -> 'b m
    val liftm'   : ('a -> 'b -> 'c) -> 'a m -> 'b m -> 'c m
    val liftm''  : ('a -> 'b -> 'c -> 'd) -> 'a m -> 'b m -> 'c m -> 'd m
  end 

functor MonadEx (Monad : MONAD) : MONADEX =
  struct
    structure Monad = Monad
    open Monad
    open Monad.Applicative

    exception MonadicException of string
    
    fun return (x:'a)
      : 'a m
      = pure x
     
    fun bind2 (f:('a -> 'b m)) (m:'a m) 
      : 'b m
      = bind m f

    fun ignore (m:'a m) (m':'b m) 
      : 'b m
      = bind m (fn _ => m')

    fun fail (s:string) 
      : 'a m
      = raise MonadicException s

    fun liftm (f:('a -> 'b)) (m:'a m)
      : 'b m
      = bind m (fn x => return (f x))

    fun liftm' (f:('a -> 'b -> 'c)) (m:'a m) (m':'b m)
      : 'c m
      = bind m (fn x => 
          bind m' (fn x' => return (f x x')))

    fun liftm'' (f:('a -> 'b -> 'c -> 'd)) (m:'a m) (m':'b m) (m'':'c m)
      : 'd m
      = bind m (fn x => 
          bind m' (fn x' => 
            bind m'' (fn x'' => return (f x x' x''))))
  end
