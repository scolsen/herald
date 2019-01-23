(* Product *)
infix 0 &
infix 4 o&o 

datatype ('a, 'b) prod = & of 'a * 'b

fun f o&o g = fn x => (f x) & (g x)

(* Either *)
datatype ('a, 'b) coprod = Left of 'a | Right of 'b


