package service;

import annotations.Boca;
import annotations.Paciente;
import dao.BocaDAO;

/**
 *
 * @author Fabricio P. Reis
 */
public class BocaService {

    private static final String SUCESSO = "Sucesso";

    public BocaService() {
    }

    /*
     * Atualiza registro de boca no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(Boca boca) {
        BocaDAO bocaDAO = new BocaDAO();
        try {
            bocaDAO.atualizar(boca);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de boca no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base a boca com o ID passado como parametro
     * Se encontrar, retorna objeto Boca
     * Senao retorna null
     */
    public static Boca getBoca(Integer id) {
        BocaDAO bocaDAO = new BocaDAO();
        Boca boca = null;
        try {
            boca = bocaDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Boca no banco. Metodo BocaService.getBoca(id)! Exception: " + e.getMessage());
            return null;
        }
        return boca;
    }

    /*
     * Busca na base a boca associada ao paciente passado como parametro
     * Se encontrar, retorna objeto Boca associado ao paciente
     * Senao, cria um objeto boca para ele
     */
    public static Boca getBoca(Paciente paciente) {
        BocaDAO bocaDAO = new BocaDAO();
        Boca boca = null;
        if (paciente.getId() != null) {
            try {
                boca = bocaDAO.consultarPaciente(paciente);
            } catch (Exception e) {
                System.out.println("Falha ao consultar registro de boca no banco. Metodo BocaService.getBoca(paciente). Exception: " + e.getMessage());
                return null;
            }
        }

        // Se nao existir uma boca, entao instancia uma...
        if (boca == null) {
            boca = new Boca();
            boca.setObservacao(SUCESSO);
            boca.setPaciente(paciente);
        }
        return boca;
    }

    /*
     * Busca na base a boca com o ID passado como parametro
     * fazendo join com a tabela 'paciente'
     * Se encontrar, retorna objeto Boca
     * Senao retorna null
     */
    public static Boca getBocaxPaciente(Integer id) {
        BocaDAO bocaDAO = new BocaDAO();
        Boca boca = null;
        try {
            boca = bocaDAO.consultarIdXPaciente(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Boca no banco. Metodo BocaService.getBocaxPaciente(id)! Exception: " + e.getMessage());
            return null;
        }
        return boca;
    }
}