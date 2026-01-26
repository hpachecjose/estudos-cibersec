// Lista de tarefas vazia: cada tarefa é um objeto com id, título e status
let tarefas = [];

function mostrar_menu() {
    console.log("\n=== Gerenciador de Tarefas ===");
    console.log("1. Criar tarefa");
    console.log("2. Listar tarefas");
    console.log("3. Concluir tarefa");
    console.log("4. Remover tarefa");
    console.log("5. Sair");
}

function listar_tarefas() {
    if (tarefas.length === 0) {
        console.log("Nenhuma tarefa cadastrada.");
        return;
    }
    console.log("\nLista de tarefas:");
    for (let t of tarefas) {
        let status = t.concluida ? "✓ Concluída" : "○ Pendente";
        console.log(`ID: ${t.id} - ${t.titulo} (${status})`);
    }
}

function criar_tarefa() {
    const readline = require('readline-sync');
    let titulo = prompt("Digite o título da tarefa: ") || "";
    titulo = titulo.trim();

    if (titulo) {
        let nova_tarefa = {
            id: tarefas.length + 1,
            titulo: titulo,
            concluida: false
        };
        tarefas.push(nova_tarefa);
        console.log(`Tarefa '${titulo}' criada com ID ${nova_tarefa.id}.`);
    } else {
        console.log("Título inválido.");
    }
}

function concluir_tarefa() {
    listar_tarefas();

    try {
        let id_tarefa = parseInt(prompt("Digite o ID da tarefa a concluir: ") || "0");
        for (let t of tarefas) {
            if (t.id === id_tarefa) {
                t.concluida = true;
                console.log(`Tarefa ID ${id_tarefa} marcada como concluída.`);
                return;
            }
        }
        console.log("ID inválido.");
    } catch (e) {
        console.log("ID deve ser um número.");
    }
}

function remover_tarefa() {
    listar_tarefas();

    try {
        let id_tarefa = parseInt(prompt("Digite o ID da tarefa a remover: ") || "0");
        tarefas = tarefas.filter(t => t.id !== id_tarefa);
        console.log(`Tarefa ID ${id_tarefa} removida.`);
    } catch (e) {
        console.log("ID deve ser um número.");
    }
}

// Loop principal
while (true) {
    mostrar_menu();
    let opcao = prompt("Escolha uma opção: ") || "";
    opcao = opcao.trim();

    if (opcao === '1') {
        criar_tarefa();
    } else if (opcao === '2') {
        listar_tarefas();
    } else if (opcao === '3') {
        concluir_tarefa();
    } else if (opcao === '4') {
        remover_tarefa();
    } else if (opcao === '5') {
        console.log("Programa encerrado.");
        break;
    } else {
        console.log("Opção inválida. Tente novamente.");
    }
}
