package service;

import annotations.StatusChequeBancario;

/**
 *
 * @author Fabricio P. Reis
 */
public class StatusChequeBancarioService {

    public StatusChequeBancarioService() {
    }

    /*
     * Instancia objeto StatusChequeBancario de acordo com o codigo passado
     * como parametro
     */
    public static StatusChequeBancario getStatusChequeBancario(Short codigo) {
        StatusChequeBancario statusChequeBancario = new StatusChequeBancario();
        statusChequeBancario.setId(codigo); // ID e codigo devem ser iguais
        statusChequeBancario.setCodigo(codigo);
        return statusChequeBancario;
    }

    /*
     * Instancia objeto StatusChequeBancario e marca seu ID = 1 (nao depositado)
     */
    public static StatusChequeBancario getStatusChequeBancarioNaoDepositado() {
        StatusChequeBancario statusChequeBancario = new StatusChequeBancario();
        statusChequeBancario.setId(Short.parseShort("1"));
        statusChequeBancario.setCodigo(Short.parseShort("1"));
        return statusChequeBancario;
    }

    /*
     * Instancia objeto StatusChequeBancario e marca seu ID = 2 (aguardando confirmacao de credito (depositado))
     */
    public static StatusChequeBancario getStatusChequeBancarioAguardandoConfirmacaoDeCredito() {
        StatusChequeBancario statusChequeBancario = new StatusChequeBancario();
        statusChequeBancario.setId(Short.parseShort("2"));
        statusChequeBancario.setCodigo(Short.parseShort("2"));
        return statusChequeBancario;
    }

    /*
     * Instancia objeto StatusChequeBancario e marca seu ID = 3 (irregular)
     */
    public static StatusChequeBancario getStatusChequeBancarioIrregular() {
        StatusChequeBancario statusChequeBancario = new StatusChequeBancario();
        statusChequeBancario.setId(Short.parseShort("3"));
        statusChequeBancario.setCodigo(Short.parseShort("3"));
        return statusChequeBancario;
    }

    /*
     * Instancia objeto StatusChequeBancario e marca seu ID = 4 (compensado)
     */
    public static StatusChequeBancario getStatusChequeBancarioCompensado() {
        StatusChequeBancario statusChequeBancario = new StatusChequeBancario();
        statusChequeBancario.setId(Short.parseShort("4"));
        statusChequeBancario.setCodigo(Short.parseShort("4"));
        return statusChequeBancario;
    }

    /*
     * Instancia objeto StatusChequeBancario e marca seu ID = 5 (cancelado)
     */
    public static StatusChequeBancario getStatusChequeBancarioCancelado() {
        StatusChequeBancario statusChequeBancario = new StatusChequeBancario();
        statusChequeBancario.setId(Short.parseShort("5"));
        statusChequeBancario.setCodigo(Short.parseShort("5"));
        return statusChequeBancario;
    }
}