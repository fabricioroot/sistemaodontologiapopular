package web.caixa;

import annotations.ChequeBancario;
import annotations.ComprovantePagamentoCartao;
import annotations.Ficha;
import annotations.FormaPagamento;
import annotations.Funcionario;
import annotations.Pagamento;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.ChequeBancarioService;
import service.ComprovantePagamentoCartaoService;
import service.FichaService;
import service.FormaPagamentoService;
import service.PagamentoService;

/**
 *
 * @author Fabricio Reis
 */
public class FaturarPagamentoAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAIDENTIFICARFICHA = "falhaIdentificarFicha";
    private static final String FALHAIDENTIFICARFORMAPAGAMENTO = "falhaIdentificarFormaPagamento";
    private static final String FALHAIDENTIFICARUSUARIOLOGADO = "falhaIdentificarUsuarioLogado";
    private static final String FALHASALVAR = "falhaSalvar";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String FALHAVALORFINALNAOCONFERE = "falhaValorFinalNaoConfere";
    private static final String VALORMINIMONAOATINGIDO = "valorMinimoNaoAtingido";
    private static final String OBRIGATORIOSEMBRANCO = "obrigatoriosEmBranco";
    private static final String SESSAOINVALIDA = "sessaoInvalida";

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // Controle de sessao
        if (request.getSession(false).getAttribute("status") == null) {
            return mapping.findForward(SESSAOINVALIDA);
        }
        else {
            if(!(Boolean)request.getSession(false).getAttribute("status")) {
                return mapping.findForward(SESSAOINVALIDA);
            }
        }

        FaturarPagamentoActionForm formFaturarPagamento = (FaturarPagamentoActionForm) form;

        Pagamento pagamento = new Pagamento();
        // Marca a dataHora do pagamento
        pagamento.setDataHora(new Date());

        // Identifica a forma de pagamento...
        FormaPagamento formaPagamento = FormaPagamentoService.getFormaPagamento(formFaturarPagamento.getFormaPagamentoId());
        char tipo = 'S'; // Valor usado apenas para iniciar a variavel
        if (formaPagamento != null) {
            tipo = formaPagamento.getTipo();
            // Valida o tipo da forma de pagamento
            if (tipo != 'A' && tipo != 'P') {
                System.out.println("Falha ao identificar tipo de forma de pagamento.");
                return mapping.findForward(FALHAIDENTIFICARFORMAPAGAMENTO);
            }
        }
        else {
            System.out.println("Falha ao identificar forma de pagamento.");
            return mapping.findForward(FALHAIDENTIFICARFORMAPAGAMENTO);
        }

        if ((tipo == 'A' && (formFaturarPagamento.getSubtotalAVista() <= Double.parseDouble("0") || formFaturarPagamento.getTotalAVista() <= Double.parseDouble("0")))
            || (tipo == 'P' && (formFaturarPagamento.getSubtotalAPrazo() <= Double.parseDouble("0") || formFaturarPagamento.getTotalAPrazo() <= Double.parseDouble("0")))) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        // Marca a forma de pagamento
        pagamento.setFormaPagamento(formaPagamento);

        Ficha ficha = new Ficha();
        // Captura objeto ficha colocado na sessao por RegistrarPagamentoAction
        if (request.getSession(false).getAttribute("fichaPagamento") != null) {
            ficha = (Ficha)request.getSession(false).getAttribute("fichaPagamento");
        }
        else {
            System.out.println("Falha ao buscar registro de ficha na sessao em FaturarPagamentoAction.");
            return mapping.findForward(FALHAIDENTIFICARFICHA);
        }
        // Marca a ficha
        pagamento.setFicha(ficha);

        // Identifica o usuario logado
        Funcionario funcionario;
        if (request.getSession(false).getAttribute("funcionarioLogado") != null) {
            funcionario = (Funcionario) request.getSession(false).getAttribute("funcionarioLogado");
        }
        else {
            System.out.println("Falha ao tentar identificar funcionarioLogado em FaturarPagamentoAction.");
            return mapping.findForward(FALHAIDENTIFICARUSUARIOLOGADO);
        }
        // Marca o funcionario que estah operando o caixa
        pagamento.setFuncionario(funcionario);

        // Para forma de pagamento do tipo 'A vista'
        if (tipo == 'A') {
            pagamento.setValor(formFaturarPagamento.getSubtotalAVista());
            pagamento.setDesconto(formaPagamento.getDesconto());
            // Trecho de codigo para quando for usar desconto no pagamento a vista
            //pagamento.setValorFinal(formFaturarPagamento.getTotalAVistaComDesconto());
            pagamento.setValorFinal(formFaturarPagamento.getTotalAVista());
            pagamento.setValorEmDinheiro(formFaturarPagamento.getTotalAVistaEmDinheiro());

            // Valida o valor final passado pelo formulario da pagina
            Double valorFinal = pagamento.getValor() - (pagamento.getValor() * (pagamento.getDesconto() / 100));
            if (((valorFinal - Double.parseDouble("0.1")) > pagamento.getValorFinal()) || (pagamento.getValorFinal() > (valorFinal + Double.parseDouble("0.1")))) {
                System.out.println("Valor final de pagamento NAO confere devido a diferenca no desconto dado.");
                return mapping.findForward(FALHAVALORFINALNAOCONFERE);
            }
            // Valida o piso para o desconto
            if (formaPagamento.getPisoParaDesconto() > pagamento.getValorFinal()) {
                System.out.println("Valor final de pagamento NAO confere devido ao piso para desconto nao atingido.");
                return mapping.findForward(FALHAVALORFINALNAOCONFERE);
            }
        }
        else
        // Para forma de pagamento do tipo 'A prazo'
        if (tipo == 'P') {
            pagamento.setValor(formFaturarPagamento.getSubtotalAPrazo());
            pagamento.setDesconto(Double.parseDouble("0"));
            pagamento.setValorFinal(formFaturarPagamento.getTotalAPrazo());
            pagamento.setValorEmDinheiro(formFaturarPagamento.getTotalAPrazoEmDinheiro());

            // Valida o valor minimo para pagamento a prazo
            if (pagamento.getValorFinal() < formaPagamento.getValorMinimoAPrazo()) {
                System.out.println("Valor final de pagamento NAO confere devido ao valor minimo para pagamento a prazo nao atingido.");
                return mapping.findForward(VALORMINIMONAOATINGIDO);
            }
        }
        pagamento.setValorEmCheque(formFaturarPagamento.getTotalCheques());
        pagamento.setValorEmCartao(formFaturarPagamento.getTotalCartao());

        Double saldoAtual = ficha.getSaldo();
        // Atualiza o saldo da ficha
        ficha.setSaldo(saldoAtual + pagamento.getValor());

        if(FichaService.atualizar(ficha)) {
            System.out.println("Registro de Ficha atualizado com sucesso durante inclusao de credito em FaturarPagamentoAction");
        }
        else {
            System.out.println("Falha ao atualizar registro de Ficha durante inclusao de credito em FaturarPagamentoAction");
            return mapping.findForward(FALHAATUALIZAR);
        }

        // Salva o registro de pagamento no banco e captura o ID do registro salvo
        Integer id = PagamentoService.salvar(pagamento);
        
        if(id != null) {
            System.out.println("Registro de Pagamento salvo com sucesso em FaturarPagamentoAction");

            // Captura objeto chequeBancarioCollectionPagar contendo os registros de cheques bancarios incluidos no pagamento
            Collection<ChequeBancario> chequeBancarioCollectionPagar = new ArrayList<ChequeBancario>();
            if (request.getSession(false).getAttribute("chequeBancarioCollectionPagar") != null) {
                chequeBancarioCollectionPagar = (Collection<ChequeBancario>)request.getSession(false).getAttribute("chequeBancarioCollectionPagar");
                // Marca o pagamento nos registros do Collection<ChequeBancario>
                Iterator iterator = chequeBancarioCollectionPagar.iterator();
                ChequeBancario chequeBancarioAux;
                while (iterator.hasNext()) {
                    chequeBancarioAux = (ChequeBancario)iterator.next();
                    chequeBancarioAux.setPagamento(new Pagamento(id));
                    chequeBancarioAux.setNomePaciente(ficha.getPaciente().getNome());
                    chequeBancarioAux.setIdPaciente(ficha.getPaciente().getId());
                    if (tipo == 'A') { // Se o pagamento for 'A Vista' a data para depositar dos cheques serah a data atual
                        chequeBancarioAux.setDataParaDepositar(new Date());
                    }
                    // Salva os registros de 'ChequeBancario'
                    Integer idCheque = ChequeBancarioService.salvar(chequeBancarioAux);
                    if (idCheque != null) {
                        System.out.println("Registro de ChequeBancario (ID = " + idCheque + ") salvo com sucesso em FaturarPagamentoAction");
                    }
                    else {
                        System.out.println("Falha ao salvar registro de ChequeBancario no banco em FaturarPagamentoAction");
                        return mapping.findForward(FALHASALVAR);
                    }
                }
            }
            else {
                System.out.println("Pagamento sem cheque.");
            }

            // Captura objeto comprovantePagamentoCartaoCollectionPagar contendo os comprovantes de pagamento com cartao incluidos no pagamento
            Collection<ComprovantePagamentoCartao> comprovantePagamentoCartaoCollectionPagar = new ArrayList<ComprovantePagamentoCartao>();
            if (request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar") != null) {
                comprovantePagamentoCartaoCollectionPagar = (Collection<ComprovantePagamentoCartao>) request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar");
                // Marca o pagamento nos registros do Collection<ComprovantePagamentoCartao>
                Iterator iterator = comprovantePagamentoCartaoCollectionPagar.iterator();
                ComprovantePagamentoCartao comprovantePagamentoCartaoAux;
                while (iterator.hasNext()) {
                    comprovantePagamentoCartaoAux = (ComprovantePagamentoCartao)iterator.next();
                    comprovantePagamentoCartaoAux.setPagamento(new Pagamento(id));
                    comprovantePagamentoCartaoAux.setNomePaciente(ficha.getPaciente().getNome());
                    comprovantePagamentoCartaoAux.setIdPaciente(ficha.getPaciente().getId());
                    if (tipo == 'A' && comprovantePagamentoCartaoAux.getTipo() == 'C') { // Se o pagamento for 'A Vista' e o pagamento com cartao for do tipo 'credito', a parcela serah 1
                        comprovantePagamentoCartaoAux.setParcelas(Short.parseShort("1"));
                    }
                    // Salva os registros de 'ComprovantePagamentoCartao'
                    Integer idCartao = ComprovantePagamentoCartaoService.salvar(comprovantePagamentoCartaoAux);
                    if (idCartao != null) {
                        System.out.println("Registro de ComprovantePagamentoCartao (ID = " + idCartao + ") salvo com sucesso em FaturarPagamentoAction");
                    }
                    else {
                        System.out.println("Falha ao salvar registro de ComprovantePagamentoCartao no banco em FaturarPagamentoAction");
                        return mapping.findForward(FALHASALVAR);
                    }
                }
            }
            else {
                System.out.println("Pagamento sem cartao.");
            }

            try {
                request.getSession(false).removeAttribute("fichaPagamento");
                request.getSession(false).removeAttribute("chequeBancarioCollectionPagar");
                request.getSession(false).removeAttribute("totalCheques");
                request.getSession(false).removeAttribute("comprovantePagamentoCartaoCollectionPagar");
                request.getSession(false).removeAttribute("totalCartao");
            } catch(Exception e) {
                System.out.println("Falha ao remover atributos da sessao em FaturarPagamentoAction. Exception: " + e.getCause());
                return mapping.findForward(FALHAATUALIZAR);
            }

            request.setAttribute("idPaciente", ficha.getPaciente().getId().toString()); // Usado em VisualizarPacienteAction
            request.setAttribute("botaoFinalizar", true);  // flag para oferer opcao adequada na pagina visualizarPaciente.jsp
            return mapping.findForward(SUCESSO);
        }
        else { // Se ocorrer falha ao salvar registro de pagamento...
            // Deduz o saldo inserido anteriormente...
            ficha.setSaldo(saldoAtual);
            if(FichaService.atualizar(ficha)) {
                System.out.println("Registro de Ficha atualizado com sucesso durante deducao de saldo em FaturarPagamentoAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Ficha durante deducao de saldo em FaturarPagamentoAction");
                return mapping.findForward(FALHAATUALIZAR);
            }

            System.out.println("Falha ao salvar registro de Pagamento no banco em FaturarPagamentoAction");
            return mapping.findForward(FALHASALVAR);
        }
    }
}