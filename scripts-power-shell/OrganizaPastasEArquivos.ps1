# Para organizar pasta específica:
$SourcePath = "C:\MinhaPasta"

# Para organizar apenas tipos específicos:
$Files = Get-ChildItem -Path $SourcePath -File -Include *.pdf, *.docx