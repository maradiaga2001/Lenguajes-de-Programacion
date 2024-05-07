package main

import (
	"fmt"
	"reflect"
	"sort"
	"strings"
)

type infoCliente struct {
	nombre string
	correo string
	edad   int32
}

type listaClientes []infoCliente

// Funcion que agrega los clientes a una lista
func (lc *listaClientes) agregarCliente(nombre, correo string, edad int32) {
	*lc = append(*lc, infoCliente{nombre, correo, edad})
}

// Funcion filter de clases
func filter3(list interface{}, f func(interface{}) bool) []interface{} {
	result := make([]interface{}, 0)
	switch reflect.TypeOf(list).Kind() {
	case reflect.Slice:
		s := reflect.ValueOf(list)
		for i := 0; i < s.Len(); i++ {
			if f(s.Index(i).Interface()) {
				result = append(result, s.Index(i).Interface())
			}
		}
	}
	return result
}

// Funcion map de clases
func map3(list any, f func(any) any) []any {
	result := make([]any, 0)
	switch reflect.TypeOf(list).Kind() {
	case reflect.Slice:
		s := reflect.ValueOf(list)
		for i := 0; i < s.Len(); i++ {
			result = append(result, f(s.Index(i).Interface()))
		}
	}
	return result
}

// Funcion reduce de clases
func reduce3(list []any) any {
	var result int32 = 0
	for _, v := range list {
		result += v.(int32)
	}
	return result
}

// Verifica si el apellido de la persona está en el correo
func listaClientes_ApellidosEnCorreo(clientes *listaClientes, apellidos []string) listaClientes {
	filtered := filter3(*clientes, func(c interface{}) bool {
		cliente := c.(infoCliente)
		correo := strings.ToLower(cliente.correo)
		for _, apellido := range apellidos {
			if strings.Contains(correo, strings.ToLower(apellido)) {
				return true
			}
		}
		return false
	})

	result := make(listaClientes, len(filtered))
	for i, c := range filtered {
		result[i] = c.(infoCliente)
	}

	return result
}

// Función que verifica la cantidad de correos con dominio cr
func cantidadCorreosCostaRica(clientes *listaClientes) int {
	filtered := filter3(*clientes, func(c interface{}) bool {
		cliente := c.(infoCliente)
		return strings.HasSuffix(cliente.correo, ".cr")
	})

	return len(filtered)
}

// Función que sugiere a un cliente un correo electronico
func clientesSugerenciasCorreos(clientes *listaClientes) listaClientes {
	result := make(listaClientes, 0)

	sugerenciaCorreo := func(c interface{}) interface{} {
		cliente := c.(infoCliente)
		if !strings.Contains(strings.ToLower(cliente.correo), strings.ToLower(cliente.nombre)) {
			// Cambiar el correo por una sugerencia que contemple el nombre de la persona
			cliente.correo = fmt.Sprintf("%s@ejemplo.com", strings.ReplaceAll(strings.ToLower(cliente.nombre), " ", "_"))
		}
		return cliente
	}

	clientesFiltrados := filter3(*clientes, func(c interface{}) bool {
		cliente := c.(infoCliente)
		return !strings.Contains(strings.ToLower(cliente.correo), strings.ToLower(cliente.nombre))
	})

	clientesActualizados := map3(clientesFiltrados, sugerenciaCorreo)

	for _, c := range clientesActualizados {
		result = append(result, c.(infoCliente))
	}

	return result
}

// Función que ordena alfabeticamente los correos
func correosOrdenadosAlfabeticos(clientes *listaClientes) []string {
	correos := make([]string, len(*clientes))
	for i, cliente := range *clientes {
		correos[i] = cliente.correo
	}
	sort.Strings(correos)
	return correos
}

func main() {
	var listaClientes listaClientes

	listaClientes.agregarCliente("Oscar Viquez", "oviquez@tec.ac.cr", 44)
	listaClientes.agregarCliente("Pedro Perez", "elsegundo@gmail.com", 30)
	listaClientes.agregarCliente("Maria Lopez", "mlopez@hotmail.com", 18)
	listaClientes.agregarCliente("Juan Rodriguez", "jrodriguez@gmail.com", 25)
	listaClientes.agregarCliente("Luisa Gonzalez", "muyseguro@tec.ac.cr", 67)
	listaClientes.agregarCliente("Marco Rojas", "loquesea@hotmail.com", 47)
	listaClientes.agregarCliente("Marta Saborio", "msaborio@gmail.com", 33)
	listaClientes.agregarCliente("Camila Segura", "csegura@ice.co.cr", 19)
	listaClientes.agregarCliente("Fernando Rojas", "frojas@estado.gov", 27)
	listaClientes.agregarCliente("Rosa Ramirez", "risuenna@gmail.com", 50)

	// Imprimir la lista original de clientes
	fmt.Println("Lista de clientes:")
	for i, cliente := range listaClientes {
		fmt.Printf("Cliente %d:\n", i+1)
		fmt.Printf("Nombre: %s\n", cliente.nombre)
		fmt.Printf("Correo: %s\n", cliente.correo)
		fmt.Printf("Edad: %d\n", cliente.edad)
		fmt.Println("-------------------------")
	}

	// Probar la función que busca los apellidos en el correo
	fmt.Println("Clientes cuyos correos contienen los apellidos:")
	apellidos := []string{"Rojas", "Viquez", "Rodriguez", "Saborio", "Segura", "Lopez"}
	resultado := listaClientes_ApellidosEnCorreo(&listaClientes, apellidos)
	if len(resultado) == 0 {
		fmt.Println("No se encontraron clientes con esos apellidos en los correos.")
	} else {
		for i, cliente := range resultado {
			fmt.Printf("Cliente %d:\n", i+1)
			fmt.Printf("Nombre: %s\n", cliente.nombre)
			fmt.Printf("Correo: %s\n", cliente.correo)
			fmt.Printf("Edad: %d\n", cliente.edad)
			fmt.Println("-------------------------")
		}
	}

	cantidad := cantidadCorreosCostaRica(&listaClientes)
	fmt.Printf("Cantidad de clientes cuyos correos pertenecen a dominios de Costa Rica: %d\n", cantidad)

	// Probar la función que sugiere correos a los clientes
	clientesActualizados := clientesSugerenciasCorreos(&listaClientes)

	fmt.Println("\nClientes con sugerencias de correos actualizados:")
	for i, cliente := range clientesActualizados {
		fmt.Printf("Cliente %d:\n", i+1)
		fmt.Printf("Nombre: %s\n", cliente.nombre)
		fmt.Printf("Correo: %s\n", cliente.correo)
		fmt.Printf("Edad: %d\n", cliente.edad)
		fmt.Println("-------------------------")
	}

	// Probar la función que ordena alfabeticamente los correos
	correosOrdenados := correosOrdenadosAlfabeticos(&listaClientes)
	fmt.Println("Correos ordenados alfabéticamente:")
	for i, correo := range correosOrdenados {
		fmt.Printf("%d: %s\n", i+1, correo)
	}

}
