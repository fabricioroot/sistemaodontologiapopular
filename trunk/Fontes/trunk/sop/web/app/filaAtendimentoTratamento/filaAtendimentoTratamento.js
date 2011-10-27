// Script usado para controlar/validar dados de paginas relacionadas a fila de atendimento de tratamentos
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Funcao para exibir alert com opcoes de OK ou Cancelar confirmando opcao do usuario
function confirmarAcao(acao) {
    if(confirm("Tem certeza que deseja " + acao + "?")) {
        return true;
    }
    else {
        return false;
    }
}