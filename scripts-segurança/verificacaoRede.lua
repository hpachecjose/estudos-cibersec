local host = "8.8.8.8"
local attempts = 4
local success = 0

print("Verificando segurança básica da rede...\n")

for i = 1, attempts do
    local result = os.execute("ping -c 1" .. host .. " > /dev/null 2>&1")
    if result == 0 then
        print("Ping " .. i .. ": OK")
        success = success + 1
    else
        print("Ping " .. i .. ": Falhou")
    end
    os.execute("sleep 1")
end

print("\nResultados: " .. success .. "/" .. attempts .. " pacotes enviados.")

if success == attempts then
    print("Conexão estável.")
else
    print("Conexão instável ou bloqueada.")
-- Configurações de rede e parâmetros de teste de conectividade
local host = "8.8.8.8"    -- Endereço IP de destino (Google Public DNS)
local attempts = 4         -- Número total de tentativas de envio de pacotes
local success = 0          -- Contador de respostas ICMP bem-sucedidas

print("Iniciando verificação de conectividade e segurança de rede...\n")

-- Ciclo de execução das tentativas de ping
for i = 1, attempts do
    -- Executa o comando ping (1 pacote) redirecionando a saída para /dev/null
    -- Nota: Adicionado espaço após '-c 1' para correta concatenação do host
    local result = os.