package dao;

import annotations.StatusProcedimento;
import org.hibernate.Session;

/**
 *
 * @author Fabricio P. Reis
 */
public class StatusProcedimentoDAO {

    public StatusProcedimentoDAO() {
    }

    public Short salvar(StatusProcedimento statusProcedimento) throws Exception {
        Short id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Short)session.save(statusProcedimento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(StatusProcedimento statusProcedimento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(statusProcedimento);
            //session.merge(atendimentoOrcamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(StatusProcedimento statusProcedimento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(statusProcedimento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }
}