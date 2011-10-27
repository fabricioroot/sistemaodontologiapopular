// Script usado para controlar/validar dados de paginas relacionadas a atendimentos de tratamentos
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Funcao usada para calcular o valor e o valorMinimo do procedimento
function calcularValor(face){
    celula = document.getElementById(face);
    var valor;
    var valorProcedimento = parseFloat(trim(document.formIncluirProcedimento.valorProcedimento.value.replace(",", ".")));
    var valorMinimo = parseFloat('0');
    var valorMinimoProcedimento = parseFloat(trim(document.formIncluirProcedimento.valorMinimoProcedimento.value.replace(",", ".")));

    // Marretinha
    var count = 0;
    if (document.formIncluirProcedimento.checkFaceSuperior.checked) count++;
    if (document.formIncluirProcedimento.checkFaceEsquerda.checked) count++;
    if (document.formIncluirProcedimento.checkFaceMeio.checked) count++;
    if (document.formIncluirProcedimento.checkFaceDireita.checked) count++;
    if (document.formIncluirProcedimento.checkFaceInferior.checked) count++;
    if (document.formIncluirProcedimento.checkRaiz.checked) count++;
    if (count <= 1) {
        valor = valorProcedimento;
        valorMinimo = valorMinimoProcedimento;
    }
    else {
        valor = parseFloat(trim(document.formIncluirProcedimento.valor.value.replace(",", ".")));
        valorMinimo = parseFloat(trim(document.formIncluirProcedimento.valorMinimo.value.replace(",", ".")));

        if (face == "faceSuperior" && document.formIncluirProcedimento.checkFaceSuperior.checked) {
            valor = valor + valorProcedimento;
            valorMinimo = valorMinimo + valorMinimoProcedimento;
        }
        else {
            if (face == "faceSuperior" && !document.formIncluirProcedimento.checkFaceSuperior.checked) {
                valor = valor - valorProcedimento;
                valorMinimo = valorMinimo - valorMinimoProcedimento;
            }
        }

        if (face == "faceEsquerda" && document.formIncluirProcedimento.checkFaceEsquerda.checked) {
            valor = valor + valorProcedimento;
            valorMinimo = valorMinimo + valorMinimoProcedimento;
        }
        else {
            if (face == "faceEsquerda" && !document.formIncluirProcedimento.checkFaceEsquerda.checked) {
                valor = valor - valorProcedimento;
                valorMinimo = valorMinimo - valorMinimoProcedimento;
            }
        }

        if (face == "faceMeio" && document.formIncluirProcedimento.checkFaceMeio.checked) {
            valor = valor + valorProcedimento;
            valorMinimo = valorMinimo + valorMinimoProcedimento;
        }
        else {
            if (face == "faceMeio" && !document.formIncluirProcedimento.checkFaceMeio.checked) {
                valor = valor - valorProcedimento;
                valorMinimo = valorMinimo - valorMinimoProcedimento;
            }
        }

        if (face == "faceDireita" && document.formIncluirProcedimento.checkFaceDireita.checked) {
            valor = valor + valorProcedimento;
            valorMinimo = valorMinimo + valorMinimoProcedimento;
        }
        else {
            if (face == "faceDireita" && !document.formIncluirProcedimento.checkFaceDireita.checked) {
                valor = valor - valorProcedimento;
                valorMinimo = valorMinimo - valorMinimoProcedimento;
            }
        }

        if (face == "faceInferior" && document.formIncluirProcedimento.checkFaceInferior.checked) {
            valor = valor + valorProcedimento;
            valorMinimo = valorMinimo + valorMinimoProcedimento;
        }
        else {
            if (face == "faceInferior" && !document.formIncluirProcedimento.checkFaceInferior.checked) {
                valor = valor - valorProcedimento;
                valorMinimo = valorMinimo - valorMinimoProcedimento;
            }
        }

        if (face == "raiz" && document.formIncluirProcedimento.checkRaiz.checked) {
            valor = valor + valorProcedimento;
            valorMinimo = valorMinimo + valorMinimoProcedimento;
        }
        else {
            if (face == "raiz" && !document.formIncluirProcedimento.checkRaiz.checked) {
                valor = valor - valorProcedimento;
                valorMinimo = valorMinimo - valorMinimoProcedimento;
            }
        }
    }
    document.formIncluirProcedimento.valor.value = valor.toFixed(2).toString().replace(".", ",");
    document.formIncluirProcedimento.valorCobrado.value = valor.toFixed(2);
    document.formIncluirProcedimento.valorMinimo.value = valorMinimo.toFixed(2).toString().replace(".", ",");
}

// Funcao usada para colorir o fundo das celulas da tabela que representa um dente
// e marcar valores
function colorirFundo(face){
    if ((trim(document.formIncluirProcedimento.procedimentoId.value) != "") && (document.formIncluirProcedimento.procedimentoId.value != null) && (document.formIncluirProcedimento.procedimentoId.value != 'null')) {
        calcularValor(face);
    }

    celula = document.getElementById(face);
    if (face == "faceSuperior" && document.formIncluirProcedimento.checkFaceSuperior.checked) {
        document.formIncluirProcedimento.faceSuperior.style.backgroundColor = "#FFDD00";
        celula.style.background="url(../../imagens/faces/c-on_ed-off.gif)";
        if (document.formIncluirProcedimento.checkFaceEsquerda.checked) {
            celula.style.background="url(../../imagens/faces/ce-on_d-off.gif)";
        }
        else {
            if (document.formIncluirProcedimento.checkFaceDireita.checked) {
                celula.style.background="url(../../imagens/faces/c-on_e-off_d-on.gif)";
            }
        }
        if (document.formIncluirProcedimento.checkFaceDireita.checked && document.formIncluirProcedimento.checkFaceEsquerda.checked) {
            celula.style.background="url(../../imagens/faces/ced-on.gif)";
        }
    }
    else {
        if (face == "faceSuperior" && !document.formIncluirProcedimento.checkFaceSuperior.checked) {
            document.formIncluirProcedimento.faceSuperior.style.backgroundColor = "";
            celula.style.background="url(../../imagens/faces/ced-off.gif)";
            if (document.formIncluirProcedimento.checkFaceEsquerda.checked) {
                celula.style.background="url(../../imagens/faces/c-off_e-on_d-off.gif)";
            }
            else {
                if (document.formIncluirProcedimento.checkFaceDireita.checked) {
                    celula.style.background="url(../../imagens/faces/ce-off_d-on.gif)";
                }
            }
            if (document.formIncluirProcedimento.checkFaceDireita.checked && document.formIncluirProcedimento.checkFaceEsquerda.checked) {
                celula.style.background="url(../../imagens/faces/c-off_ed-on.gif)";
            }
        }
    }

    if (face == "faceEsquerda" && document.formIncluirProcedimento.checkFaceEsquerda.checked) {
        document.formIncluirProcedimento.faceEsquerda.style.backgroundColor = "#FFDD00";
        celula.style.background="url(../../imagens/faces/e-on.gif)";
        document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-off_e-on_d-off.gif)";
        document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-off_e-on_d-off.gif)";
        if (document.formIncluirProcedimento.checkFaceSuperior.checked) {
            document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ce-on_d-off.gif)";
            document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-off_e-on_d-off.gif)";
        }
        else {
            if (document.formIncluirProcedimento.checkFaceInferior.checked) {
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/be-on_d-off.gif)";
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-off_e-on_d-off.gif)";
            }
        }
        if (document.formIncluirProcedimento.checkFaceDireita.checked) {
            document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-off_ed-on.gif)";
            document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-off_ed-on.gif)";
            if (document.formIncluirProcedimento.checkFaceSuperior.checked) {
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ced-on.gif)";
            }
            if (document.formIncluirProcedimento.checkFaceInferior.checked) {
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/bed-on.gif)";
            }
        }
        if (document.formIncluirProcedimento.checkFaceSuperior.checked && document.formIncluirProcedimento.checkFaceInferior.checked) {
            document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ce-on_d-off.gif)";
            document.getElementById("faceInferior").style.background="url(../../imagens/faces/be-on_d-off.gif)";
            if (document.formIncluirProcedimento.checkFaceDireita.checked) {
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ced-on.gif)";
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/bed-on.gif)";
            }
        }
    }
    else {
        if (face == "faceEsquerda" && !document.formIncluirProcedimento.checkFaceEsquerda.checked) {
            document.formIncluirProcedimento.faceEsquerda.style.backgroundColor = "";
            celula.style.background="url(../../imagens/faces/e-off.gif)";
            document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ced-off.gif)";
            document.getElementById("faceInferior").style.background="url(../../imagens/faces/bed-off.gif)";
            if (document.formIncluirProcedimento.checkFaceSuperior.checked) {
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-on_ed-off.gif)";
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/bed-off.gif)";
            }
            else {
                if (document.formIncluirProcedimento.checkFaceInferior.checked) {
                    document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-on_ed-off.gif)";
                    document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ced-off.gif)";
                    if (document.formIncluirProcedimento.checkFaceSuperior.checked) {
                        document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-on_ed-off.gif)";
                    }
                }
            }
            if (document.formIncluirProcedimento.checkFaceDireita.checked) {
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/be-off_d-on.gif)";
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ce-off_d-on.gif)";
                if (document.formIncluirProcedimento.checkFaceSuperior.checked) {
                    document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-on_e-off_d-on.gif)";
                }
                if (document.formIncluirProcedimento.checkFaceInferior.checked) {
                    document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-on_e-off_d-on.gif)";
                }
            }
            if (document.formIncluirProcedimento.checkFaceSuperior.checked && document.formIncluirProcedimento.checkFaceInferior.checked) {
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-on_ed-off.gif)";
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-on_ed-off.gif)";
                if (document.formIncluirProcedimento.checkFaceDireita.checked) {
                    document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-on_e-off_d-on.gif)";
                    document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-on_e-off_d-on.gif)";
                }
            }
        }
    }

    if (face == "faceMeio" && document.formIncluirProcedimento.checkFaceMeio.checked) {
        document.formIncluirProcedimento.faceMeio.style.backgroundColor = "#FFDD00";
        celula.style.backgroundColor="#FFCC00";
    }
    else {
        if (face == "faceMeio" && !document.formIncluirProcedimento.checkFaceMeio.checked) {
            document.formIncluirProcedimento.faceMeio.style.backgroundColor = "";
            celula.style.backgroundColor="";
        }
    }

    if (face == "faceDireita" && document.formIncluirProcedimento.checkFaceDireita.checked) {
        document.formIncluirProcedimento.faceDireita.style.backgroundColor = "#FFDD00";
        celula.style.background="url(../../imagens/faces/d-on.gif)";
        document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ce-off_d-on.gif)";
        document.getElementById("faceInferior").style.background="url(../../imagens/faces/be-off_d-on.gif)";
        if (document.formIncluirProcedimento.checkFaceSuperior.checked) {
            document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-on_e-off_d-on.gif)";
            document.getElementById("faceInferior").style.background="url(../../imagens/faces/be-off_d-on.gif)";
        }
        else {
            if (document.formIncluirProcedimento.checkFaceInferior.checked) {
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-on_e-off_d-on.gif)";
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ce-off_d-on.gif)";
            }
        }
        if (document.formIncluirProcedimento.checkFaceEsquerda.checked) {
            document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-off_ed-on.gif)";
            document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-off_ed-on.gif)";
            if (document.formIncluirProcedimento.checkFaceSuperior.checked) {
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ced-on.gif)";
            }
            if (document.formIncluirProcedimento.checkFaceInferior.checked) {
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/bed-on.gif)";
            }
        }
        if (document.formIncluirProcedimento.checkFaceSuperior.checked && document.formIncluirProcedimento.checkFaceInferior.checked) {
            document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-on_e-off_d-on.gif)";
            document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-on_e-off_d-on.gif)";
            if (document.formIncluirProcedimento.checkFaceEsquerda.checked) {
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ced-on.gif)";
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/bed-on.gif)";
            }
        }
    }
    else {
        if (face == "faceDireita" && !document.formIncluirProcedimento.checkFaceDireita.checked) {
            document.formIncluirProcedimento.faceDireita.style.backgroundColor = "";
            celula.style.background="url(../../imagens/faces/d-off.gif)";
            document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ced-off.gif)";
            document.getElementById("faceInferior").style.background="url(../../imagens/faces/bed-off.gif)";
            if (document.formIncluirProcedimento.checkFaceSuperior.checked) {
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-on_ed-off.gif)";
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/bed-off.gif)";
            }
            else {
                if (document.formIncluirProcedimento.checkFaceInferior.checked) {
                    document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-on_ed-off.gif)";
                    document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ced-off.gif)";
                    if (document.formIncluirProcedimento.checkFaceSuperior.checked) {
                        document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-on_ed-off.gif)";
                    }
                }
            }
            if (document.formIncluirProcedimento.checkFaceEsquerda.checked) {
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-off_e-on_d-off.gif)";
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-off_e-on_d-off.gif)";
                if (document.formIncluirProcedimento.checkFaceSuperior.checked) {
                    document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ce-on_d-off.gif)";
                }
                if (document.formIncluirProcedimento.checkFaceInferior.checked) {
                    document.getElementById("faceInferior").style.background="url(../../imagens/faces/be-on_d-off.gif)";
                }
            }
            if (document.formIncluirProcedimento.checkFaceSuperior.checked && document.formIncluirProcedimento.checkFaceInferior.checked) {
                document.getElementById("faceSuperior").style.background="url(../../imagens/faces/c-on_ed-off.gif)";
                document.getElementById("faceInferior").style.background="url(../../imagens/faces/b-on_ed-off.gif)";
                if (document.formIncluirProcedimento.checkFaceEsquerda.checked) {
                    document.getElementById("faceSuperior").style.background="url(../../imagens/faces/ce-on_d-off.gif)";
                    document.getElementById("faceInferior").style.background="url(../../imagens/faces/be-on_d-off.gif)";
                }
            }
        }
    }

    if (face == "faceInferior" && document.formIncluirProcedimento.checkFaceInferior.checked) {
        document.formIncluirProcedimento.faceInferior.style.backgroundColor = "#FFDD00";
        celula.style.background="url(../../imagens/faces/b-on_ed-off.gif)";
        if (document.formIncluirProcedimento.checkFaceEsquerda.checked) {
            celula.style.background="url(../../imagens/faces/be-on_d-off.gif)";
        }
        else {
            if (document.formIncluirProcedimento.checkFaceDireita.checked) {
                celula.style.background="url(../../imagens/faces/b-on_e-off_d-on.gif)";
            }
        }
        if (document.formIncluirProcedimento.checkFaceDireita.checked && document.formIncluirProcedimento.checkFaceEsquerda.checked) {
            celula.style.background="url(../../imagens/faces/bed-on.gif)";
        }
    }
    else {
        if (face == "faceInferior" && !document.formIncluirProcedimento.checkFaceInferior.checked) {
            document.formIncluirProcedimento.faceInferior.style.backgroundColor = "";
            celula.style.background="url(../../imagens/faces/bed-off.gif)";
            if (document.formIncluirProcedimento.checkFaceEsquerda.checked) {
                celula.style.background="url(../../imagens/faces/b-off_e-on_d-off.gif)";
            }
            else {
                if (document.formIncluirProcedimento.checkFaceDireita.checked) {
                    celula.style.background="url(../../imagens/faces/be-off_d-on.gif)";
                }
            }
            if (document.formIncluirProcedimento.checkFaceDireita.checked && document.formIncluirProcedimento.checkFaceEsquerda.checked) {
                celula.style.background="url(../../imagens/faces/b-off_ed-on.gif)";
            }
        }
    }

    if (face == "raiz" && document.formIncluirProcedimento.checkRaiz.checked) {
        document.formIncluirProcedimento.raiz.style.backgroundColor = "#FFDD00";
        celula.style.background="url(../../imagens/faces/r-on.gif)";
    }
    else {
        if (face == "raiz" && !document.formIncluirProcedimento.checkRaiz.checked) {
            document.formIncluirProcedimento.raiz.style.backgroundColor = "";
            celula.style.background="url(../../imagens/faces/r-off.gif)";
        }
    }
}

// Funcao usada para descolorir os fundos das celulas da tabela que representa um dente
// Alterações para descolorir as imagens
function descolorirFundos(){
    celula = document.getElementById("faceSuperior");
    celula.style.background="url(../../imagens/faces/ced-off.gif)";
    document.formIncluirProcedimento.faceSuperior.style.backgroundColor = "#FFFFFF";
    celula2 = document.getElementById("faceEsquerda");
    celula2.style.background="url(../../imagens/faces/e-off.gif)";
    document.formIncluirProcedimento.faceEsquerda.style.backgroundColor = "#FFFFFF";
    celula3 = document.getElementById("faceMeio");
    celula3.style.backgroundColor = "#FFFFFF";
    document.formIncluirProcedimento.faceMeio.style.backgroundColor = "#FFFFFF";
    celula4 = document.getElementById("faceDireita");
    celula4.style.background="url(../../imagens/faces/d-off.gif)";
    document.formIncluirProcedimento.faceDireita.style.backgroundColor = "#FFFFFF";
    celula5 = document.getElementById("faceInferior");
    celula5.style.background="url(../../imagens/faces/bed-off.gif)";
    document.formIncluirProcedimento.faceInferior.style.backgroundColor = "#FFFFFF";
    celula6 = document.getElementById("raiz");
    celula6.style.background="url(../../imagens/faces/r-off.gif)"
    document.formIncluirProcedimento.raiz.style.backgroundColor = "#FFFFFF";
}

// Funcao usada para desabilitar os checkboxes que representam as faces de um dente
function desabilitarCheckBoxesDente() {
    document.getElementById('checkRaiz').disabled = true;
    document.getElementById('checkFaceSuperior').disabled = true;
    document.getElementById('checkFaceEsquerda').disabled = true;
    document.getElementById('checkFaceMeio').disabled = true;
    document.getElementById('checkFaceDireita').disabled = true;
    document.getElementById('checkFaceInferior').disabled = true;
}

// Funcao usada para habilitar os checkboxes que representam as faces de um dente
function habilitarCheckBoxesDente() {
    document.getElementById('checkRaiz').disabled = false;
    document.getElementById('checkFaceSuperior').disabled = false;
    document.getElementById('checkFaceEsquerda').disabled = false;
    document.getElementById('checkFaceMeio').disabled = false;
    document.getElementById('checkFaceDireita').disabled = false;
    document.getElementById('checkFaceInferior').disabled = false;
}

// Funcao usada para validar os dados obrigatorios quando incluirProcedimento.jsp
function validarDados() {
    var mensagem = "Preencha corretamente os seguintes campos:";

    if (trim(document.formIncluirProcedimento.procedimentoId.value) == "") {
        mensagem = mensagem + "\n- Procedimento";
    }

    if (trim(document.formIncluirProcedimento.valorCobrado.value) == "") {
        mensagem = mensagem + "\n- Valor Cobrado";
    }
    else {
        document.formIncluirProcedimento.valorCobrado.value = document.formIncluirProcedimento.valorCobrado.value.replace(",", ".");
    }

    // Validar valor minimo
    if (parseFloat(trim(document.formIncluirProcedimento.valorCobrado.value.toString())) < parseFloat(trim(document.formIncluirProcedimento.valorMinimo.value.toString()))) {
        alert("Valor cobrado invalido! O valor minimo para este procedimento e R$" + document.formIncluirProcedimento.valorMinimo.value);
        return false;
    }

    // Remove os acentos do campo observacao
    if (trim(document.formIncluirProcedimento.observacao.value) != "") {
        // Linha abaixo comentada para manter acentos
        //document.formIncluirProcedimento.observacao.value = retirarAcentos(trim(document.formIncluirProcedimento.observacao.value));
        document.formIncluirProcedimento.observacao.value = trim(document.formIncluirProcedimento.observacao.value);
    }

    // Habilita check boxes
    this.habilitarCheckBoxesDente();

    // Verifica se nao ha pelo menos uma parte do dente marcada
    if (!document.formIncluirProcedimento.checkFaceSuperior.checked && !document.formIncluirProcedimento.checkFaceEsquerda.checked
        && !document.formIncluirProcedimento.checkFaceMeio.checked && !document.formIncluirProcedimento.checkFaceDireita.checked
        && !document.formIncluirProcedimento.checkFaceInferior.checked && !document.formIncluirProcedimento.checkRaiz.checked) {
        mensagem = mensagem + "\n - Marque pelo menos uma parte do dente!";
    }

    if (mensagem == "Preencha corretamente os seguintes campos:") {
        return true;
    }
    else {
        alert(mensagem);
        return false;
    }
}

// Funcao usada para validar os dados obrigatorios quando incluirProcedimentoBoca.jsp
function validarDadosBoca() {
    var mensagem = "Preencha corretamente os seguintes campos:";

    if (trim(document.formIncluirProcedimento.procedimentoId.value) == "") {
        mensagem = mensagem + "\n- Procedimento";
    }

    if (trim(document.formIncluirProcedimento.valorCobrado.value) == "") {
        mensagem = mensagem + "\n- Valor Cobrado";
    }
    else {
        document.formIncluirProcedimento.valorCobrado.value = document.formIncluirProcedimento.valorCobrado.value.replace(",", ".");
    }

    // Remove os acentos do campo observacao
    if (trim(document.formIncluirProcedimento.observacao.value) != "") {
        // Linha abaixo comentada para manter acentos
        //document.formIncluirProcedimento.observacao.value = retirarAcentos(trim(document.formIncluirProcedimento.observacao.value));
        document.formIncluirProcedimento.observacao.value = trim(document.formIncluirProcedimento.observacao.value);
    }

    if (mensagem == "Preencha corretamente os seguintes campos:") {
        return true;
    }
    else {
        alert(mensagem);
        return false;
    }
}

// Funcao para exibir alert com opcoes de OK ou Cancelar confirmando opcao do usuario
function confirmarAcao(acao) {
    if(confirm("Tem certeza que deseja " + acao + " este atendimento?")) {
        return true;
    }
    else {
        return false;
    }
}

// Funcao usada para manipular tecla <<enter>> no formulario de consulta
function enter(event) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if (keyCode == 13) {
        if (document.formIncluirProcedimento.tipoProcedimento.value != 'BC') {
            if (validarDados()) {
                return document.formIncluirProcedimento.submit();
            }
            else {
                return false;
            }
        }
        else {
            if (validarDadosBoca()) {
                return document.formIncluirProcedimento.submit();
            }
            else {
                return false;
            }
        }
    }
    else {
        return event;
    }
}