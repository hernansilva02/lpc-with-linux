# LPC845brk with linux
2 scripts básicos para poder usar la placa de desarrollo LPC845brk en linux, ya que las muy buenas personas de NXP aparentemente no quieren que usemos otra cosa que no sea su tan aclamado IDE (ni siquiera es de ellos, es basado en Eclipse, pero igual te tenés que registrar para poder descargarlo).

## Usage

```bash
./install.sh
cp cmlists_gen.sh /path/a/tu/proyecto
cp compile.sh /path/a/tu/proyecto
```

Una vez que tengamos todo el source code


```bash
./cmlists_gen.sh project_name
```

Luego, agregá todos los nombres de los archivos fuente al CMakeLists.txt (por si no sabes usar cmake, donde dice add_executable()) y compilás

```bash
./compile.sh
```

Con esto, ya se generó un archivo .elf


## How to



