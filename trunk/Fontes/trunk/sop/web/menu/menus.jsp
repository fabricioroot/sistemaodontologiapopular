<%-- 
    Document   : menu
    Created on : 08/01/2010, 15:21:50
    Author     : Fabricio P. Reis
--%>
<%@ page import="java.util.Set" %>
<%@ page import="web.login.ValidaGrupos" %>
<%@ page import="annotations.Funcionario" %>
<%@ page import="annotations.GrupoAcesso" %>
<script type="text/javascript" language="javascript">
    <%@ include file="../menu/menu_var.js"%>
    <%
        Funcionario funcionarioLogado = (Funcionario)request.getSession(false).getAttribute("funcionarioLogado");
        Set<GrupoAcesso> gruposDeAcesso = funcionarioLogado.getGrupoAcessoSet();
        boolean administrador = ValidaGrupos.validaGrupo(gruposDeAcesso, "Administrador");
        boolean administradorTI = ValidaGrupos.validaGrupo(gruposDeAcesso, "Administrador-TI");
        boolean caixa = ValidaGrupos.validaGrupo(gruposDeAcesso, "Caixa");
        boolean financeiro = ValidaGrupos.validaGrupo(gruposDeAcesso, "Financeiro");
        boolean dentistaOrcamento = ValidaGrupos.validaGrupo(gruposDeAcesso, "Dentista-Orcamento");
        boolean dentistaTratamento = ValidaGrupos.validaGrupo(gruposDeAcesso, "Dentista-Tratamento");
        boolean relatorio = ValidaGrupos.validaGrupo(gruposDeAcesso, "Relatorio");
        boolean secretaria = ValidaGrupos.validaGrupo(gruposDeAcesso, "Secretaria");
        boolean entrou = false;
        int i_i = 1;

        if (administradorTI || administrador || secretaria || dentistaOrcamento) {
            if (entrou) {
                i_i++;
            }
            entrou = true;
    %>
        var Menu<%=i_i%> = new Array("Orçamentos","","",2,alturaMenu,larguraMenu);
        var Menu<%=i_i%>_1 = new Array("Em Atendimento","/sop/app/filaAtendimentoOrcamento/consultarFilaAtendimentoOrcamentoEmAtendimento.do","",0,altura,largura);
        var Menu<%=i_i%>_2 = new Array("Fila de Espera","/sop/app/filaAtendimentoOrcamento/consultarFilaAtendimentoOrcamento.do","",0,altura,largura);
    <%
        }
        if (administradorTI || administrador || secretaria || dentistaTratamento) {
            if (entrou) {
                i_i++;
            }
            entrou = true;
    %>
        var Menu<%=i_i%> = new Array("Tratamentos","","",2,alturaMenu,larguraMenu);
        var Menu<%=i_i%>_1 = new Array("Em Atendimento","/sop/app/filaAtendimentoTratamento/consultarFilaAtendimentoTratamentoEmAtendimento.do","",0,altura,largura);
        var Menu<%=i_i%>_2 = new Array("Fila de Espera","/sop/app/filaAtendimentoTratamento/consultarFilaAtendimentoTratamento.do","",0,altura,largura);
    <%
        }
        if (administradorTI || administrador || caixa) {
            if (entrou) {
                i_i++;
            }
            entrou = true;
    %>
        var Menu<%=i_i%> = new Array("Caixa","","",3,alturaMenu,larguraMenu);
        var Menu<%=i_i%>_1 = new Array("Devolver Dinheiro","/sop/app/caixa/registrarDevolucaoDinheiro.do","",0,altura,largura);
        var Menu<%=i_i%>_2 = new Array("Liberação de Procedimentos","/sop/app/caixa/liberacaoProcedimentos.do","",0,altura,largura);
        var Menu<%=i_i%>_3 = new Array("Registrar Pagamentos","/sop/app/caixa/registrarPagamentos.do","",0,altura,largura);
    <%
        }
        if (administradorTI || administrador || financeiro) {
            if (entrou) {
                i_i++;
            }
            entrou = true;
    %>
        var Menu<%=i_i%> = new Array("Financeiro","","",3,alturaMenu,larguraMenu);
        var Menu<%=i_i%>_1 = new Array("Cheques Bancários","","",2,altura,largura);
        var Menu<%=i_i%>_1_1 = new Array("Consultar","/sop/app/chequeBancario/consultarChequeBancario.do","",0,altura,largura);
        var Menu<%=i_i%>_1_2 = new Array("Editar","/sop/app/chequeBancario/editarChequeBancario.do","",0,altura,largura);
        var Menu<%=i_i%>_2 = new Array("Comprovantes de Cartão","","",2,altura,largura);
        var Menu<%=i_i%>_2_1 = new Array("Consultar","/sop/app/comprovantePagamentoCartao/consultarComprovantePagamentoCartao.do","",0,altura,largura);
        var Menu<%=i_i%>_2_2 = new Array("Editar","/sop/app/comprovantePagamentoCartao/editarComprovantePagamentoCartao.do","",0,altura,largura);
        var Menu<%=i_i%>_3 = new Array("Formas de Pagamento","","",3,altura,largura);
        var Menu<%=i_i%>_3_1 = new Array("Cadastrar","/sop/app/formaPagamento/cadastrarFormaPagamento.do","",0,altura,largura);
        var Menu<%=i_i%>_3_2 = new Array("Consultar","/sop/app/formaPagamento/consultarFormaPagamento.do","",0,altura,largura);
        var Menu<%=i_i%>_3_3 = new Array("Editar","/sop/app/formaPagamento/editarFormaPagamento.do","",0,altura,largura);
    <%
        }
        if (administradorTI || administrador) {
            if (entrou) {
                i_i++;
            }
            entrou = true;
    %>
        var Menu<%=i_i%> = new Array("Funcionários","","",4,alturaMenu,larguraMenu);
        var Menu<%=i_i%>_1 = new Array("Cadastrar","/sop/app/funcionario/cadastrarFuncionario.do","",0,altura,largura);
        var Menu<%=i_i%>_2 = new Array("Consultar","/sop/app/funcionario/consultarFuncionario.do","",0,altura,largura);
        var Menu<%=i_i%>_3 = new Array("Editar","/sop/app/funcionario/editarFuncionario.do","",0,altura,largura);
        var Menu<%=i_i%>_4 = new Array("Grupos de Acesso","/sop/app/grupoAcesso/consultarGrupoAcesso.do","",0,altura,largura);
    <%
        }
        if (administradorTI || administrador || secretaria) {
            if (entrou) {
                i_i++;
            }
            entrou = true;
    %>
        var Menu<%=i_i%> = new Array("Pacientes","","",3,alturaMenu,larguraMenu);
        var Menu<%=i_i%>_1 = new Array("Cadastrar","/sop/app/paciente/cadastrarPaciente.do","",0,altura,largura);
        var Menu<%=i_i%>_2 = new Array("Consultar","/sop/app/paciente/consultarPaciente.do","",0,altura,largura);
        var Menu<%=i_i%>_3 = new Array("Editar","/sop/app/paciente/editarPaciente.do","",0,altura,largura);
    <%
        }
        if (administradorTI || administrador) {
            if (entrou) {
                i_i++;
            }
            entrou = true;
    %>
        var Menu<%=i_i%> = new Array("Procedimentos","","",3,alturaMenu,larguraMenu);
        var Menu<%=i_i%>_1 = new Array("Cadastrar","/sop/app/procedimento/cadastrarProcedimento.do","",0,altura,largura);
        var Menu<%=i_i%>_2 = new Array("Consultar","/sop/app/procedimento/consultarProcedimento.do","",0,altura,largura);
        var Menu<%=i_i%>_3 = new Array("Editar","/sop/app/procedimento/editarProcedimento.do","",0,altura,largura);
    <%
        }
        if (administradorTI || administrador || relatorio) {
            if (entrou) {
                i_i++;
            }
            entrou = true;
    %>
        var Menu<%=i_i%> = new Array("Relatórios","","",0,alturaMenu,larguraMenu);
    <%--
        }
        if (administradorTI || administrador || caixa || financeiro || dentistaOrcamento || dentistaTratamento || relatorio || secretaria) {
            if (entrou) {
                i_i++;
            }
            entrou = true;
    --%>
        //var Menu<%-- =i_i --%> = new Array("Manual","/sop/app/manual/manual.do","",0,alturaMenu,larguraMenu);
    <%
        }
    %>
    var NoOffFirstLineMenus=<%=i_i%>;
    <%@ include file="../menu/menu_com.js" %>
</script>