package service;

import annotations.Ficha;
import annotations.Pagamento;
import dao.PagamentoDAO;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

/**
 *
 * @author Fabricio P. Reis
 */
public class PagamentoService {

    public PagamentoService() {
    }

    /*
     * Atualiza registro de pagamento no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(Pagamento pagamento) {
        PagamentoDAO pagamentoDAO = new PagamentoDAO();
        try {
            pagamentoDAO.atualizar(pagamento);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de pagamento no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Salva registro de pagamento no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Integer salvar(Pagamento pagamento) {
        Integer id = null;
        PagamentoDAO pagamentoDAO = new PagamentoDAO();
        try {
            id = pagamentoDAO.salvar(pagamento);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro de pagamento no banco! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Apaga da base registro igual ao passado como parametro
     */
    public static boolean apagar(Pagamento pagamento) {
        PagamentoDAO pagamentoDAO = new PagamentoDAO();

        try {
            pagamentoDAO.apagar(pagamento);
        }
        catch (Exception e) {
            System.out.println("Falha ao apagar registro de Pagamento (ID = " + pagamento.getId() + ") no banco! Metodo PagamentoService.apagar! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base registro de pagamento com o ID passado como parametro
     * Se encontrar, retorna objeto Pagamento
     * Senao retorna null
     */
    public static Pagamento getPagamento(Integer id) {
        PagamentoDAO pagamentoDAO = new PagamentoDAO();
        Pagamento pagamento = null;
        try {
            pagamento = pagamentoDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar registro de Pagamento no banco! Metodo PagamentoService.getPagamento(id)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return pagamento;
    }

    /*
     * Busca na base registros de pagamentos associados a ficha passada como parametro
     * Se encontrar, retorna objeto Collection<Pagamento>
     * Senao retorna null
     */
    public static Collection<Pagamento> getPagamentos(Ficha ficha) {
        PagamentoDAO pagamentoDAO = new PagamentoDAO();
        Collection<Pagamento> out = new ArrayList<Pagamento>();
        try {
            out = pagamentoDAO.consultarPagamentos(ficha);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar registros de Pagamento no banco! Metodo PagamentoService.getPagamentos(ficha)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return out;
    }

    /*
     * Busca na base registro de pagamento com o ID passado como parametro
     * fazendo join com as tabelas: Ficha e Paciente
     * Se encontrar, retorna objeto pagamento
     * Senao retorna null
     */
    public static Pagamento getFichaPaciente(Integer id) {
        PagamentoDAO pagamentoDAO = new PagamentoDAO();
        Pagamento pagamento = null;
        try {
            pagamento = pagamentoDAO.consultarFichaPaciente(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Pagamento no banco! Metodo PagamentoService.getFichaPaciente(id)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return pagamento;
    }

    /*
     * Busca na base registro de pagamento com o ID passado como parametro
     * fazendo join com a tabela Ficha
     * Se encontrar, retorna objeto pagamento
     * Senao retorna null
     */
    public static Pagamento getFicha(Integer id) {
        PagamentoDAO pagamentoDAO = new PagamentoDAO();
        Pagamento pagamento = null;
        try {
            pagamento = pagamentoDAO.consultarFicha(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Pagamento no banco! Metodo PagamentoService.getFichaPaciente(id)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return pagamento;
    }

    /*
     * Busca registros de pagamentos da ficha passada como parametro,
     * ordenando de forma descendente pelo campo dataHora
     * Se encontrar, retorna objeto Collection<Pagamento>
     * Senao, retorna null
     */
    public static Collection<Pagamento> getPagamentosOrdenadoDescData(Ficha ficha) {
        PagamentoDAO pagamentoDAO = new PagamentoDAO();
        Collection<Pagamento> pagamentoCollection = new ArrayList<Pagamento>();
        try {
            pagamentoCollection = pagamentoDAO.consultarPagamentosOrdenadoDescData(ficha);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar registro de pagamento no banco! Metodo PagamentoService.getPagamentosOrcadosDescData(ficha)! Exception: " + e.getMessage());
            return null;
        }

        return pagamentoCollection;
    }

    /*
     * Retorna o somatorio do valores finais do pagamentoCollection passado como parametro
     */
    public static Double getValorTotal(Collection<Pagamento> pagamentoCollection) {
        Double out = Double.parseDouble("0");
        Iterator iterator = pagamentoCollection.iterator();
        while (iterator.hasNext()) {
            out = out + ((Pagamento) iterator.next()).getValorFinal();
        }
        return out;
    }
}