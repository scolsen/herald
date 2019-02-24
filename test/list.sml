(* a list functor *) 

open List

structure ListFunctor : FUNCTOR =
  struct
    type 'a f = 'a list

    val fmap = map
  end

structure ListEx = FunctorEx (ListFunctor)

val l = [1, 2, 3]

val _ = print (hd (ListEx.replace l "hello"))

structure ListAPP : APPLICATIVE =
  struct
    structure Functor = ListFunctor
    open ListFunctor
    type 'a f = 'a list  

    fun pure (x:'a)
      : 'a list 
      = [x]
    
    fun apply (fs:('a -> 'b) list) (xs:'a list) 
      : 'b list
      = concat (fmap (fn f => fmap f xs) fs)
  end

val gs = [(fn x => x + 1), (fn y => y * 2)]

val _ = print (String.concatWith ", " (map Int.toString (ListAPP.apply gs l)))

structure ListMon : MONAD = 
  struct
    structure Applicative = ListAPP
    type 'a m = 'a list 

    fun bind (m:'a m) (f: 'a -> 'b m) 
      : 'b m
      = foldr (concat o f) [] m
  end
