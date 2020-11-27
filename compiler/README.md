# Compilador del languaje de programación Physique
Integrantes del proyecto:
- Bilevich, Andres Leonardo  	59108 
- Margossian, Gabriel Viken  	59130
- Mónaco, Matías Damian		    59102
- Lin, Scott				    59339
### Physique
**Physique** es un lenguaje de programación que permite generar simulaciones físicas entre cuerpos. Estos cuerpos pueden interactuar entre ellos, utilizando características como la densidad, tamaño y la constante gravitacional de un espacio. Con estos parámetros se utilizan ecuaciones físicas para calcular la atracción y las fuerzas producidas entre dichos cuerpos y visualizar esto en la pantalla. Este lenguaje permite, entre otras cosas, simular sistemas solares estables o inestables y colisiones inelásticas entre cuerpos.
Para compilar codigo de dicho lenguaje, se implementó un compilador del lenguaje que traduce el código a código JavaScript.

### Compilación del compilador
Para compilar el compilador ejecutar el comando `make` en el directorio en la que se encuentra el archivo Makefile. Esto generará el ejecutable compile dentro del mismo directorio. Para recompilar el ejecutable, hacer primero `make clean`.

### Compilar programas
Una vez generado el ejecutable del compilador, ya es posible compilar programas escritos en **Physique**. Para lograr esto, ejecutar el comando `./compile archivo.phy`, siendo `archivo.phy` el archivo que contiene el codigo **Physique**.

### Ejecutar programa resultante
Una vez compilado el programa, se generará un archivo `index.html` que se puede ejecutar en cualquier browser.

### Programas de ejemplo
Para acostumbrarse a la sintaxis del lenguaje, ofrecemos algunos programas de ejemplo, desde `sample_program1.phy` hasta `sample_program5.phy`. Estos se compilan de la misma forma que la vista en la sección de compilar programas.
A continuación una breve descripción de cada programa:
- sample_program1.phy
    Este programa pide al usuario que ingrese un numero entre el 0 y el 6 y genera un sistema solar semi-estable con esa cantidad de planetas

- sample_program2.phy
    Este programa muestra el comportamiento del trail y de como un cuerpo orbita a otro en movimiento

- sample_program3.phy
    Este protrama pide al usuario un numero arbitrio de curpos y genera estos para poder ver la colisión e interacción entre ellos

- sample_program4.phy
    Este programa simula un sistema binario semi-estable donde dos "soles" orbitan el uno al otro y dos "planetas" orbitan el sistema binaro

- sample_program5.phy
    Este programa es una demostración de como deshabilitar la constante gravitatioria, elimina las atracciones entre curpos y solo se aprecian las colisiones
