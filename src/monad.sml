(* Monads *)

signature MONAD = 
  sig
    structure Applicative : APPLICATIVE 
    type 'a m = 'a Applicative.f

    val return : 'a -> 'a m
    val bind   : 'a m -> ('a -> 'b m) -> 'b m
  end 

  signature MONADEX =
    sig
      structure Monad : MONAD
      type 'a m = 'a Monad.m

      val bind2    : ('a -> 'b m) -> 'a m -> 'b m
      val ignore   : 'a m -> 'b m -> 'b m 
      val fail     : string -> 'a m
      val when     : bool -> unit m -> unit m
      val sequence : ('a m) list -> ('a list) m
      val mapm     : ('a -> 'b m) -> 'a list -> ('b list) m
      
      val liftm    : ('a -> 'b) -> 'a m -> 'b m
      val liftm'   : ('a -> 'b -> 'c) -> 'a m -> 'b m -> 'c m
      val liftm''  : ('a -> 'b -> 'c -> 'd) -> 'a m -> 'b m -> 'c m -> 'd m
    end 
