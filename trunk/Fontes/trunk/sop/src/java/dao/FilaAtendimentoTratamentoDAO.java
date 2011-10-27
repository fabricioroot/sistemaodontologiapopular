package dao;

import annotations.FilaAtendimentoTratamento;
import org.hibernate.Session;

/**
 *
 * @author Fabricio P. Reis
 */
public class FilaAtendimentoTratamentoDAO {

    public FilaAtendimentoTratamentoDAO() {
    }

    public Integer salvar(FilaAtendimentoTratamento filaAtendimentoTratamento) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(filaAtendimentoTratamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(FilaAtendimentoTratamento filaAtendimentoTratamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(filaAtendimentoTratamento);
            //session.merge(filaAtendimentoTratamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(FilaAtendimentoTratamento filaAtendimentoTratamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(filaAtendimentoTratamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }
}