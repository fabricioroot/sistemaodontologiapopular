package service;

import annotations.Procedimento;
import dao.ProcedimentoDAO;
import java.util.Collection;

/**
 *
 * @author Fabricio P. Reis
 */
public class ProcedimentoService {

    public ProcedimentoService() {
    }

    /*
     * Salva registro de procedimento no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Short salvar(Procedimento procedimento) {
        Short id = null;
        ProcedimentoDAO procedimentoDAO = new ProcedimentoDAO();
        try {
            id = procedimentoDAO.salvar(procedimento);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro procedimento no banco! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Atualiza registro de procedimento no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(Procedimento procedimento) {
        ProcedimentoDAO procedimentoDAO = new ProcedimentoDAO();
        try {
            procedimentoDAO.atualizar(procedimento);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de procedimento no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base o procedimento com o ID passado como parametro
     * Se encontrar, retorna objeto Procedimento
     * Senao, retorna null
     */
    public static Procedimento getProcedimento(Short id) {
        ProcedimentoDAO procedimentoDAO = new ProcedimentoDAO();
        Procedimento procedimento = null;

        try {
            procedimento = procedimentoDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Procedimento no banco! Metodo ProcedimentoService.getProcedimento(id)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return procedimento;
    }

    /*
     * Busca na base todos procedimentos de parte dente e ou dente inteiro ativos
     * Retorna objeto Collection<Procedimento>
     */
    public static Collection<Procedimento> getProcedimentosPDDIAtivos() {
        Collection<Procedimento> procedimentoCollection;
        ProcedimentoDAO procedimentoDAO = new ProcedimentoDAO();
        try {
            procedimentoCollection = procedimentoDAO.consultarProcedimentosPDDIAtivos();
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar procedimentos de parde de dente e dente inteiro ativos no banco! Metodo ProcedimentoService.getProcedimentosPDDIAtivos()! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return procedimentoCollection;
    }

    /*
     * Busca na base todos procedimentos de boca completa ativos
     * Retorna objeto Collection<Procedimento>
     */
    public static Collection<Procedimento> getProcedimentosBCAtivos() {
        Collection<Procedimento> procedimentoCollection;
        ProcedimentoDAO procedimentoDAO = new ProcedimentoDAO();
        try {
            procedimentoCollection = procedimentoDAO.consultarProcedimentosBCAtivos();
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar procedimentos de boca completa ativos no banco! Metodo ProcedimentoService.getProcedimentosBCAtivos()! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return procedimentoCollection;
    }
}