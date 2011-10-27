package web.chequeBancario;

import annotations.Boca;
import annotations.ChequeBancario;
import annotations.Ficha;
import annotations.Paciente;
import annotations.Pagamento;
import annotations.StatusChequeBancario;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.ChequeBancarioService;
import service.HistoricoBocaService;
import service.HistoricoDenteService;
import service.PacienteService;
import service.PagamentoService;
import service.StatusChequeBancarioService;

/**
 *
 * @author Fabricio Reis
 */
public class AtualizarChequeBancarioAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAATUALIZAR = "falhaAtualizar";
    private static final String FALHAFORMATARDATA = "falhaFormatarData";
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

        AtualizarChequeBancarioActionForm formChequeBancario = (AtualizarChequeBancarioActionForm) form;

        if ((formChequeBancario.getNomeTitular().trim().isEmpty()) || (formChequeBancario.getCpfTitular().trim().isEmpty())
            || (formChequeBancario.getNumero().trim().isEmpty()) || (formChequeBancario.getBanco().trim().isEmpty())
            || (formChequeBancario.getValor().toString().trim().isEmpty()) || (formChequeBancario.getValor() <= Double.parseDouble("0"))
            || (formChequeBancario.getDataParaDepositar().trim().isEmpty()) || (formChequeBancario.getCodigoStatus().toString().trim().isEmpty())
            || (formChequeBancario.getCodigoStatusAtual().toString().trim().isEmpty()) || (formChequeBancario.getPagamentoId().toString().trim().isEmpty())
            || (formChequeBancario.getNomePaciente().trim().isEmpty()) || (formChequeBancario.getIdPaciente().toString().trim().isEmpty())) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        ChequeBancario chequeBancario = new ChequeBancario();
        chequeBancario.setId(formChequeBancario.getId());
        chequeBancario.setNomePaciente(formChequeBancario.getNomePaciente());
        chequeBancario.setIdPaciente(formChequeBancario.getIdPaciente());
        chequeBancario.setNomeTitular(formChequeBancario.getNomeTitular().trim());
        chequeBancario.setCpfTitular(formChequeBancario.getCpfTitular().trim());
        chequeBancario.setRgTitular(formChequeBancario.getRgTitular().trim());
        chequeBancario.setNumero(formChequeBancario.getNumero().trim());
        if (formChequeBancario.getBanco().equals("selected")) {
            chequeBancario.setBanco(formChequeBancario.getOutroBanco().trim());
        }
        else {
            chequeBancario.setBanco(formChequeBancario.getBanco().trim());
        }
        chequeBancario.setValor(formChequeBancario.getValor());
        Date dataParaDepositar = new Date();
        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
        try {
            dataParaDepositar = formatador.parse(formChequeBancario.getDataParaDepositar());
        } catch (Exception e) {
            System.out.println("Falha ao formatar a data para depositar de cheque bancario (ID = " + chequeBancario.getId() + ") ao atualizar registro! Exception: " + e.getMessage());
            return mapping.findForward(FALHAFORMATARDATA);
        }
        chequeBancario.setDataParaDepositar(dataParaDepositar);
        StatusChequeBancario novoStatus = StatusChequeBancarioService.getStatusChequeBancario(formChequeBancario.getCodigoStatus());
        chequeBancario.setStatus(novoStatus);
        chequeBancario.setPagamento(new Pagamento(formChequeBancario.getPagamentoId()));

        DecimalFormat decimalFormat = new DecimalFormat("0.00");

        // Verifica se estah alterando o status do cheque para Irregular (codigo 3) e nao era cancelado...
        // Se sim, atualiza o "impedimento" do paciente, atualiza o saldo da ficha do paciente
        // e atualiza registro de pagamento com o cheque irregular
        if (novoStatus.equals(StatusChequeBancarioService.getStatusChequeBancarioIrregular())
            && !formChequeBancario.getCodigoStatusAtual().equals(StatusChequeBancarioService.getStatusChequeBancarioCancelado().getCodigo())
            && !formChequeBancario.getCodigoStatusAtual().equals(formChequeBancario.getCodigoStatus())) {

            Pagamento pagamento = PagamentoService.getFichaPaciente(formChequeBancario.getPagamentoId());
            Paciente paciente = pagamento.getFicha().getPaciente();
            // Atualiza o "impedimento" do paciente
            String impedimento = paciente.getImpedimento().concat(" Cheque IRREGULAR (valor: R$" + decimalFormat.format(chequeBancario.getValor()) + ") |");
            paciente.setImpedimento(impedimento.trim());
            // Busca registro de boca do paciente
            Boca boca = pagamento.getFicha().getPaciente().getBoca();
            // Identifica a ficha do paciente
            Ficha ficha = pagamento.getFicha();
            // Atualiza o status de registros de 'historicoBoca' de 'liberado (pago)' para 'orcado'
            Double valorRestanteHistoricoBoca = HistoricoBocaService.acertoDevolucaoValor(formChequeBancario.getValor(), boca);
            Double valorRestanteHistoricoDente = Double.parseDouble("0");
            if (valorRestanteHistoricoBoca != null) {
                // Atualiza o saldo da ficha do paciente somando o valor total de registros 'historicoBoca' que tiveram seu(s) status atualizado(s) de 'liberado' para 'orcado'
                ficha.setSaldo(ficha.getSaldo() + (formChequeBancario.getValor() - valorRestanteHistoricoBoca));
                // Verifica se ainda ha credito para fazer acerto
                if (valorRestanteHistoricoBoca > Double.parseDouble("0")) {
                    // Atualiza o status de registros de 'historicoDente' de 'liberado (pago)' para 'orcado'
                    valorRestanteHistoricoDente = HistoricoDenteService.acertoDevolucaoValor(valorRestanteHistoricoBoca, boca);
                    if (valorRestanteHistoricoDente != null) {
                        // Atualiza o saldo da ficha do paciente somando o valor total de registros 'historicoDente' que tiveram seu(s) status atualizado(s) de 'liberado' para 'orcado'
                        ficha.setSaldo(ficha.getSaldo() + (valorRestanteHistoricoBoca - valorRestanteHistoricoDente));
                    }
                    else {
                        System.out.println("Falha ao atualizar registro(s) de historicoDente em AtualizarChequeBancarioAction");
                        return mapping.findForward(FALHAATUALIZAR);
                    }
                }
            }
            else {
                System.out.println("Falha ao atualizar registro(s) de historicoBoca em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }

            // Atualiza o saldo da ficha do paciente descontando o valor do cheque irregular
            ficha.setSaldo(ficha.getSaldo() - formChequeBancario.getValor());
            paciente.setFicha(ficha);
            if (PacienteService.atualizar(paciente)) {
                System.out.println("Registro de Paciente (ID = " + paciente.getId() + ") e Ficha (ID = " + ficha.getId() + ") atualizados com sucesso em AtualizarChequeBancarioAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Paciente (ID = " + paciente.getId() + ") e Ficha (ID = " + ficha.getId() + ") em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }

            // Atualiza o registro de pagamento descontando o valor do cheque irregular
            pagamento.setValorEmCheque(pagamento.getValorEmCheque() - chequeBancario.getValor());
            pagamento.setValor(pagamento.getValor() - chequeBancario.getValor());
            pagamento.setValorFinal(pagamento.getValorFinal() - chequeBancario.getValor());
            if (PagamentoService.atualizar(pagamento)) {
                System.out.println("Registro de Pagamento (ID = " + pagamento.getId() + ") atualizado com sucesso em AtualizarChequeBancarioAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Pagamento (ID = " + pagamento.getId() + ") em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }
        else

        // Verifica se estah alterando o status do cheque de 'cancelado' para 'irregular'...
        // Se sim, atualiza o "impedimento" do paciente..
        if (formChequeBancario.getCodigoStatusAtual().equals(StatusChequeBancarioService.getStatusChequeBancarioCancelado().getCodigo())
            && novoStatus.equals(StatusChequeBancarioService.getStatusChequeBancarioIrregular())
            && !formChequeBancario.getCodigoStatusAtual().equals(formChequeBancario.getCodigoStatus())) {

            Pagamento pagamento = PagamentoService.getFichaPaciente(formChequeBancario.getPagamentoId());
            Paciente paciente = pagamento.getFicha().getPaciente();
            // Atualiza o "impedimento" do paciente
            String impedimento = paciente.getImpedimento().concat(" Cheque IRREGULAR (valor: R$" + decimalFormat.format(chequeBancario.getValor()) + ") |");
            paciente.setImpedimento(impedimento.trim());

            if (PacienteService.atualizar(paciente)) {
                System.out.println("Registro de Paciente (ID = " + paciente.getId() + ") atualizado com sucesso em AtualizarChequeBancarioAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Paciente (ID = " + paciente.getId() + ") em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }
        else

        // Verifica se estah alterando o status do cheque de Irregular para outro que nao seja o 'Cancelado'...
        // Se sim, atualiza o "impedimento" do paciente, atualiza o saldo da ficha do paciente,
        // e atualiza registro de pagamento como o cheque estava irregular
        if (formChequeBancario.getCodigoStatusAtual().equals(StatusChequeBancarioService.getStatusChequeBancarioIrregular().getCodigo())
            && !novoStatus.equals(StatusChequeBancarioService.getStatusChequeBancarioCancelado())
            && !formChequeBancario.getCodigoStatusAtual().equals(formChequeBancario.getCodigoStatus())) {

            Pagamento pagamento = PagamentoService.getFichaPaciente(formChequeBancario.getPagamentoId());
            Paciente paciente = pagamento.getFicha().getPaciente();
            // Atualiza o "impedimento" do paciente
            String[] impedimentosAux = paciente.getImpedimento().split("\\|");
            String aux = "Cheque IRREGULAR (valor: R$" + decimalFormat.format(chequeBancario.getValor()) + ")";
            String impedimento = "";
            for (int i = 0; i < impedimentosAux.length; i++) {
                if(!aux.equals(impedimentosAux[i].trim())) {
                    impedimento = impedimento + impedimentosAux[i].toString().trim() + " | ";
                }
            }
            paciente.setImpedimento(impedimento.trim());
            // Atualiza o saldo da ficha do paciente imcrementando o valor do cheque que estava irregular
            Ficha ficha = pagamento.getFicha();
            ficha.setSaldo(ficha.getSaldo() + formChequeBancario.getValor());
            paciente.setFicha(ficha);
            if (PacienteService.atualizar(paciente)) {
                System.out.println("Registro de Paciente (ID = " + paciente.getId() + ") atualizado com sucesso em AtualizarChequeBancarioAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Paciente (ID = " + paciente.getId() + ") em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
            // Atualiza o registro de pagamento imcrementando o valor do cheque que estava irregular
            pagamento.setValorEmCheque(pagamento.getValorEmCheque() + chequeBancario.getValor());
            pagamento.setValor(pagamento.getValor() + chequeBancario.getValor());
            pagamento.setValorFinal(pagamento.getValorFinal() + chequeBancario.getValor());

            if (PagamentoService.atualizar(pagamento)) {
                System.out.println("Registro de Pagamento (ID = " + pagamento.getId() + ") atualizado com sucesso em AtualizarChequeBancarioAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Pagamento (ID = " + pagamento.getId() + ") em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }
        else

        // Verifica se estah alterando o status do cheque de 'irregular' para 'cancelado'...
        // Se sim, atualiza o "impedimento" do paciente..
        if (formChequeBancario.getCodigoStatusAtual().equals(StatusChequeBancarioService.getStatusChequeBancarioIrregular().getCodigo())
            && novoStatus.equals(StatusChequeBancarioService.getStatusChequeBancarioCancelado())
            && !formChequeBancario.getCodigoStatusAtual().equals(formChequeBancario.getCodigoStatus())) {

            Pagamento pagamento = PagamentoService.getFichaPaciente(formChequeBancario.getPagamentoId());
            Paciente paciente = pagamento.getFicha().getPaciente();
            // Atualiza o "impedimento" do paciente
            String[] impedimentosAux = paciente.getImpedimento().split("\\|");
            String aux = "Cheque IRREGULAR (valor: R$" + decimalFormat.format(chequeBancario.getValor()) + ")";
            String impedimento = "";
            for (int i = 0; i < impedimentosAux.length; i++) {
                if(!aux.equals(impedimentosAux[i].trim())) {
                    impedimento = impedimento + impedimentosAux[i].toString().trim() + " | ";
                }
            }
            paciente.setImpedimento(impedimento.trim());

            if (PacienteService.atualizar(paciente)) {
                System.out.println("Registro de Paciente (ID = " + paciente.getId() + ") atualizado com sucesso em AtualizarChequeBancarioAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Paciente (ID = " + paciente.getId() + ") em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }
        else

        // Verifica se estah alterando o status do cheque para Cancelado (codigo 7) e nao era 'irregular'...
        if (novoStatus.equals(StatusChequeBancarioService.getStatusChequeBancarioCancelado())
            && !formChequeBancario.getCodigoStatusAtual().equals(StatusChequeBancarioService.getStatusChequeBancarioIrregular().getCodigo())
            && !formChequeBancario.getCodigoStatusAtual().equals(formChequeBancario.getCodigoStatus())) {

            Pagamento pagamento = PagamentoService.getFichaPaciente(formChequeBancario.getPagamentoId());
            Paciente paciente = pagamento.getFicha().getPaciente();
            // Busca registro de boca do paciente
            Boca boca = pagamento.getFicha().getPaciente().getBoca();
            // Identifica a ficha do paciente
            Ficha ficha = pagamento.getFicha();
            // Atualiza o status de registros de 'historicoBoca' de 'liberado (pago)' para 'orcado'
            Double valorRestanteHistoricoBoca = HistoricoBocaService.acertoDevolucaoValor(formChequeBancario.getValor(), boca);
            Double valorRestanteHistoricoDente = Double.parseDouble("0");
            if (valorRestanteHistoricoBoca != null) {
                // Atualiza o saldo da ficha do paciente somando o valor total de registros 'historicoBoca' que tiveram seu(s) status atualizado(s) de 'liberado' para 'orcado'
                ficha.setSaldo(ficha.getSaldo() + (formChequeBancario.getValor() - valorRestanteHistoricoBoca));
                // Verifica se ainda ha credito para fazer acerto
                if (valorRestanteHistoricoBoca > Double.parseDouble("0")) {
                    // Atualiza o status de registros de 'historicoDente' de 'liberado (pago)' para 'orcado'
                    valorRestanteHistoricoDente = HistoricoDenteService.acertoDevolucaoValor(valorRestanteHistoricoBoca, boca);
                    if (valorRestanteHistoricoDente != null) {
                        // Atualiza o saldo da ficha do paciente somando o valor total de registros 'historicoDente' que tiveram seu(s) status atualizado(s) de 'liberado' para 'orcado'
                        ficha.setSaldo(ficha.getSaldo() + (valorRestanteHistoricoBoca - valorRestanteHistoricoDente));
                    }
                    else {
                        System.out.println("Falha ao atualizar registro(s) de historicoDente em AtualizarChequeBancarioAction");
                        return mapping.findForward(FALHAATUALIZAR);
                    }
                }
            }
            else {
                System.out.println("Falha ao atualizar registro(s) de historicoBoca em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }

            // Atualiza o saldo da ficha do paciente descontando o valor do cheque cancelado
            ficha.setSaldo(ficha.getSaldo() - formChequeBancario.getValor());
            paciente.setFicha(ficha);
            if (PacienteService.atualizar(paciente)) {
                System.out.println("Registro de Paciente (ID = " + paciente.getId() + ") e Ficha (ID = " + ficha.getId() + ") atualizados com sucesso em AtualizarChequeBancarioAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Paciente (ID = " + paciente.getId() + ") e Ficha (ID = " + ficha.getId() + ") em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }

            // Atualiza o registro de pagamento descontando o valor do cheque irregular
            pagamento.setValorEmCheque(pagamento.getValorEmCheque() - chequeBancario.getValor());
            pagamento.setValor(pagamento.getValor() - chequeBancario.getValor());
            pagamento.setValorFinal(pagamento.getValorFinal() - chequeBancario.getValor());
            if (PagamentoService.atualizar(pagamento)) {
                System.out.println("Registro de Pagamento (ID = " + pagamento.getId() + ") atualizado com sucesso em AtualizarChequeBancarioAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Pagamento (ID = " + pagamento.getId() + ") em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }
        else

        // Verifica se estah alterando o status do cheque de 'Cancelado' para outro que nao seja o 'Irregular'...
        if (formChequeBancario.getCodigoStatusAtual().equals(StatusChequeBancarioService.getStatusChequeBancarioCancelado().getCodigo())
            && !novoStatus.equals(StatusChequeBancarioService.getStatusChequeBancarioIrregular())
            && !formChequeBancario.getCodigoStatusAtual().equals(formChequeBancario.getCodigoStatus())) {

            Pagamento pagamento = PagamentoService.getFichaPaciente(formChequeBancario.getPagamentoId());
            Paciente paciente = pagamento.getFicha().getPaciente();
            // Atualiza o saldo da ficha do paciente imcrementando o valor do cheque que estava cancelado
            Ficha ficha = pagamento.getFicha();
            ficha.setSaldo(ficha.getSaldo() + formChequeBancario.getValor());
            paciente.setFicha(ficha);
            if (PacienteService.atualizar(paciente)) {
                System.out.println("Registro de Paciente (ID = " + paciente.getId() + ") atualizado com sucesso em AtualizarChequeBancarioAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Paciente (ID = " + paciente.getId() + ") em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
            // Atualiza o registro de pagamento imcrementando o valor do cheque que estava cancelado
            pagamento.setValorEmCheque(pagamento.getValorEmCheque() + chequeBancario.getValor());
            pagamento.setValor(pagamento.getValor() + chequeBancario.getValor());
            pagamento.setValorFinal(pagamento.getValorFinal() + chequeBancario.getValor());

            if (PagamentoService.atualizar(pagamento)) {
                System.out.println("Registro de Pagamento (ID = " + pagamento.getId() + ") atualizado com sucesso em AtualizarChequeBancarioAction");
            }
            else {
                System.out.println("Falha ao atualizar registro de Pagamento (ID = " + pagamento.getId() + ") em AtualizarChequeBancarioAction");
                return mapping.findForward(FALHAATUALIZAR);
            }
        }

        if(ChequeBancarioService.atualizar(chequeBancario)) {
            System.out.println("Registro de ChequeBancario (ID = " + chequeBancario.getId() + ") atualizado com sucesso!");
            return mapping.findForward(SUCESSO);
        }
        else {
            System.out.println("Falha ao atualizar registro de ChequeBancario (ID = " + chequeBancario.getId() + ") no banco!");
            return mapping.findForward(FALHAATUALIZAR);
        }
    }
}