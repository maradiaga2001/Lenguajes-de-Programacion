;Ejercicio2
(define (contieneSubcadena? cadena subcadena)
  (let loop ((i 0))
    (cond ((>= (+ i (string-length subcadena)) (string-length cadena)) #f)
          ((string=? (substring cadena i (+ i (string-length subcadena))) subcadena) #t)
          (else (loop (+ i 1))))))

(define (filtrar listaCadenas subcadena)
  (filter (lambda (cadena) (contieneSubcadena? cadena subcadena)) listaCadenas))

; Para verificar funcionamiento usar lo siguiente:
;(display (filtrar '("la casa," "el perro" "pintando la cerca") "la"))
;(display (filtrar '("el carro," "la perra" "pintando el techo") "la"))
;(display (filtrar '("el carro," "la perra" "pintando el techo") "el"))
