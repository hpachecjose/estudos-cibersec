# **Autenticação e Criptografia em Redes Wi-Fi: WPA2, WPA3 e o Futuro da Segurança**

A **autenticação** e a **criptografia** são pilares essenciais da **Segurança da Informação** em redes sem fio. Protocolos como **WPA2** e **WPA3** foram desenvolvidos para garantir **confidencialidade**, **integridade** e **autenticidade** das comunicações Wi-Fi, especialmente em ambientes **corporativos**, **industriais** e **críticos**.

---

## **WPA2 (Wi-Fi Protected Access 2)**

O **WPA2** tornou-se o padrão predominante por muitos anos, substituindo o WEP e o WPA original.

### **Autenticação**
- **WPA2-PSK (Pre-Shared Key)**  
  Utiliza uma **senha compartilhada** entre todos os dispositivos.  
  🔹 Simples de implementar, porém **vulnerável a ataques de força bruta** caso a senha seja fraca.

- **WPA2-Enterprise (802.1X/EAP)**  
  Baseado em **autenticação individual** via servidor **RADIUS**.  
  🔹 Cada usuário possui credenciais próprias, oferecendo **maior controle e auditoria**.

### **Criptografia**
- **AES-CCMP** como padrão obrigatório.  
- Considerado seguro, porém vulnerabilidades como o **KRACK** expuseram falhas no processo de handshake.

---

## **WPA3 (Wi-Fi Protected Access 3)**

O **WPA3** foi projetado para corrigir limitações do WPA2 e elevar o nível de segurança.

### **Autenticação**
- **WPA3-Personal (SAE – Simultaneous Authentication of Equals)**  
  Substitui o PSK tradicional por um método baseado em **troca criptográfica segura**.  
  🔹 Resistente a **ataques de dicionário offline**.

- **WPA3-Enterprise (802.1X com criptografia reforçada)**  
  Exige **níveis mínimos mais altos de segurança criptográfica**.  
  🔹 Ideal para ambientes corporativos e governamentais.

### **Criptografia**
- **AES-GCMP** e chaves mais robustas.  
- Suporte a **OWE (Opportunistic Wireless Encryption)**, garantindo criptografia mesmo em redes abertas.

---

## **Comparação Direta entre WPA2 e WPA3**

| Característica            | WPA2                              | WPA3                                  |
|---------------------------|----------------------------------|--------------------------------------|
| Autenticação pessoal      | PSK                              | SAE                                  |
| Resistência a força bruta | Limitada                         | Alta                                 |
| Redes abertas             | Sem criptografia                 | OWE                                  |
| Criptografia              | AES-CCMP                         | AES-GCMP / chaves mais fortes        |
| Requisitos mínimos        | Mais flexíveis                   | Mais rigorosos                       |

---

## **Tendências e Novas Tecnologias em Estudo**

A evolução da **Segurança da Informação** vai além do WPA3. Pesquisas atuais exploram:

- **Criptografia pós-quântica**  
- **Autenticação baseada em identidade (Identity-Based Cryptography)**  
- **Arquiteturas Zero Trust**  
- **Protocolos criptográficos adaptativos**  
- **Wi-Fi 6/6E e Wi-Fi 7 com foco em segurança aprimorada**

Essas abordagens buscam preparar as redes para **novos vetores de ataque** e **avanços computacionais futuros**.

---

## **Referências, Plataformas e Materiais de Estudo**

### **Instituições e Padrões**
- Wi-Fi Alliance – https://www.wi-fi.org  
- NIST (National Institute of Standards and Technology) – https://www.nist.gov  
- ENISA (European Union Agency for Cybersecurity) – https://www.enisa.europa.eu  
- IEEE 802.11 Working Group – https://www.ieee802.org/11  

### **Documentação e Guias Técnicos**
- NIST SP 800-153 – Guidelines for Securing Wireless LANs  
- NIST Cryptographic Standards – https://csrc.nist.gov  
- Wi-Fi Alliance Security Whitepapers  

### **Pesquisas e Tecnologias Emergentes**
- NIST Post-Quantum Cryptography Project – https://csrc.nist.gov/projects/post-quantum-cryptography  
- OWASP Wireless Security Project – https://owasp.org  

### **Ebooks e Plataformas de Aprendizado**
- Cybrary – https://www.cybrary.it  
- TryHackMe (Wireless Security Labs) – https://tryhackme.com  
- Hack The Box – https://www.hackthebox.com  
- O’Reilly – *Wi-Fi Security*, *Network Security Essentials*

---

**Segurança em redes sem fio não é estado final, é processo contínuo.**  
Atualização constante, estudo de padrões e adoção de novas tecnologias são fundamentais para manter ambientes resilientes frente à evolução das ameaças.
