package service;

import annotations.StatusProcedimento;

/**
 *
 * @author Fabricio P. Reis
 */
public class StatusProcedimentoService {

    public StatusProcedimentoService() {
    }

    /*
     * Instancia objeto StatusProcedimento e marca seu ID = 1 (orcado)
     */
    public static StatusProcedimento getStatusProcedimentoOrcado() {
        StatusProcedimento statusProcedimento = new StatusProcedimento();
        statusProcedimento.setId(Short.parseShort("1"));
        statusProcedimento.setCodigo(Short.parseShort("1"));
        return statusProcedimento;
    }

    /*
     * Instancia objeto StatusProcedimento e marca seu ID = 2 (liberado para ser executado - pago)
     */
    public static StatusProcedimento getStatusProcedimentoPago() {
        StatusProcedimento statusProcedimento = new StatusProcedimento();
        statusProcedimento.setId(Short.parseShort("2"));
        statusProcedimento.setCodigo(Short.parseShort("2"));
        return statusProcedimento;
    }

    /*
     * Instancia objeto StatusProcedimento e marca seu ID = 3 (em tratamento)
     */
    public static StatusProcedimento getStatusProcedimentoEmTratamento() {
        StatusProcedimento statusProcedimento = new StatusProcedimento();
        statusProcedimento.setId(Short.parseShort("3"));
        statusProcedimento.setCodigo(Short.parseShort("3"));
        return statusProcedimento;
    }

    /*
     * Instancia objeto StatusProcedimento e marca seu ID = 4 (finalizado)
     */
    public static StatusProcedimento getStatusProcedimentoFinalizado() {
        StatusProcedimento statusProcedimento = new StatusProcedimento();
        statusProcedimento.setId(Short.parseShort("4"));
        statusProcedimento.setCodigo(Short.parseShort("4"));
        return statusProcedimento;
    }
}