package service;

import annotations.FormaPagamento;

import dao.FormaPagamentoDAO;
import java.util.ArrayList;
import java.util.Collection;

/**
 *
 * @author Fabricio P. Reis
 */
public class FormaPagamentoService {

    public FormaPagamentoService() {
    }

    /*
     * Salva registro de formaPagamento no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Short salvar(FormaPagamento formaPagamento) {
        Short id = null;
        FormaPagamentoDAO formaPagamentoDAO = new FormaPagamentoDAO();
        try {
            id = formaPagamentoDAO.salvar(formaPagamento);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro formaPagamento no banco! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Atualiza registro de formaPagamento no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(FormaPagamento formaPagamento) {
        FormaPagamentoDAO formaPagamentoDAO = new FormaPagamentoDAO();
        try {
            formaPagamentoDAO.atualizar(formaPagamento);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de formaPagamento no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base a FormaPagamento com o ID passado como parametro
     * Se encontrar, retorna objeto FormaPagamento
     * Senao, retorna null
     */
    public static FormaPagamento getFormaPagamento(Short id) {
        FormaPagamentoDAO formaPagamentoDAO = new FormaPagamentoDAO();
        FormaPagamento formaPagamento = null;

        try {
            formaPagamento = formaPagamentoDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar FormaPagamento no banco! Metodo FormaPagamentoService.getFormaPagamento(id)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return formaPagamento;
    }

    /*
     * Busca na base todas formas de pagamento ativas
     * Retorna objeto Collection<FormaPagamento>
     */
    public static Collection<FormaPagamento> getFormasDePagamentoAtivas() {
        Collection<FormaPagamento> formaPagamentoCollection = new ArrayList<FormaPagamento>();
        FormaPagamentoDAO formaPagamentoDAO = new FormaPagamentoDAO();
        try {
            formaPagamentoCollection = formaPagamentoDAO.consultarFormasDePagamentoAtivas() ;
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar formas de pagamento ativas no banco! Metodo FormaPagamentoService.getFormasDePagamentoAtivas()! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return formaPagamentoCollection;
    }
}