package service;

import annotations.Ficha;
import annotations.Paciente;
import dao.FichaDAO;
import java.util.Date;

/**
 *
 * @author Fabricio P. Reis
 */
public class FichaService {

    private static final String SUCESSO = "Sucesso";

    public FichaService() {
    }

    /*
     * Atualiza registro de ficha no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(Ficha ficha) {
        FichaDAO fichaDAO = new FichaDAO();
        try {
            fichaDAO.atualizar(ficha);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de ficha no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base registro de ficha com o ID passado como parametro
     * Se encontrar, retorna objeto Ficha
     * Senao retorna null
     */
    public static Ficha getFicha(Integer id) {
        FichaDAO fichaDAO = new FichaDAO();
        Ficha ficha = null;
        try {
            ficha = fichaDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Ficha no banco! Metodo FichaService.getFicha(id)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return ficha;
    }

    /*
     * Busca na base a ficha associada ao paciente passado como parametro
     * Se encontrar, retorna objeto Ficha
     * Senao, cria um objeto Ficha associado a ele
     */
    public static Ficha getFicha(Paciente paciente) {
        FichaDAO fichaDAO = new FichaDAO();
        Ficha ficha = null;

        if (paciente.getId() != null) {
            try {
                ficha = fichaDAO.consultarPaciente(paciente);
            }
            catch (Exception e) {
                System.out.println("Falha ao consultar Ficha no banco! Metodo FichaService.getFicha(paciente)! Exception: " + e.getMessage());
                return null;
            }
        }

        // Se nao existir uma ficha, entao instancia uma...
        if (ficha == null) {
            ficha = new Ficha();
            ficha.setDataCriacao(new Date());
            ficha.setObservacao(SUCESSO);
            ficha.setSaldo(Double.parseDouble("0"));  // Fichas sao criadas com saldo igual a zero
            ficha.setPaciente(paciente);
        }
        return ficha;
    }
}