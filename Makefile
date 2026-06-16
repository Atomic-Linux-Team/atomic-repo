# Makefile para atomic-tour - Proyecto GTK4 tipo GNOME Tour

# Compilador y flags
CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g
GTK4_FLAGS = $(shell pkg-config --cflags gtk4 libadwaita-1)
GTK4_LIBS = $(shell pkg-config --libs gtk4 libadwaita-1)

# Nombres de archivos
TARGET = atomic-tour
SRC = main.c
OBJ = $(SRC:.c=.o)

# Directorios
BUILD_DIR = build
ASSETS_DIR = assets

# Archivos de recursos
RESOURCES = $(wildcard $(ASSETS_DIR)/*.png) $(wildcard $(ASSETS_DIR)/*.mp4)

# Flags de compilación
CFLAGS += $(GTK4_FLAGS)
LDFLAGS += $(GTK4_LIBS)

# Valores por defecto
all: $(TARGET)

# Enlace del ejecutable
$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# Compilación de archivos .c
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Limpieza
.PHONY: clean

clean:
	rm -f $(TARGET) $(OBJ)

# Instalar recursos (opcional)
install: $(TARGET)
	install -Dm755 $(TARGET) /usr/local/bin/$(TARGET)

# Mostrar ayuda
.PHONY: help
help:
	@echo "Opciones disponibles:"
	@echo "  make        - Compilar el ejecutable"
	@echo "  make clean  - Eliminar archivos compilados"
	@echo "  make install - Instalar el ejecutable en /usr/local/bin"

# Verificar si pkg-config está disponible
check:
	@echo "Verificando dependencias..."
	npkg-config --exists gtk4 && echo "✓ GTK4 encontrado" || echo "✗ GTK4 no encontrado"
	npkg-config --exists adwaita-1 && echo "✓ Adwaita encontrado" || echo "✗ Adwaita no encontrado"

# Compilar con recursos (si es necesario)
resources: $(TARGET)
	@echo "Los recursos están en $(ASSETS_DIR)/"

.PHONY: all clean install help check resources
