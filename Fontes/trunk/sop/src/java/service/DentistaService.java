package service;

import annotations.Dentista;
import dao.DentistaDAO;

/**
 *
 * @author Fabricio P. Reis
 */
public class DentistaService {

    public DentistaService() {
    }

    /*
     * Atualiza registro de dentista no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(Dentista dentista) {
        DentistaDAO dentistaDAO = new DentistaDAO();
        try {
            dentistaDAO.atualizar(dentista);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de dentista no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Salva registro de dentista no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Integer salvar(Dentista dentista) {
        Integer id = null;
        DentistaDAO dentistaDAO = new DentistaDAO();
        try {
            id = dentistaDAO.salvar(dentista);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro dentista no banco! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Instancia objeto Dentista e marca Id = 2 (dentista-sistema)
     */
    public static Dentista getDentistaSistema() {
        Dentista dentista = new Dentista();
        dentista.setId(2);
        return dentista;
    }
}