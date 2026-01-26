# Lista de tarefas vazia: cada tarefa é um dict com id, título e status
tarefas = []

def mostrar_menu():
    print("\n=== Gerenciador de Tarefas ===")
    print("1. Criar tarefa")
    print("2. Listar tarefas")
    print("3. Concluir tarefa")
    print("4. Remover tarefa")
    print("5. Sair")

def listar_tarefas():
    if not tarefas:
        print("Nenhuma tarefa cadastrada.")
        return
    print("\nLista de tarefas:")
    for t in tarefas:
        status = "✓ Concluída" if t['concluida'] else "○ Pendente"
        print(f"ID: {t['id']} - {t['titulo']} ({status})")

def criar_tarefa():
    titulo = input("Digite o título da tarefa: ").strip()
    if titulo:
        nova_tarefa = {
            'id': len(tarefas) + 1,
            'titulo': titulo,
            'concluida': False
        }
        tarefas.append(nova_tarefa)
        print(f"Tarefa '{titulo}' criada com ID {nova_tarefa['id']}.")
    else:
        print("Título inválido.")

def concluir_tarefa():
    listar_tarefas()
    try:
        id_tarefa = int(input("Digite o ID da tarefa a concluir: "))
        for t in tarefas:
            if t['id'] == id_tarefa:
                t['concluida'] = True
                print(f"Tarefa ID {id_tarefa} marcada como concluída.")
                return
        print("ID inválido.")
    except ValueError:
        print("ID deve ser um número.")

def remover_tarefa():
    listar_tarefas()
    try:
        id_tarefa = int(input("Digite o ID da tarefa a remover: "))
        global tarefas
        tarefas = [t for t in tarefas if t['id'] != id_tarefa]
        print(f"Tarefa ID {id_tarefa} removida.")
    except ValueError:
        print("ID deve ser um número.")

# Loop principal
while True:
    mostrar_menu()
    opcao = input("Escolha uma opção: ").strip()
    
    if opcao == '1':
        criar_tarefa()
    elif opcao == '2':
        listar_tareas()
    elif opcao == '3':
        concluir_tarefa()
    elif opcao == '4':
        remover_tarefa()
    elif opcao == '5':
        print("Programa encerrado.")
        break
    else:
        print("Opção inválida. Tente novamente.")[web:13][web:15]
