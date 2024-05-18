import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


// Clase base para representar una persona
class Persona {
    private String nombre;
    private String apellido;
    private String correo;

    // Constructor para inicializar los datos de la persona
    public Persona(String nombre, String apellido, String correo) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo = correo;
    }

    // Método para representar la persona como una cadena de texto
    @Override
    public String toString() {
        return String.format("Nombre: %s %s\nCorreo: %s", nombre, apellido, correo);
    }
}

// Clase base para representar un contacto, extiende la clase Persona
class Contacto extends Persona {
    // Constructor para inicializar los datos del contacto
    public Contacto(String nombre, String apellido, String correo) {
        super(nombre, apellido, correo);
    }
}

// Clase para representar un contacto familiar, extiende la clase Contacto
class ContactoFamiliar extends Contacto {
    private String parentesco;

    // Constructor para inicializar los datos del contacto familiar
    public ContactoFamiliar(String nombre, String apellido, String correo, String parentesco) {
        super(nombre, apellido, correo);
        this.parentesco = parentesco;
    }

    // Método para representar el contacto familiar como una cadena de texto
    @Override
    public String toString() {
        return "==== CONTACTO FAMILIAR ====\n" + super.toString() + String.format("\nParentesco: %s\n========================", parentesco);
    }
}

// Clase para representar un contacto empresarial, extiende la clase Contacto
class ContactoEmpresarial extends Contacto {
    private String empresa;
    private String puesto;

    // Constructor para inicializar los datos del contacto empresarial
    public ContactoEmpresarial(String nombre, String apellido, String correo, String empresa, String puesto) {
        super(nombre, apellido, correo);
        this.empresa = empresa;
        this.puesto = puesto;
    }

    // Método para representar el contacto empresarial como una cadena de texto
    @Override
    public String toString() {
        return "==== CONTACTO EMPRESARIAL ====\n" + super.toString() + String.format("\nEmpresa: %s\nPuesto: %s\n=============================", empresa, puesto);
    }
}

// Clase base para representar un evento
class Evento {
    private String nombreEvento;
    private String fecha;

    // Constructor para inicializar los datos del evento
    public Evento(String nombreEvento, String fecha) {
        this.nombreEvento = nombreEvento;
        this.fecha = fecha;
    }

    // Método para representar el evento como una cadena de texto
    @Override
    public String toString() {
        return String.format("Evento: %s\nFecha: %s", nombreEvento, fecha);
    }
}

// Clase para representar un evento especial, extiende la clase Evento
class EventoEspecial extends Evento {
    private String descripcion;

    // Constructor para inicializar los datos del evento especial
    public EventoEspecial(String nombreEvento, String fecha, String descripcion) {
        super(nombreEvento, fecha);
        this.descripcion = descripcion;
    }

    // Método para representar el evento especial como una cadena de texto
    @Override
    public String toString() {
        return "==== EVENTO ESPECIAL ====\n" + super.toString() + String.format("\nDescripción: %s\n=========================", descripcion);
    }
}

// Patronde diseño Singleton 
// Clase que representa la agenda que almacena contactos y eventos
class Agenda {
    private List<Object> elementos; // Estructura de datos para almacenar contactos y eventos

    private static Agenda instancia; // Instancia única de la agenda

    // Constructor privado para evitar la creación de instancias desde fuera de la clase
    private Agenda() {
        this.elementos = new ArrayList<>();
    }

    // Método estático para obtener la instancia única de la agenda
    public static Agenda getInstancia() {
        if (instancia == null) {
            instancia = new Agenda();
        }
        return instancia;
    }

    // Método para agregar un elemento a la agenda
    public void agregarElemento(Object elemento) {
        elementos.add(elemento);
    }

    // Método para eliminar un elemento de la agenda
    public void eliminarElemento(Object elemento) {
        elementos.remove(elemento);
    }

    // Método para modificar un elemento de la agenda
    public void modificarElemento(int index, Object nuevoElemento) {
        if (index >= 0 && index < elementos.size()) {
            elementos.set(index, nuevoElemento);
        }
    }

    // Método para obtener todos los elementos de la agenda
    public List<Object> getElementos() {
        return elementos;
    }

    // Método para representar la agenda como una cadena de texto
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (Object elemento : elementos) {
            sb.append(elemento.toString()).append("\n\n");
        }
        return sb.toString();
    }
}

// Clase abstracta para la fábrica de creación de contactos y eventos
abstract class AbstractFactory {
    abstract Contacto crearContacto(String nombre, String apellido, String correo, String tipo, String... extra);
    abstract Evento crearEvento(String nombreEvento, String fecha, String tipo, String... extra);
}

// Patron de diseño Factory Abstract
// Clase concreta para la fábrica de creación de contactos
class ContactoFactory extends AbstractFactory {
    // Método para crear un contacto según el tipo especificado
    @Override
    public Contacto crearContacto(String nombre, String apellido, String correo, String tipo, String... extra) {
        if (tipo.equalsIgnoreCase("familiar")) {
            return new ContactoFamiliar(nombre, apellido, correo, extra[0]);
        } else if (tipo.equalsIgnoreCase("empresarial")) {
            return new ContactoEmpresarial(nombre, apellido, correo, extra[0], extra[1]);
        }
        return new Contacto(nombre, apellido, correo);
    }

    // Método para crear un evento (no implementado en esta fábrica)
    @Override
    public Evento crearEvento(String nombreEvento, String fecha, String tipo, String... extra) {
        return null;
    }
}

// Patron de diseño Factory Abstract
// Clase concreta para la fábrica de creación de eventos
class EventoFactory extends AbstractFactory {
    // Método para crear un contacto (no implementado en esta fábrica)
    @Override
    public Contacto crearContacto(String nombre, String apellido, String correo, String tipo, String... extra) {
        return null;
    }

    // Método para crear un evento según el tipo especificado
    @Override
    public Evento crearEvento(String nombreEvento, String fecha, String tipo, String... extra) {
        if (tipo.equalsIgnoreCase("especial")) {
            return new EventoEspecial(nombreEvento, fecha, extra[0]);
        }
        return new Evento(nombreEvento, fecha);
    }
}
public class Main {

    public static void main(String[] args) {
        Agenda agenda = Agenda.getInstancia();

        AbstractFactory contactoFactory = new ContactoFactory();
        AbstractFactory eventoFactory = new EventoFactory();

        Contacto c1 = contactoFactory.crearContacto("Alice", "Johnson", "alice.johnson@example.com", "familiar", "Hija");
        Contacto c2 = contactoFactory.crearContacto("Bob", "Williams", "bob.williams@example.com", "empresarial", "Agroservicios M&M", "Director de Marketing");
        Evento e1 = eventoFactory.crearEvento("Lanzamiento de Producto", "12-10-2024", "simple");
        Evento e2 = eventoFactory.crearEvento("Conferencia de Innovación", "12-12-2024", "especial", "Innovación digital");

        agenda.agregarElemento(c1);
        agenda.agregarElemento(e1);
        agenda.agregarElemento(c2);
        agenda.agregarElemento(e2);

        System.out.println("=== TODOS LOS ELEMENTOS EN LA AGENDA ===\n");
        System.out.println(agenda);

        // Filter determinista
        // Filtrar los contactos de la agenda
        List<Contacto> contactos = agenda.getElementos().stream()
            .filter(elemento -> elemento instanceof Contacto)
            .map(elemento -> (Contacto) elemento)
            .collect(Collectors.toList());

        //Filter determinista 
        // Filtrar los eventos de la agenda
        List<Evento> eventos = agenda.getElementos().stream()
            .filter(elemento -> elemento instanceof Evento)
            .map(elemento -> (Evento) elemento)
            .collect(Collectors.toList());

        System.out.println("\n=== CONTACTOS EN LA AGENDA ===\n");
        contactos.forEach(System.out::println);

        System.out.println("\n=== EVENTOS EN LA AGENDA ===\n");
        eventos.forEach(System.out::println);
    }
}

/*
_________________________________________________________________________________________________________________________
 Impresion: 

=== TODOS LOS ELEMENTOS EN LA AGENDA ===

==== CONTACTO FAMILIAR ====
Nombre: Alice Johnson
Correo: alice.johnson@example.com
Parentesco: Hija
========================

Evento: Lanzamiento de Producto
Fecha: 12-10-2024

==== CONTACTO EMPRESARIAL ====
Nombre: Bob Williams
Correo: bob.williams@example.com
Empresa: Agroservicios M&M
Puesto: Director de Marketing
=============================

==== EVENTO ESPECIAL ====
Evento: Conferencia de Innovación
Fecha: 12-12-2024
Descripción: Innovación digital
=========================



=== CONTACTOS EN LA AGENDA ===

==== CONTACTO FAMILIAR ====
Nombre: Alice Johnson
Correo: alice.johnson@example.com
Parentesco: Hija
========================
==== CONTACTO EMPRESARIAL ====
Nombre: Bob Williams
Correo: bob.williams@example.com
Empresa: Agroservicios M&M
Puesto: Director de Marketing
=============================
=== EVENTOS EN LA AGENDA ===

Evento: Lanzamiento de Producto
Fecha: 12-10-2024
==== EVENTO ESPECIAL ====
Evento: Conferencia de Innovación
Fecha: 12-12-2024
Descripción: Innovación digital
=========================

_________________________________________________________________________________________________________________________
 */
/* 
_________________________________________________________________________________________________________________________________
Usé Singleton para garantizar una única instancia de la agenda en todo el programa.

Utilicé el Abstract Factory para proporcionar de una manera más flexible y separada diferentes 
tipos de contactos y eventos. 

Ambos patrones permiten la modularidad y al mantenimiento del sistema 
de manera sencilla.

_________________________________________________________________________________________________________________________________

Eager Singleton y Lazy Singleton:

Ambos patrones de diseño Singleton aseguran que solo exista una instancia de una clase en todo el programa.

Sin embargo, la diferencia principal entre ellos es el momento en que se instancia la única instancia de la 
clase Singleton. Se sabe que en Eager Singleton la instancia única de la clase se crea cuando la clase 
es cargada por primera vez en memoria, básicamente en el momento de la inicialización estática del objeto en la 
declaración de la variable. 
Por otro lado, en Lazy Singleton la instancia única de la clase no se crea hasta que sea solicitada por primera vez. 
Esto se logra demorando la creación de la instancia hasta que sea necesaria, normalmente dentro del método getInstancia().

Es por ello, que considero que la más adecuada al problema es la Eager Singleton, porque la instancia de la agenda se crea 
tan pronto como la clase Agenda es cargada en memoria, incluso si no se usa.

________________________________________________________________________________________________________________________________
 
Referencias: 
https://stackoverflow.com/questions/7790185/singleton-lazy-vs-eager-instantiation
https://www.linkedin.com/pulse/two-types-singleton-design-pattern-lazy-eager-arifuzzaman-tanin/

*/
