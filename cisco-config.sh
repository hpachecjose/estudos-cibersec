#!/bin/bash

# Script para gerar configurações Cisco automaticamente
# Esses comandos podem ser copiados e colados no Packet Tracer

echo "=== GERADOR DE CONFIGURAÇÕES CISCO ==="
echo ""

# Função para configurar um Switch
generate_switch_config() {
    local hostname=$1
    local vlan_id=$2
    local vlan_name=$3
    
    cat << EOF
! ===== Configuração do Switch: $hostname =====
enable
configure terminal
hostname $hostname
!
! Configurar VLAN
vlan $vlan_id
name $vlan_name
exit
!
! Configurar interfaces de acesso
interface range FastEthernet0/1-10
switchport mode access
switchport access vlan $vlan_id
no shutdown
exit
!
! Configurar interface trunk
interface GigabitEthernet0/1
switchport mode trunk
switchport trunk allowed vlan all
no shutdown
exit
!
! Configurações de segurança básica
enable secret cisco123
line console 0
password console123
login
exit
line vty 0 4
password vty123
login
exit
!
! Salvar configuração
end
write memory
!
EOF
}

# Função para configurar um Router
generate_router_config() {
    local hostname=$1
    local interface=$2
    local ip_address=$3
    local subnet_mask=$4
    
    cat << EOF
! ===== Configuração do Router: $hostname =====
enable
configure terminal
hostname $hostname
!
! Configurar interface
interface $interface
ip address $ip_address $subnet_mask
no shutdown
exit
!
! Habilitar roteamento
ip routing
!
! Configurar rota padrão (gateway)
! ip route 0.0.0.0 0.0.0.0 <próximo-hop>
!
! Configurações de segurança
enable secret cisco123
line console 0
password console123
login
exit
line vty 0 4
password vty123
login
transport input telnet ssh
exit
!
! Banner de login
banner motd #
*************************************************
* Acesso Autorizado Apenas                      *
* Router: $hostname                             *
*************************************************
#
!
! Salvar configuração
end
write memory
!
EOF
}

# Função para configurar RIP
generate_rip_config() {
    local networks=("$@")
    
    cat << EOF
! ===== Configuração do Protocolo RIP =====
configure terminal
router rip
version 2
no auto-summary
EOF
    
    for network in "${networks[@]}"; do
        echo "network $network"
    done
    
    cat << EOF
exit
end
write memory
!
EOF
}

# Função para configurar OSPF
generate_ospf_config() {
    local process_id=$1
    shift
    local networks=("$@")
    
    cat << EOF
! ===== Configuração do Protocolo OSPF =====
configure terminal
router ospf $process_id
EOF
    
    for network in "${networks[@]}"; do
        local net=$(echo $network | cut -d'/' -f1)
        local wildcard=$(echo $network | cut -d'/' -f2)
        echo "network $net $wildcard area 0"
    done
    
    cat << EOF
exit
end
write memory
!
EOF
}

# Menu interativo
echo "Escolha o tipo de configuração:"
echo "1) Switch com VLAN"
echo "2) Router com interface"
echo "3) Protocolo RIP"
echo "4) Protocolo OSPF"
echo "5) Configuração completa de rede"
echo ""
read -p "Opção: " option

case $option in
    1)
        read -p "Nome do Switch: " sw_name
        read -p "ID da VLAN: " vlan_id
        read -p "Nome da VLAN: " vlan_name
        generate_switch_config "$sw_name" "$vlan_id" "$vlan_name"
        ;;
    2)
        read -p "Nome do Router: " rt_name
        read -p "Interface (ex: GigabitEthernet0/0): " interface
        read -p "Endereço IP: " ip_addr
        read -p "Máscara de Sub-rede: " subnet
        generate_router_config "$rt_name" "$interface" "$ip_addr" "$subnet"
        ;;
    3)
        echo "Digite as redes (ex: 192.168.1.0), uma por linha. Digite 'fim' para terminar:"
        networks=()
        while true; do
            read -p "Rede: " net
            [[ "$net" == "fim" ]] && break
            networks+=("$net")
        done
        generate_rip_config "${networks[@]}"
        ;;
    4)
        read -p "Process ID do OSPF: " process_id
        echo "Digite as redes no formato 'IP WILDCARD' (ex: 192.168.1.0 0.0.0.255),"
        echo "uma por linha. Digite 'fim' para terminar:"
        networks=()
        while true; do
            read -p "Rede/Wildcard: " net
            [[ "$net" == "fim" ]] && break
            networks+=("$net")
        done
        generate_ospf_config "$process_id" "${networks[@]}"
        ;;
    5)
        echo ""
        echo "! ===== CONFIGURAÇÃO COMPLETA DE REDE ====="
        echo "! Topologia: 2 Routers + 2 Switches + VLANs + OSPF"
        echo ""
        
        # Router 1
        generate_router_config "Router1" "GigabitEthernet0/0" "192.168.1.1" "255.255.255.0"
        echo ""
        generate_router_config "Router1" "GigabitEthernet0/1" "10.0.0.1" "255.255.255.252"
        echo ""
        
        # Router 2
        generate_router_config "Router2" "GigabitEthernet0/0" "192.168.2.1" "255.255.255.0"
        echo ""
        generate_router_config "Router2" "GigabitEthernet0/1" "10.0.0.2" "255.255.255.252"
        echo ""
        
        # Switch 1
        generate_switch_config "Switch1" "10" "Vendas"
        echo ""
        
        # Switch 2
        generate_switch_config "Switch2" "20" "TI"
        echo ""
        
        # OSPF nos routers
        echo "! === Configurar OSPF no Router1 ==="
        generate_ospf_config "1" "192.168.1.0 0.0.0.255" "10.0.0.0 0.0.0.3"
        echo ""
        
        echo "! === Configurar OSPF no Router2 ==="
        generate_ospf_config "1" "192.168.2.0 0.0.0.255" "10.0.0.0 0.0.0.3"
        ;;
    *)
        echo "Opção inválida!"
        exit 1
        ;;
esac

echo ""
echo "=== Configuração gerada com sucesso! ==="
echo "Copie os comandos acima e cole no CLI dos dispositivos do Packet Tracer"