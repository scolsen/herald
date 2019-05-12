open Herald

val _ = print (id $ Int.toString 2)
val _ = print (id o const $ Int.toString 4 $ "foo")
