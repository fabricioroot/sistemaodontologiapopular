// Script usado para controlar/validar dados de paginas relacionadas a grupos de acesso
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Funcao que verifica se o parametro campo estah vazio e exibe alert caso verdadeiro
// Funcao usada na pagina consultarGrupoAcesso
function validarPesquisar(nome) {
    // Linha abaixo acrescentada para evitar alert e poder buscar todos...
    return true;
    if (trim(nome.value) == '') {
        alert('Selecione um grupo de acesso para ser pesquisado!');
        return false;
    }
    else {
        return true;
    }
}

// Funcao usada para manipular tecla <<enter>> no formulario de consulta
function consultarComEnter(event) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if (keyCode == 13)
        return document.formGrupoAcesso.submit();
    else
        return event;
}