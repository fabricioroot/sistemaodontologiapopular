package service;

import annotations.ChequeBancario;
import dao.ChequeBancarioDAO;
import java.util.Collection;
import java.util.Iterator;

/**
 *
 * @author Fabricio P. Reis
 */
public class ChequeBancarioService {

    public ChequeBancarioService() {
    }

    /*
     * Salva registro de chequeBancario no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Integer salvar(ChequeBancario chequeBancario) {
        Integer id = null;
        ChequeBancarioDAO chequeBancarioDAO = new ChequeBancarioDAO();
        try {
            id = chequeBancarioDAO.salvar(chequeBancario);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro de ChequeBancario no banco! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Atualiza registro de chequeBancario no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(ChequeBancario chequeBancario) {
        ChequeBancarioDAO chequeBancarioDAO = new ChequeBancarioDAO();
        try {
            chequeBancarioDAO.atualizar(chequeBancario);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de cheque bancario no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base registro de chequeBancario com o ID passado como parametro
     * Se encontrar, retorna objeto ChequeBancario
     * Senao retorna null
     */
    public static ChequeBancario getChequeBancario(Integer id) {
        ChequeBancarioDAO chequeBancarioDAO = new ChequeBancarioDAO();
        ChequeBancario chequeBancario = null;
        try {
            chequeBancario = chequeBancarioDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar ChequeBancario no banco! Metodo chequeBancarioService.getChequeBancario(id)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return chequeBancario;
    }

    /*
     * Calcula o somatorio dos valores dos cheques passados como parametro
     */
    public static Double calcularTotal(Collection<ChequeBancario> chequesBancarios) {
        Double total = Double.parseDouble("0");
        ChequeBancario chequeBancarioAux;
        if (!chequesBancarios.isEmpty()) {
            Iterator iterator = chequesBancarios.iterator();
            while (iterator.hasNext()) {
                chequeBancarioAux = (ChequeBancario) iterator.next();
                total += chequeBancarioAux.getValor();
            }
        }
        return total;
    }
}