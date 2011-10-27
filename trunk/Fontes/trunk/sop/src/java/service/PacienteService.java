package service;

import annotations.Paciente;
import dao.PacienteDAO;

/**
 *
 * @author Fabricio P. reis
 */
public class PacienteService {

    public PacienteService() {
    }

    /*
     * Salva registro de paciente no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Integer salvar(Paciente paciente) {
        Integer id = null;
        PacienteDAO pacienteDAO = new PacienteDAO();
        try {
            id = pacienteDAO.salvar(paciente);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro Paciente no banco! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Atualiza registro de paciente no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(Paciente paciente) {
        PacienteDAO pacienteDAO = new PacienteDAO();
        try {
            pacienteDAO.atualizar(paciente);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de paciente no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base o paciente com o ID passado como parametro
     * Se encontrar, retorna objeto Paciente
     * Senao retorna null
     */
    public static Paciente getPaciente(Integer id) {
        PacienteDAO pacienteDAO = new PacienteDAO();
        Paciente paciente = null;

        try {
            paciente = pacienteDAO.consultarId(id).get(0);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Paciente no banco. Metodo PacienteService.getPaciente(id)! Exception: " + e.getMessage());
            return null;
        }
        return paciente;
    }
}
