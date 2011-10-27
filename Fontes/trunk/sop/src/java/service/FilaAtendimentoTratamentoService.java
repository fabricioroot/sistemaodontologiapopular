package service;

import annotations.FilaAtendimentoTratamento;

/**
 *
 * @author Fabricio P. Reis
 */
public class FilaAtendimentoTratamentoService {

    public FilaAtendimentoTratamentoService() {
    }

    /*
     * Instancia objeto FilaAtendimentoTratamento e marca seu ID = 1 (fila de tratamentos)
     */
    public static FilaAtendimentoTratamento getFilaAtendimentoTratamento() {
        FilaAtendimentoTratamento filaAtendimentoTratamento = new FilaAtendimentoTratamento();
        filaAtendimentoTratamento.setId(1);
        return filaAtendimentoTratamento;
    }

    /*
     * Instancia objeto FilaAtendimentoTratamento e marca seu ID = 2 (fila de tratamentos em atendimento)
     */
    public static FilaAtendimentoTratamento getFilaAtendimentoTratamentoEmAtendimento() {
        FilaAtendimentoTratamento filaAtendimentoTratamento = new FilaAtendimentoTratamento();
        filaAtendimentoTratamento.setId(2);
        return filaAtendimentoTratamento;
    }

    /*
     * Instancia objeto FilaAtendimentoTratamento e marca seu ID = 3 (fila de tratamentos finalizados)
     */
    public static FilaAtendimentoTratamento getFilaAtendimentoTratamentoFinalizado() {
        FilaAtendimentoTratamento filaAtendimentoTratamento = new FilaAtendimentoTratamento();
        filaAtendimentoTratamento.setId(3);
        return filaAtendimentoTratamento;
    }
}