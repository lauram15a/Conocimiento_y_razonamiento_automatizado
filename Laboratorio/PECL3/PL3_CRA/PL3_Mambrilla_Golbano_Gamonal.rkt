; Booleanos

(define true (lambda (x y) x))

(define false (lambda (x y) y))

(define neg (lambda (x) (x false true)))
                         
(define and (lambda (x y) (x y false)))

(define or (lambda (x y) (x true y)))

; Pares ordenados
              
(define par (lambda (x)
              (lambda (y)
                (lambda (f) (f x y)))))

(define primero (lambda (p) (p true)))

(define segundo (lambda (p) (p false)))

;;;;; Combinador de punto fijo

(define Y
  (lambda (f)
    ((lambda (x) (f (lambda (v) ((x x) v))))
     (lambda (x) (f (lambda (v) ((x x) v)))))))

;;;;;; Orden en naturales y test de nulidad

(define esmenoroigualnat (lambda (n)
                           (lambda (m)
                             (escero ((restanat n) m)))))
                         
(define esmayoroigualnat (lambda (n)
                           (lambda (m)
                             (escero ((restanat m) n)))))
                         
(define esmenornat (lambda (n)
                     (lambda (m)
                       (and ((esmenoroigualnat n) m) (noescero ((restanat m) n))))))

(define esmayornat (lambda (n)
                     (lambda (m)
                       (and ((esmayoroigualnat n) m) (noescero ((restanat n) m))))))

(define esigualnat (lambda (n)
                     (lambda (m)
                       (and ((esmayoroigualnat n) m) ((esmenoroigualnat n) m)))))

(define escero (lambda (n)
                 ((n (lambda (x) false)) true)))

(define noescero (lambda (n)
                   (neg (escero n))))

; Aritmética natural. Se define también comprobar para verificar que la cosa va bien. Defino algunos naturales para hacer comprobaciones. Los escribo en francés para distinguirlos de los enteros 
; que escribiré en español.

(define zero (lambda (f)
               (lambda (x) x)))

(define sucesor (lambda (n)
                  (lambda (f)
                    (lambda (x)
                      (f((n f) x))))))

(define un (sucesor zero))

(define deux (sucesor un))

(define trois (sucesor deux))

(define quatre (sucesor trois))

(define cinq (sucesor quatre))

(define six (sucesor cinq))

(define sept (sucesor six))

(define huit (sucesor sept))

(define neuf (sucesor huit))

(define dix (sucesor neuf))

(define onze (sucesor dix))

(define douze (sucesor onze))

(define treize (sucesor douze))

(define quatorze (sucesor treize))

(define quinze (sucesor quatorze))

(define seize (sucesor quinze))

(define dix-sept (sucesor seize))

(define dix-huit (sucesor dix-sept))

(define dix-neuf (sucesor dix-huit))

(define vingt (sucesor dix-neuf))

(define comprobar (lambda (n)
                    ((n (lambda (x) (+ 1 x))) 0)))

(define sumnat (lambda (n)
                 (lambda (m)
                   ((n (lambda (x) (sucesor x))) m))))

(define prodnat (lambda (n)
                  (lambda (m)
                    (lambda (f)
                      (lambda (x) ((m (n f)) x))))))
                     
(define prefn (lambda (f)
                (lambda (p)
                  ((par (f (primero p))) (primero p)))))

(define predecesor (lambda (n)
                     (lambda (f)
                       (lambda (x)
                         (segundo ((n ((lambda (g)
                                         (lambda (p) ((prefn g) p))) f)) ((par x) x)))))))
                         
(define restanat (lambda (n)
                   (lambda (m)
                     ((m (lambda (x) (predecesor x))) n))))                                                 

(define restonataux   ; Función que usa el combinador de punto fijo para aplicar recursividad
  (lambda (n)       ; Argumento 1 (dividendo)
    (lambda (m)   ; Argumento 2 (divisor, no cambia en llamadas recursivas)
      ((Y (lambda (f) ; Operador de punto fijo sobre la función f de argumento x
            (lambda (x)
              ((((esmayoroigualnat x) m)   ; Condición de recursividad 
                (lambda (no_use)         ; Envoltorio con argumento formal sin valor real
                  (f ((restanat x) m)) ; Caso general
                  )
                (lambda (no_use)         ; Envoltorio con argumento formal sin valor real
                  x                    ; Caso base
                  )
                )
               zero)    ; Pasa zero como argumento de "no_use"
              )
            ))
       n)  ; Pasa n como el valor inicial de x.
      )
    ))

(define restonat
  (lambda (n)
    (lambda (m)
      ((escero m) false ((restonataux n) m)) ; if (m es cero) then "false" else "operación"
      )
    )
  )

(define cocientenataux
  (lambda (n)
    (lambda (m)
      ((Y (lambda (f)
            (lambda (x)
              ((((esmayoroigualnat x) m)  
                (lambda (no_use)
                  (sucesor (f ((restanat x) m)))  
                  )
                (lambda (no_use)
                  zero
                  )
                )
               zero)    ; Pasa zero como argumento de no_use
              )
            ))
       n)  ; Pasa n como el valor inicial de x.
      )
    )
  )

(define cocientenat
  (lambda (n)
    (lambda (m)
      ((escero m)  false ((cocientenataux n) m))
      )
    )
  )

(define mcdnat
  (lambda (n)
    (lambda (m)
      (((Y (lambda (f)
             (lambda (x)
               (lambda(y)
                 (((escero y)  
                   (lambda (no_use)
                     x
                     ) 
                   (lambda (no_use)
                     ((f y)((restonat x) y)) 
                     )
                        
                   )
                  zero)    ; Pasa zero como argumento de no_use
                 ))
             ))
        n) ; Pasa n como el valor inicial de x.
       m)       ; Pasa m como el valor inicial de y.
      )
    ))

;;;;;; Definición de algunos enteros

(define cero ((par zero) zero))

(define -uno ((par zero) un))

(define -dos ((par zero) deux))

(define -tres ((par zero) trois))

(define -cuatro ((par zero) quatre))

(define -cinco ((par zero) cinq))

(define -seis ((par zero) six))

(define -siete ((par zero) sept))

(define -ocho ((par zero) huit))

(define -nueve ((par zero) neuf))

(define -diez ((par zero) dix))

(define -once ((par zero) onze))

(define -doce ((par zero) douze))

(define -trece ((par zero) treize))

(define -catorce ((par zero) quatorze))

(define -quince ((par zero) quinze))

(define -dieciseis ((par zero) seize))

(define -diecisiete ((par zero) dix-sept))

(define -dieciocho ((par zero) dix-huit))

(define -diecinueve ((par zero) dix-neuf))

(define -veinte ((par zero) vingt))

(define uno ((par un) zero))

(define dos ((par deux) zero))

(define tres ((par trois) zero))

(define cuatro ((par quatre) zero))

(define cinco ((par cinq) zero))

(define seis ((par six) zero))

(define siete ((par sept) zero))

(define ocho ((par huit) zero))

(define nueve ((par neuf) zero))

(define diez ((par dix) zero))

(define once ((par onze) zero))

(define doce ((par douze) zero))

(define trece ((par treize) zero))

(define catorce ((par quatorze) zero))

(define quince ((par quinze) zero))

(define dieciseis ((par seize) zero))

(define diecisiete ((par dix-sept) zero))

(define dieciocho ((par dix-huit) zero))

(define diecinueve ((par dix-neuf) zero))

(define veinte ((par vingt) zero))

;;;;; Orden, valor absoluto y tests de nulidad, positividad y negatividad. 
;;;
;;; m-n > m'-n' si y solo si m+n' > m'+n e igual con el resto

(define esmayoroigualent (lambda (r)
                           (lambda (s)
                             ((esmayoroigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r)))))) 

(define esmenoroigualent (lambda (r)
                           (lambda (s)
                             ((esmenoroigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esmayorent (lambda (r)
                     (lambda (s)
                       ((esmayornat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esmenorent (lambda (r)
                     (lambda (s)
                       ((esmenornat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esigualent (lambda (r)
                     (lambda (s)
                       ((esigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define absoluto (lambda (r)
                   (((esmayoroigualnat (primero r)) (segundo r)) ((par ((restanat (primero r)) (segundo r))) zero) ((par ((restanat (segundo r)) (primero r))) zero))))

(define negativo (lambda (r)
                   ((esmenorent r) cero)))

(define positivo (lambda (r)
                   ((esmayorent r) cero)))

(define esceroent (lambda (r)
                    ((esigualnat (primero r)) (segundo r))))
                      
(define noesceroent (lambda (r)
                      (neg (esceroent r))))

;;;;; Reducción a representante canónico de la clase de equivalencia.

(define reducir (lambda (r)
                  (((esmayoroigualnat (primero r)) (segundo r)) 
                   ((par ((restanat (primero r)) (segundo r))) zero)
                   ((par zero) ((restanat (segundo r)) (primero r))))))

;;;;; Aritmética entera. La respuesta está siempre dada por el representante canónico de la clase de equivalencia. 

(define testenteros (lambda (r)
                      (- (comprobar (primero r)) (comprobar (segundo r)))))

(define sument (lambda (r)
                 (lambda (s)
                   (reducir ((par ((sumnat (primero r)) (primero s))) ((sumnat (segundo r)) (segundo s)))))))

(define prodent (lambda (r)
                  (lambda (s)
                    (reducir ((par ((sumnat ((prodnat (primero r)) (primero s))) ((prodnat (segundo r)) (segundo s))))
                              ((sumnat ((prodnat (primero r)) (segundo s))) ((prodnat (segundo r)) (primero s))))))))                       

(define restaent (lambda (r)
                   (lambda (s)
                     (reducir ((par ((sumnat (primero r)) (segundo s))) ((sumnat (segundo r)) (primero s)))))))

;; Lo siguiente reduce la división de enteros a división de naturales. Si m \ge 0 y n> 0, y si q y r son cociente y resto de la división de m entre n, se tiene
;;  m  = q       * n        + r
;;  m  = (-q)    * (-n)     + r
;; -m  = (-(q+1))* n        + (n-r)
;; -m  = (q+1)   * (-n)     + (n-r),
;; siempre y cuando el resto no sea cero. Cuando el divisor es cero, la función cocienteent devuelve false.

(define cocienteent_aux (lambda (r)
                          (lambda (s)
                            ((cocientenat (primero (absoluto r))) (primero (absoluto s))))))

; Caso1: resto cero. Si m= q*n, entonces -m= (-q)*n, -m = q* (-n) y m= (-q)*(-n).

(define cocienteentaux-caso1 (lambda (r)
                               (lambda (s)
                                 ((or (and ((esmayoroigualent r) cero) (positivo s)) (and (negativo r) (negativo s))) ((par ((cocientenat (primero (absoluto r))) (primero (absoluto s)))) zero)
                                                                                                                      ((par zero) ((cocientenat (primero (absoluto r))) (primero (absoluto s))))))))
                              
; Caso 2: resto no nulo

(define cocienteentaux-caso2 (lambda (r)
                               (lambda (s)
                                 (((esmayoroigualent r) cero) ((positivo s) ((par ((cocienteent_aux r) s)) zero) ((par zero) ((cocienteent_aux r) s)))
                                                              ((positivo s) ((par zero) (sucesor ((cocienteent_aux r) s))) ((par (sucesor ((cocienteent_aux r) s))) zero))))))
; Cociente cuando no hay división por cero

(define cocienteentaux (lambda (r)
                         (lambda (s)
                           ((escero ((restonat (primero (absoluto r))) (primero (absoluto s)))) ((cocienteentaux-caso1 r) s) ((cocienteentaux-caso2 r) s)))))

; Cociente considerando la división por cero

(define cocienteent (lambda (r)
                      (lambda (s)
                        (((esceroent s) (lambda (no_use) false) (lambda (no_use) ((cocienteentaux r) s))) zero))))

; Resto. Si se divide por cero, devuelve false

(define restoentaux1 (lambda (r)
                       (lambda (s)
                         ((or (and ((esmayoroigualent r) cero) (positivo s)) (and ((esmayoroigualent r) cero) (negativo s))) ((par ((restonat (primero (absoluto r))) (primero (absoluto s)))) zero)
                                                                                                                             ((par ((restanat (primero (absoluto s)))((restonat (primero (absoluto r))) (primero (absoluto s))))) zero)))))

(define restoentaux (lambda (r)
                      (lambda (s)
                        ((escero ((restonat (primero (absoluto r))) (primero (absoluto s)))) cero ((restoentaux1 r) s)))))

(define restoent (lambda (r)
                   (lambda (s)
                     (((esceroent s) (lambda (no_use) false) (lambda (no_use) ((restoentaux r) s))) zero))))

;; Como mcd (r,s)=mcd(|r|,|s|), se tiene

(define mcdent (lambda (r)
                 (lambda (s)
                   ((par ((mcdnat (primero (absoluto r))) (primero (absoluto s)))) zero))))





;;;######################################################################################################
;;; PRACTICA 3 CRA
;;; Integrantes:
;;; - Laura Mambrilla Moreno
;;; - Alvaro Golbano Duran
;;; - Victor Gamonal Sanchez
;;;######################################################################################################



;;;------------------------------------------------------------------
;;;                          OPERACIONES
;;;------------------------------------------------------------------

;Definición del cosntructor de una lista según apuntes (pág. 60):
;(lo que quiero construir, donde lo quiero construir)
(define construir (lambda (x)
                    (lambda (y)
                      ((par false) ((par x) y)))))


;Permite visualizar listas por pantalla:
(define comprobar-lista (lambda (l)
                          (if (= (comprobar (longitud l)) 0)
                              '()
                              (cons (testenteros (cabeza l)) (comprobar-lista (cola l))))))


;Definición de lista vacia según apuntes (pág. 60) -> DEFINICION de lista vacia
(define vacia (lambda (x) x))                                   ;Jx.x


; "NULL" (comprobacion de si no quedan elementos)
(define vacia? primero)


;Definición de la cabeza de la lista según apuntes (pág. 60):
(define cabeza (lambda (x) (primero (segundo x))))              ;Jx.primero(segundo x)


;Definición de la cola de la lista según apuntes (pág. 60):
(define cola (lambda (x) (segundo (segundo x))))                ;Jx.segundo(segundo x)


;Definición de if
(define if (lambda (p)                                          ;Jpxy.pxy
             (lambda (x)
               (lambda (y) (pxy)))))


; 1.1. Concatenar
(define concatenar
  (lambda (n) 
    (lambda (m)
      (((Y (lambda (g)
             (lambda (z)
               (lambda(w)
                 ;if
                 (((vacia? z)                                       ; Si no quedan elementos por concatenar, finalmente devolvemos la lista final
                   (lambda (no_use)
                     w
                     )
                   ;else
                   (lambda (no_use)                                 ; Si quedan elementos por concatenar, meto la cabeza de la lista1 en lista2, y llamamos de forma recursiva con ese resultado
                     ((construir (cabeza z)) ((g (cola z))w))
                     )
                   )
                  zero) ; Pasa zero como argumento de no_use
                 ))
             ))
        n)
       m)
      )
    ))

; 1.2. Longitud
(define longitud
  (lambda (l)
    ((Y (lambda (f)
          (lambda (x)
            (((vacia? x)
              (lambda (no_use)
                zero
                )
              (lambda (no_use)
                ((sumnat un) (f (cola x)))
                )
              )
             zero)  ; Pasa zero como argumento de no_use
            )
          ))
     l) ; Pasa l como el valor inicial de x.
    )
  )

; 1.3. Invertir una lista
(define invertir
  (lambda (n)                ;lista
    (lambda (m)              ;lista ordenada (vacia)
      (((Y (lambda (g)
             (lambda (z)     ;lista
               (lambda (w)   ;lista ordenada
                 ;if
                 (((vacia? z)
                   (lambda (no_use)
                     w
                     )
                   ;else
                   (lambda (no_use)
                     ((g (cola z)) ((construir (cabeza z)) w))
                     )
                   )
                  zero) ; Pasa zero como argumento de no_use
                 ))
             ))
        n)
       m)
      )
    ))


; 1.4. Pertenencia de un elemento a una lista
(define pertenece?
  (lambda (n) 
    (lambda (m)
      (((Y (lambda (g)
             (lambda (x)
               (lambda(y)
                 ;if
                 (((vacia? y)                                      ; Si no quedan elementos que buscar, entonces no hemos encontrado el elemento (false)
                   (lambda (no_use)
                     false
                     )
                   ;else
                   (lambda (no_use)
                     ;if
                     (((esigualent x) (cabeza y))                  ; Si quedan elementos por buscar, y ademas hemos encontrado el elemento, devolvemos true
                      true
                      ;else
                      ((g x) (cola y))                             ; Si quedan elementos por buscar pero no es el elemento que estamos buscando, llamada recursiva
                      )
                     ))
                  zero) ; Pasa zero como argumento de no_use
                 ))
             ))
        n)
       m)
      )
    ))
  

; 2.1. Sumar elementos de una lista
(define sumar-elems
  (lambda (l)
    ((Y (lambda (f)
          (lambda (x)
            ;if
            (((vacia? x)                                           ; Si la lista esta vacia, entonces la suma es 0
              (lambda (no_use)
                zero    ;devuelve
                )
              ;else
              (lambda (no_use)
                ((sument (cabeza x)) (f (cola x)))                 ; Si no es vacia, entonces llamo de forma recursiva a la cola de la lista para avanzar sumando el valor de la cabeza
                )
              )
             zero)  ; Pasa zero como argumento de no_use
            )
          ))
     l) ; Pasa l como el valor inicial de x.
    )
  )

; 2.2. Maximo y minimo de una lista
(define maximo
  (lambda (n)                 ; Numero -> estado inicial es la cabeza de la lista donde busco (para empezar a comprobar)
    (lambda (m)               ; Lista -> aquella donde busco el maximo
      (((Y (lambda (g)
             (lambda (x)
               (lambda(y)
                 (((vacia? y)
                   (lambda (no_use)                  ; Si no quedan elementos que comprobar, devuelvo el maximo (x)
                     x
                     )
                   (lambda (no_use)
                     (((esmayorent x) (cabeza y))    ; Si quedan elementos por mirar, y el elemento que estoy mirando NO es mayor que el maximo actual, llamada recursiva sin modificaciones
                      ((g x) (cola y))
                      ((g (cabeza y)) (cola y))      ; Si quedan elementos por mirar, y además el elemento que estoy mirando SI es mayor que el maximo actual, llamada recursiva modificando el valor del maximo (cabeza)
                      )
                     ))
                  zero)
                 ))
             ))
        n)
       m)
      )
    ))

(define minimo
  (lambda (n)               ; Numero -> estado inicial es la cabeza de la lista donde busco (para empezar a comprobar)
    (lambda (m)             ; Lista -> aquella donde busco el maximo
      (((Y (lambda (g)
             (lambda (x)
               (lambda(y)
                 (((vacia? y)
                   (lambda (no_use)                       ; Si no quedan elementos que comprobar, devuelvo el maximo (x)
                     x
                     )
                   (lambda (no_use)
                     (((esmenorent x) (cabeza y))         ; Si quedan elementos por mirar, y el elemento que estoy mirando NO es mayor que el maximo actual, llamada recursiva sin modificaciones
                      ((g x) (cola y))
                      ((g (cabeza y)) (cola y))           ; Si quedan elementos por mirar, y además el elemento que estoy mirando SI es mayor que el maximo actual, llamada recursiva modificando el valor del maximo (cabeza)
                      )
                     ))
                  zero)
                 ))
             ))
        n)
       m)
      )
    ))

; 2.3. Ordenacion de una lista
(define ordenar-menor-a-mayor                 ; Ordenar de menor a mayor
  (lambda (n)                ;lista
    (lambda (m)              ;lista ordenada (vacia)
      (((Y (lambda (g)
             (lambda (z)    ;lista
               (lambda (w)  ;lista ordenada
                 ;if --> si tiene la misma longitud la lista ordenada que x
                 (((vacia? z)
                   (lambda (no_use)
                     w
                     )
                   ;else
                   (lambda (no_use)
                     ((g (((quitar-elem ((maximo (cabeza z)) z)) z) vacia)) ((construir ((maximo (cabeza z)) z)) w))
                     )) zero) ; Pasa zero como argumento de no_use
                 ))
             ))
        n)
       m)
      )
    ))


(define ordenar-mayor-a-menor                ; Ordenar de mayor a menor
  (lambda (n)                ;lista
    (lambda (m)              ;lista ordenada (vacia)
      (((Y (lambda (g)
             (lambda (z)    ;lista
               (lambda (w)  ;lista ordenada
                 ;if --> si tiene la misma longitud la lista ordenada que x
                 (((vacia? z)
                   (lambda (no_use)
                     w
                     )
                   ;else
                   (lambda (no_use)
                     ((g (((quitar-elem ((minimo (cabeza z)) z)) z) vacia)) ((construir ((minimo (cabeza z)) z)) w))
                     )) zero) ; Pasa zero como argumento de no_use
                 ))
             ))
        n)
       m)
      )
    ))

; Auxiliar: Quitar elemento de una lista
(define quitar-elem
  (lambda (n)                       ;numero
    (lambda (m)                     ;lista
      (lambda (o)                   ;lista vacia
        ((((Y (lambda (g)
                (lambda (s)            ;numero
                  (lambda(w)           ;lista
                    (lambda (x)        ;lista vacia
                      ;if
                      (((vacia? w)
                        (lambda (no_use)
                          x
                          )
                        ;else
                        (lambda (no_use)
                          ;if --> cabeza de w == n --> no se mete
                          (((esigualent s) (cabeza w))
                           (((g s) (cola w)) x)
                           ;else --> se mete
                           (((g s) (cola w)) ((construir (cabeza w)) x))
                           )
                          ))
                       zero) ; Pasa zero como argumento de no_use
                      ))))
              )
           n)
          m)
         o)
        ))
    ))

; 2.4. Suma de listas de misma longitud

(define suma-listas
  (lambda (n) 
    (lambda (m)
      (lambda (o)
        ((((Y (lambda (g)
                (lambda (z)      ; lista1
                  (lambda(w)     ; lista2
                    (lambda (x)  ; lista vacia
                      ;if
                      (((vacia? z)
                        (lambda (no_use)
                          x
                          )
                        ;else
                        (lambda (no_use)
                          ((construir ((sument (cabeza z)) (cabeza w))) (((g (cola z))(cola w)) x))
                          )
                        )
                       zero) ; Pasa zero como argumento de no_use
                      )))
                ))
           m)
          n)
         o)
        ))
    ))

;;;------------------------------------------------------------------
;;;                             LISTAS
;;;------------------------------------------------------------------

(define lista-1 ((construir uno) vacia))

(define lista-v vacia)

(define lista-2 ((construir dos) ((construir uno) vacia)))

(define lista-3 ((construir diecisiete) ((construir -doce) ((construir veinte) ((construir dos) ((construir -seis) vacia))))))

(define lista-4 ((construir siete) ((construir seis) ((construir doce) ((construir -diez) ((construir quince) ((construir nueve) vacia)))))))

(define lista-5 ((construir siete) ((construir cero) ((construir -doce) ((construir diez) ((construir quince) ((construir uno) vacia)))))))


;;;------------------------------------------------------------------
;;;                             TESTS
;;;------------------------------------------------------------------

;Concatenar
(define (test1)
  (comprobar-lista ((concatenar lista-1) lista-2)))

;Longitud
(define (test2)
  (comprobar (longitud lista-3)))

(define (test3)
  ((esigualnat (longitud lista-4)) (longitud lista-5)))

;Invertir
(define (test4)
  (comprobar-lista ((invertir lista-4) lista-v)))

;Pertenece
(define (test5)
  ((pertenece? dos) lista-1))

;Suma elementos
(define (test6)
  (testenteros (sumar-elems lista-3)))

;Maximo
(define (test7)
  (testenteros ((maximo (cabeza lista-3)) lista-3)))

;Minimo
(define (test8)
  (testenteros ((minimo (cabeza lista-3)) lista-3)))

;Ordenacion lista
(define (test9)
  (comprobar-lista ((ordenar-menor-a-mayor lista-3) lista-v)))

(define (test10)
  (comprobar-lista ((ordenar-mayor-a-menor lista-3) lista-v)))

(define (test11)
  (comprobar-lista (((quitar-elem ((maximo (cabeza lista-3)) lista-3)) lista-3) lista-v))) ; Quitar elemento de una lista

;Suma de listas consideradas como vectores
(define (test12)
  (comprobar-lista (((suma-listas lista-4) lista-5) lista-v)))