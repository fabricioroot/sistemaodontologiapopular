package dao;

import annotations.FilaAtendimentoOrcamento;
import org.hibernate.Session;

/**
 *
 * @author Fabricio P. Reis
 */
public class FilaAtendimentoOrcamentoDAO {

    public FilaAtendimentoOrcamentoDAO() {
    }

    public Integer salvar(FilaAtendimentoOrcamento filaAtendimentoOrcamento) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(filaAtendimentoOrcamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(FilaAtendimentoOrcamento filaAtendimentoOrcamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(filaAtendimentoOrcamento);
            //session.merge(filaAtendimentoOrcamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(FilaAtendimentoOrcamento filaAtendimentoOrcamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(filaAtendimentoOrcamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }
}