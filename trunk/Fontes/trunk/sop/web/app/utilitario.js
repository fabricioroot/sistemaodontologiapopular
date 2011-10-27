// Este arquivo contem funcoes JavaScript genericas
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Formata de forma generica os campos
function formataCampo(campo, mascara, evento) {
    var booleanoMascara;

    var digitato = evento.keyCode;
    exp = /\-|\.|\/|\(|\)| /g
    campoSoNumeros = campo.value.toString().replace( exp, "");

    var posicaoCampo = 0;
    var novoValorCampo = "";
    var tamanhoMascara = campoSoNumeros.length;

    if (digitato != 8) { // backspace
        for (i = 0; i <= tamanhoMascara; i++) {
            booleanoMascara  = ((mascara.charAt(i) == "-") || (mascara.charAt(i) == ".") || (mascara.charAt(i) == "/"))
            booleanoMascara  = booleanoMascara || ((mascara.charAt(i) == "(") || (mascara.charAt(i) == ")") || (mascara.charAt(i) == " "))
            if (booleanoMascara) {
                novoValorCampo += mascara.charAt(i);
                  tamanhoMascara++;
            }else {
                novoValorCampo += campoSoNumeros.charAt(posicaoCampo);
                posicaoCampo++;
              }
          }
        campo.value = novoValorCampo;
        return true;
    }else {
        return true;
    }
}

// Mascara para data
function mascaraData(data) {
    if (mascaraInteiro(data) == false) {
        event.returnValue = false;
    }
    return formataCampo(data, '00/00/0000', event);
}

// Valida numero inteiro com mascara
function mascaraInteiro() {
    if (event.keyCode < 48 || event.keyCode > 57) {
        event.returnValue = false;
        return false;
    }
    return true;
}

// Mascara para numero real no formato de 000.00 de acordo com a variavel tamanho
function mascaraNumeroReal(numero, quantidadeCasasDecimais, tamanho) {
    campo = eval(numero);

    separador = '.';
    if (mascaraInteiro(numero) == true) {
        if (campo.value.length <= quantidadeCasasDecimais){
                campo.value = limparZeroEsquerdaDecimal(campo.value);
                while(campo.value.length < quantidadeCasasDecimais){
                    campo.value = "0" + campo.value;
                }
                campo.value = "0" + separador + campo.value;
        }
        else if ((campo.value.length > quantidadeCasasDecimais) && (campo.value.length < tamanho)){
                 campo.value = limparZeroEsquerda(campo.value);
                 str = campo.value.substring(0, campo.value.indexOf(separador)) + campo.value.substring(campo.value.indexOf(separador) + 1);
                 campo.value = str.substring(0, str.length - quantidadeCasasDecimais) + separador + str.substring(str.length - quantidadeCasasDecimais);
        }
    }
    else{
        event.returnValue = false;
    }
}

// Mascara para CPF
function mascaraCpf(cpf) {
    if (mascaraInteiro(cpf) == false) {
        event.returnValue = false;
    }
    return formataCampo(cpf, '000.000.000-00', event);
}

// Remove caracteres 0 (zero) a esquerda
function limparZeroEsquerda(str) {
    continua = true;
    while(continua){
        if (str.charAt(0) == "0" && str.length > 1) {
            str = str.substring(1);
        }
        else{
            continua = false;
        }
    }
    return str;
}

// Remove caracteres 0 (zero) a esquerda do caracter . (ponto)
function limparZeroEsquerdaDecimal(str) {
    continua = true;
    while(continua) {
        if ((str.charAt(0) == "0" || str.charAt(0) == ".") && str.length > 1){
            str = str.substring(1);
        }
        else{
            continua = false;
        }
    }
    return str;
}

// Valida formato de numero real
function validarValorReal3D(valorCampo, referenciaCampo) {
    if (trim(valorCampo.value) != '') {
        exp = /\d{4}\.|\,\d{2}/
        exp2 = /\d{3}\.|\,\d{2}/
        exp3 = /\d{2}\.|\,\d{2}/
        exp4 = /\d{1}\.|\,\d{2}/
        exp5 = /\d{4}\.|\,\d{1}/
        exp6 = /\d{3}\.|\,\d{1}/
        exp7 = /\d{2}\.|\,\d{1}/
        exp8 = /\d{1}\.|\,\d{1}/
        exp9 = /\d{4}/
        exp10 = /\d{3}/
        exp11 = /\d{2}/
        exp12 = /\d{1}/
        if ((!exp.test(valorCampo.value)) && (!exp2.test(valorCampo.value)) && (!exp3.test(valorCampo.value))
            && (!exp4.test(valorCampo.value)) && (!exp5.test(valorCampo.value)) && (!exp6.test(valorCampo.value))
            && (!exp7.test(valorCampo.value)) && (!exp8.test(valorCampo.value)) && (!exp9.test(valorCampo.value))
            && (!exp10.test(valorCampo.value)) && (!exp11.test(valorCampo.value)) && (!exp12.test(valorCampo.value))) {
                alert('Valor Invalido!');

                campoForm = document.getElementById(referenciaCampo);
                campoForm.value = "";
        }
    }
}

// Funcao para validar valor
// Se o paramentro de entrada for soh numeros retorna true, senao retorna false
function validarCampoSoNumeros(campo, referenciaCampo) {
    if (trim(campo.value) != '') {
        exp = /[0-9]/
        if(!exp.test(trim(campo.value))) {
            alert('Valor invalido! Este campo aceita somente numeros');
            campoForm = document.getElementById(referenciaCampo);
            campoForm.value = "";
        }
    }
}

// Valida data
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> TO DO   incluir teste se data é menor que data atual
function validarData(data, referenciaCampo) {
    var aux = document.getElementById(referenciaCampo);
    if (trim(data.value) != '') {
        exp = /^((0[1-9]|[12]\d)\/(0[1-9]|1[0-2])|30\/(0[13-9]|1[0-2])|31\/(0[13578]|1[02]))\/\d{4}$/
        if(!exp.test(data.value))  {
            alert('Data Invalida!');
            aux.value = "";
        }
    }
}

// Valida CPF
function validarCpf (cpf, referenciaCampo) {
    if (trim(cpf.value) != '') {
        erro = new String;
        if (cpf.value.length == 14) {
            var cpfAux = new String;
            cpfAux.value = cpf.value.replace('.', '');
            cpfAux.value = cpfAux.value.replace('.', '');
            cpfAux.value = cpfAux.value.replace('-', '');

            if (cpfAux.value == "00000000000" ||
                cpfAux.value == "11111111111" ||
                cpfAux.value == "22222222222" ||
                cpfAux.value == "33333333333" ||
                cpfAux.value == "44444444444" ||
                cpfAux.value == "55555555555" ||
                cpfAux.value == "66666666666" ||
                cpfAux.value == "77777777777" ||
                cpfAux.value == "88888888888" ||
                cpfAux.value == "99999999999") {
                erro = "CPF invalido!"
            }

            var a = [];
            var b = new Number;
            var c = 11;

            for (i = 0; i < 11; i++){
                a[i] = cpfAux.value.charAt(i);
                if (i < 9) b += (a[i] * --c);
            }

            if ((x = b % 11) < 2) {
                a[9] = 0
            }
            else {
                a[9] = 11 - x
            }
            b = 0;
            c = 11;

            for (y = 0; y < 10; y++) b += (a[y] * c--);

            if ((x = b % 11) < 2) {
                a[10] = 0;
            } else {
                a[10] = 11 - x;
            }

            if ((cpfAux.value.charAt(9) != a[9]) || (cpfAux.value.charAt(10) != a[10])) {
                erro = "CPF invalido!";
            }
        } else {
            erro = "CPF invalido!";
        }

        if (erro.length > 0) {
            alert(erro);
            campoForm = document.getElementById(referenciaCampo);
            campoForm.value = "";
        }
    }
}

// Funcao que coloca as letras inicias de uma string em maiusculo
// A string de entrada deve estar com todas letras em minusculo para funcionar corretamente
function primeirasLetrasMaiusculas(string) {
    return (string + '').replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
}

// Funcao para retirar os acentos e cedilhas de uma string
// TO DO: a letra i craseada da pau.. Retorna a letra e
function retirarAcentos(entrada) {
    var saida = entrada;
    var rExps=[ /[\xC0-\xC4]/g, /[\xE0-\xE4]/g,
                /[\xC8-\xCB]/g, /[\xE8-\xEC]/g,
                /[\xCC-\xCF]/g, /[\xEC-\xEF]/g,
                /[\xD2-\xD6]/g, /[\xF2-\xF6]/g,
                /[\xD9-\xDC]/g, /[\xF9-\xFC]/g,
                /[\xC7-\xC7]/g, /[\xE7-\xE7]/g];
    var repChar=['A','a','E','e','I','i','O','o','U','u','C','c'];
    for(var i = 0; i < rExps.length; i++) {
        saida = saida.replace(rExps[i],repChar[i]);
    }
    return saida;
}

// Funcao 'trim'
function trim(string){
    return string.replace(/^\s+|\s+$/g,"");
}

// Funcao para colocar elemento em foco
function goFocus(elementID){
    document.getElementById(elementID).focus();
}