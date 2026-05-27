# variáveis de compilação
ASM       = nasm
ASM_FLAGS = -f elf64 -Isrc/
LD        = ld -s -N --no-eh-frame-hdr -z max-page-size=0x1000

# diretórios
SRC_DIR   = src
BUILD_DIR = build

# nome do binário final
TARGET    = $(BUILD_DIR)/web-server

# encontra automaticamente todos os arquivos .asm na pasta src (mas ignora subpastas como include)
SRCS      = $(wildcard $(SRC_DIR)/*.asm)

# define os arquivos de objeto (.o) correspondentes dentro da pasta build
OBJS      = $(patsubst $(SRC_DIR)/%.asm, $(BUILD_DIR)/%.o, $(SRCS))

# regra padrão (é executada quando você digita apenas 'make')
all: $(BUILD_DIR) $(TARGET)

# regra para linkar o binário final
$(TARGET): $(OBJS)
	$(LD) -e main  $(OBJS) -o $(TARGET)
	@echo "=================================================="
	@echo "   Sucesso! Binário gerado em: $(TARGET)"
	@echo "   Lembre-se: coloque o index.html na pasta '$(BUILD_DIR)'"
	@echo "=================================================="

# regra genérica para compilar os arquivos .asm em .o
# makefile só recompile o arquivo se o .asm correspondente tiver mudado
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm
	$(ASM) $(ASM_FLAGS) $< -o $@

# garante que a pasta build exista antes de compilar
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# limpa os arquivos gerados (para compilar tudo do zero usando 'make clean')
clean:
	rm -rf $(BUILD_DIR)/*.o $(TARGET)
	@echo "  Limpeza concluída"

# evita conflitos caso existam arquivos chamados 'all' ou 'clean' no sistema
.PHONY: all clean
