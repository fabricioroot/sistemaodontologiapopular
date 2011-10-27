package service;

import annotations.Funcionario;
import dao.FuncionarioDAO;

/**
 *
 * @author Fabricio P. Reis
 */
public class FuncionarioService {

    public FuncionarioService() {
    }

    /*
     * Salva registro de funcionario no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Integer salvar(Funcionario funcionario) {
        Integer id = null;
        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        try {
            id = funcionarioDAO.salvar(funcionario);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro Funcionario no banco! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Atualiza registro de funcionario no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(Funcionario funcionario) {
        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        try {
            funcionarioDAO.atualizar(funcionario);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de Funcionario no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }
}