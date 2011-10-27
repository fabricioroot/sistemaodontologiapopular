package service;

import annotations.ComprovantePagamentoCartao;
import dao.ComprovantePagamentoCartaoDAO;
import java.util.Collection;
import java.util.Iterator;

/**
 *
 * @author Fabricio P. Reis
 */
public class ComprovantePagamentoCartaoService {

    public ComprovantePagamentoCartaoService() {
    }

    /*
     * Salva registro de comprovantePagamentoCartao no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna false
     */
    public static Integer salvar(ComprovantePagamentoCartao comprovantePagamentoCartao) {
        Integer id = null;
        ComprovantePagamentoCartaoDAO comprovantePagamentoCartaoDAO = new ComprovantePagamentoCartaoDAO();
        try {
            id = comprovantePagamentoCartaoDAO.salvar(comprovantePagamentoCartao);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro de ComprovantePagamentoCartao no banco! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Atualiza registro de ComprovantePagamentoCartao no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(ComprovantePagamentoCartao comprovantePagamentoCartao) {
        ComprovantePagamentoCartaoDAO comprovantePagamentoCartaoDAO = new ComprovantePagamentoCartaoDAO();
        try {
            comprovantePagamentoCartaoDAO.atualizar(comprovantePagamentoCartao);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de ComprovantePagamentoCartao no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Calcula o somatorio dos valores dos comprovantes de pagamento com cartao passados como parametro
     */
    public static Double calcularTotal(Collection<ComprovantePagamentoCartao> comprovantesPagamentosCartao) {
        Double total = Double.parseDouble("0");
        ComprovantePagamentoCartao comprovantePagamentoCartaoAux;
        if (!comprovantesPagamentosCartao.isEmpty()) {
            Iterator iterator = comprovantesPagamentosCartao.iterator();
            while (iterator.hasNext()) {
                comprovantePagamentoCartaoAux = (ComprovantePagamentoCartao) iterator.next();
                total += comprovantePagamentoCartaoAux.getValor();
            }
        }
        return total;
    }
}