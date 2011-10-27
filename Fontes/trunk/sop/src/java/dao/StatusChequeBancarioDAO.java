package dao;

import annotations.StatusChequeBancario;
import org.hibernate.Session;

/**
 *
 * @author Fabricio P. Reis
 */
public class StatusChequeBancarioDAO {

    public StatusChequeBancarioDAO() {
    }

    public Short salvar(StatusChequeBancario statusChequeBancario) throws Exception {
        Short id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Short)session.save(statusChequeBancario);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(StatusChequeBancario statusChequeBancario) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(statusChequeBancario);
            //session.merge(statusChequeBancario);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(StatusChequeBancario statusChequeBancario) throws Exception {
       try{
            Session session = HibernateUtil.getSessao();
            session.delete(statusChequeBancario);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }
}