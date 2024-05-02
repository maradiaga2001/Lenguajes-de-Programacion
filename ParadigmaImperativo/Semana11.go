package main

import "fmt"

type producto struct {
	nombre   string
	cantidad int
	precio   int
}

type stockProductos []producto

var inventario stockProductos

const cantidadMinima int = 10

func (s *stockProductos) agregarProducto(nombre string, cantidad int, precio int) {
	indice, _ := s.buscarProducto(nombre)
	if indice != -1 {
		(*s)[indice].cantidad += cantidad
		if precio != (*s)[indice].precio {
			(*s)[indice].precio = precio
		}
	} else {
		*s = append(*s, producto{nombre: nombre, cantidad: cantidad, precio: precio})
	}
}

func (s *stockProductos) agregarProductos(productos ...producto) {
	for _, p := range productos {
		s.agregarProducto(p.nombre, p.cantidad, p.precio)
	}
}

func (s *stockProductos) buscarProducto(nombre string) (int, error) {
	for i, p := range *s {
		if p.nombre == nombre {
			return i, nil
		}
	}
	return -1, fmt.Errorf("producto '%s' no encontrado", nombre)
}

func (s *stockProductos) venderProducto(nombre string, cantidad int) error {
	indice, err := s.buscarProducto(nombre)
	if err != nil {
		return err
	}
	if (*s)[indice].cantidad < cantidad {
		return fmt.Errorf("no hay suficiente '%s' en stock", nombre)
	}
	(*s)[indice].cantidad -= cantidad
	if (*s)[indice].cantidad == 0 {
		s.eliminarProducto(indice)
	}
	return nil
}

func (s *stockProductos) modificarPrecio(nombre string, nuevoPrecio int) error {
	indice, err := s.buscarProducto(nombre)
	if err != nil {
		return err
	}
	(*s)[indice].precio = nuevoPrecio
	return nil
}

func (s *stockProductos) eliminarProducto(indice int) {
	*s = append((*s)[:indice], (*s)[indice+1:]...)
}

func (s *stockProductos) listarProductosMinimos() stockProductos {
	var productosMinimos stockProductos
	for _, p := range *s {
		if p.cantidad <= cantidadMinima {
			productosMinimos = append(productosMinimos, p)
		}
	}
	return productosMinimos
}

func inicializarDatos() {
	inventario.agregarProducto("arroz", 15, 2500)
	inventario.agregarProducto("frijoles", 4, 2000)
	inventario.agregarProducto("leche", 8, 1200)
	inventario.agregarProducto("café", 12, 4500)
}

func main() {
	inicializarDatos()
	fmt.Println("Inventario antes de la venta:")
	fmt.Println(inventario)

	err := inventario.venderProducto("arroz", 3)

	if err != nil {
		fmt.Println("Error en la venta:", err)
	}

	fmt.Println("\nInventario después de la venta:")
	fmt.Println(inventario)

	err = inventario.modificarPrecio("café", 3500)
	if err != nil {
		fmt.Println("Error al modificar precio:", err)
	}

	fmt.Println("\nInventario después de modificar precio:")
	fmt.Println(inventario)

	fmt.Println("\nProductos con cantidad mínima en stock:")
	productosMinimos := inventario.listarProductosMinimos()
	fmt.Println(productosMinimos)
}

