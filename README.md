# Compilador del languaje de programación Sergio
Integrantes del proyecto:
- Bilevich, Andres Leonardo  	59108 
- Margossian, Gabriel Viken  	59130
- Mónaco, Matías Damian		59102
- Lin, Scott				59339
### Sergio
**Sergio** es un lenguaje de programación que permite generar simulaciones físicas entre cuerpos. Estos cuerpos pueden interactuar entre ellos, utilizando características como la densidad, tamaño y la constante gravitacional de un espacio. Con estos parámetros se utilizan ecuaciones físicas para calcular la atracción y las fuerzas producidas entre dichos cuerpos y visualizar esto en la pantalla. Este lenguaje permite, entre otras cosas, simular sistemas solares estables o inestables y colisiones inelásticas entre cuerpos.
Para compilar codigo de dicho lenguaje, se implementó un compilador del lenguaje que traduce el codigo a codigo JavaScript.

### Compilación del compilador:
Para compilar el compilador ejecutar el comando `make` en el directorio en la que se encuentra el archivo Makefile. Esto generará el ejecutable compile dentro del mismo directorio. Para recompilar el ejecutable, hacer primero `make clean`.

### Compilar programas
Una vez generado el ejecutable del compilador, ya es posible compilar programas escritos en **Sergio**. Para lograr esto, ejecutar el comando `./compile archivo.phi`, siendo `archivo.phi` el archivo que contiene el codigo **Sergio**.

### Programas de ejemplo
Para acostumbrarse a la sintaxis del lenguaje, ofrecemos algunos programas de ejemplo, desde `sample_program1.phi` hasta `sample_program6.phi`. Estos se compilan de la misma forma que la vista en la sección anterior.
