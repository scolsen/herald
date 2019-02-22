(* a list functor *) 

structure ListFunctor : FUNCTOR =
  struct
    type 'a f = 'a list

    val fmap = map
  end

structure ListEx = FunctorEx (ListFunctor)

val l = [1, 2, 3]

val _ = print (hd (ListEx.replace l "hello"))
