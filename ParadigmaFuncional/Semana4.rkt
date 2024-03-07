;Ejercicio1
;Supermercado, lista de productos, cantidad de productos, precio de productos (listas de listas)
;Funciones, agregar producto(nuevo producto,actualizar si un producto ya existe, lista),
;vender producto(lista, producto, cantidad),existencias mínimas(lista, num) Casos(no hay producto)

(define ListaProductos'(("arroz" 8 1800)
                        ("frijoles" 5 1200)
                        ("azucar" 6 1100)
                        ("café" 2 2800)
                        ("leche" 9 1200)))

(define (agregarProducto Lista nombre cantidad precio)
  (cond ((null? Lista)         
        (list (list nombre cantidad precio)))
  ((equal? nombre (caar Lista))
           (cons (list
                  (caar Lista)
                  (+ (cadar Lista) cantidad)
                  precio)
                 (cdr Lista)))
  (else 
   (cons (car Lista) (agregarProducto
                      (cdr Lista)
                      nombre
                      cantidad
                      precio)))))
;(agregarProducto
          ; (agregarProducto ListaProductos "fideos" 10 600)
          ; "arroz" 4 1850)

(define (venderProducto Lista nombre cantidad precio)
  (cond ((null? Lista)
         (display "No existe el producto para vender")
         '())
        ((equal? nombre (caar Lista))
         (cons (list
                (caar Lista)
                (- (list-ref (car Lista)1) cantidad)
                (list-ref (car Lista) 2))
               (cdr Lista)))
        (else 
         (cons (car Lista)
               (venderProducto (cdr Lista) nombre cantidad precio)))))
;(venderProducto ListaProductos "arroz" 3 1800)


(define (existenciasMinimas Lista cantidad)
    (filter (lambda(x)(<= (cadr x) cantidad))
             Lista))
;(existenciasMinimas ListaProductos 6)


(define (NuevaFactura lista1 lista2)
  (cond
    ((null? lista1)
     '())
    ((not (equal? (car lista2) (car lista1)))
     (cons
      (list (list-ref (car lista2) 0)
            (- (list-ref (car lista1) 1)
               (list-ref (car lista2) 1))
            (list-ref (car lista2) 2))
      (NuevaFactura (cdr lista1) (cdr lista2))))
    (else 
     (NuevaFactura (cdr lista1) (cdr lista2)))))

;Función para calcular el impuesto total de la factura
(define (calcular-total-factura-con-Impuesto Factura Monto x )
  (cond
    ((null? Factura)
     (display "Impuestos Totales: ")
     (display x)
     (newline))
    ((>= (list-ref (car Factura) 2) Monto)
      (calcular-total-factura-con-Impuesto (cdr Factura) Monto
                (+ x (* (list-ref (car Factura) 1)
                        (* (list-ref (car Factura) 2) 0.13)))))
    (else
     (calcular-total-factura-con-Impuesto (cdr Factura) Monto x))))
     
;; Función para calcular el monto total de la factura sin impuesto
(define (calcular-total-factura-sin-impuesto Factura)
  (cond
    ((null? Factura)
     0)
    (else
     (let ((subtotal (* (cadr (car Factura)) (caddr (car Factura)))))
       (+ subtotal (calcular-total-factura-sin-impuesto (cdr Factura)))))))

;Pruebas
;(display "Factura 1:")
;(define factura1 (NuevaFactura ListaProductos (venderProducto (venderProducto ;ListaProductos "café" 1  2800) "arroz" 2 1800)))
;(display factura1)
;(display "Impuesto Factura 1:")
;(display (calcular-total-factura-con-Impuesto factura1 1200 0))
;(display "Total Factura 1:")
;(display (calcular-total-factura-sin-impuesto factura1))
;(display "Factura 2:")
;(define factura2 (NuevaFactura ListaProductos (venderProducto (venderProducto ;ListaProductos "azucar" 3 1100) "arroz" 2 1800)))
;(display factura2)
;(display "Impuesto Factura 2:")
;(display (calcular-total-factura-con-Impuesto factura2 1200 0))
;(display "Total Factura 2:")
;(display (calcular-total-factura-sin-impuesto factura2))
;(display "Factura 3:")
;(define factura3 (NuevaFactura ListaProductos (venderProducto (venderProducto ;ListaProductos "frijoles" 2 1200) "leche" 4 1200)))
;(display factura3)
;(display "Impuesto Factura 3:")
;(display (calcular-total-factura-con-Impuesto factura3 1200 0))
;(display "Total Factura 3:")
;(display (calcular-total-factura-sin-impuesto factura3))


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
