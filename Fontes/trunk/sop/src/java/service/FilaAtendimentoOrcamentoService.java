package service;

import annotations.FilaAtendimentoOrcamento;

/**
 *
 * @author Fabricio P. Reis
 */
public class FilaAtendimentoOrcamentoService {

    public FilaAtendimentoOrcamentoService() {
    }

    /*
     * Instancia objeto FilaAtendimentoOrcamento e marca seu ID = 1 (fila de orcamentos)
     */
    public static FilaAtendimentoOrcamento getFilaAtendimentoOrcamento() {
        FilaAtendimentoOrcamento filaAtendimentoOrcamento = new  FilaAtendimentoOrcamento();
        filaAtendimentoOrcamento.setId(1);
        return filaAtendimentoOrcamento;
    }

    /*
     * Instancia objeto FilaAtendimentoOrcamento e marca seu ID = 2 (fila de orcamentos em atendimento)
     */
    public static FilaAtendimentoOrcamento getFilaAtendimentoOrcamentoEmAtendimento() {
        FilaAtendimentoOrcamento filaAtendimentoOrcamento = new  FilaAtendimentoOrcamento();
        filaAtendimentoOrcamento.setId(2);
        return filaAtendimentoOrcamento;
    }

    /*
     * Instancia objeto FilaAtendimentoOrcamento e marca seu ID = 3 (fila de orcamentos finalizados)
     */
    public static FilaAtendimentoOrcamento getFilaAtendimentoOrcamentoFinalizado() {
        FilaAtendimentoOrcamento filaAtendimentoOrcamento = new  FilaAtendimentoOrcamento();
        filaAtendimentoOrcamento.setId(3);
        return filaAtendimentoOrcamento;
    }
}