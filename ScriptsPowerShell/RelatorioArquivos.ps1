# ============================================================
#   SCRIPT: TopArquivos.ps1
#   DESCRIÇÃO: Lista os maiores arquivos do sistema operacional
#   AUTOR: Você mesmo, chefia
# ============================================================

# Quantos arquivos você quer listar?
$Quantidade = 20

# Caminho do relatório
$Relatorio = "$env:USERPROFILE\Desktop\Relatorio_Arquivos_Grandes.txt"

Write-Host "🔍 Varredura iniciada... Isso pode levar um tempo." -ForegroundColor Cyan

# Coleta dos arquivos
$Arquivos = Get-ChildItem -Path "C:\" -Recurse -File -ErrorAction SilentlyContinue |
    Sort-Object Length -Descending |
    Select-Object FullName, 
                  @{Name="Tamanho_MB";Expression={"{0:N2}" -f ($_.Length / 1MB)}}, 
                  LastWriteTime -First $Quantidade

# Geração do relatório
"================== RELATÓRIO DOS MAIORES ARQUIVOS ==================" | Out-File $Relatorio
"Localização: $env:COMPUTERNAME" | Out-File $Relatorio -Append
"Data: $(Get-Date)" | Out-File $Relatorio -Append
"Quantidade exibida: $Quantidade" | Out-File $Relatorio -Append
"===================================================================" | Out-File $Relatorio -Append
"" | Out-File $Relatorio -Append

foreach ($a in $Arquivos) {
    "Arquivo: $($a.FullName)" | Out-File $Relatorio -Append
    "Tamanho: $($a.Tamanho_MB) MB" | Out-File $Relatorio -Append
    "Modificado em: $($a.LastWriteTime)" | Out-File $Relatorio -Append
    "-------------------------------------------------------------------" | Out-File $Relatorio -Append
}

Write-Host "✅ Relatório criado com sucesso!" -ForegroundColor Green
Write-Host "📄 Caminho: $Relatorio"
