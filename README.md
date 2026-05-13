# LPC845BRK with linux
Scripts básicos para poder usar la placa de desarrollo LPC845brk en linux, ya que las muy buenas personas de NXP aparentemente no quieren que usemos otra cosa que no sea su tan aclamado IDE (ni siquiera es de ellos, es basado en Eclipse, pero igual te tenés que registrar para poder descargarlo) mcuexpresso o VScode.

## Usage

```bash
./install.sh
cp cmlists_gen.sh /path/a/tu/proyecto
cp compile.sh /path/a/tu/proyecto
```

Una vez que tengas todo el source code de tu proyecto


```bash
./cmlists_gen.sh project_name
```

Luego, agregá todos los nombres de los archivos fuente al CMakeLists.txt (por si no sabes usar cmake, donde dice add_executable()) y compilás

```bash
./compile.sh
```

Con esto, ya se generó un archivo .elf


## How to
Por default, la compilación hecha es de tipo debug, por lo que se creará un nuevo dir con ese nombre y dentro de él está el ejecutable .elf.
En una terminal ejecutá openocd
```bash
openocd -f interface/cmsis-dap.cfg -f target/lpc84x.cfg
```
Eso crea un servidor gdb, la idea es cargar/flashear el programa con él.
En otra terminal poné
#### debian based
```bash
gdb-multiarch binary_name.elf
```
#### fedora
```bash
arm-none-eabi-gdb binary_name.elf
```

Dentro de gdb, necesitas conectarte al server generado por openocd, subir el programa a la placa y ejecutarlo. Para eso hacé lo siguiente

```gdb
tar ext localhost:3333
monitor reset halt
load
continue
run
```

Listo, ya está cargado el programa
