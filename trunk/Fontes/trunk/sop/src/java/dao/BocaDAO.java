package dao;

import annotations.Boca;
import annotations.Paciente;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class BocaDAO {

    public BocaDAO() {
    }

    public Integer salvar(Boca boca) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(boca);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(Boca boca) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(boca);
            //session.merge(boca);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(Boca boca) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(boca);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base registro de Boca com o id passado como parametro
     * Se existir, retorna objeto Boca
     * Senao retorna null
     */
    public Boca consultarId(Integer id) throws Exception {
        Boca out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Boca.class);
            criteria.add(Restrictions.eq("id", id));
            out = (Boca) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca na base a boca associada ao paciente passado como parametro
     * Se encontrar retorna um objeto Boca
     * Senao retorna null
     */
    public Boca consultarPaciente(Paciente paciente) throws Exception {
        Boca out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Boca.class);
            criteria.add(Restrictions.eq("paciente", paciente));
            criteria.setFetchMode("paciente", FetchMode.JOIN);
            out = (Boca) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca na base registro de Boca com o id passado como parametro
     * fazendo join com a tabela 'paciente'
     * Se existir, retorna objeto Boca
     * Senao retorna null
     */
    public Boca consultarIdXPaciente(Integer id) throws Exception {
        Boca out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Boca.class);
            criteria.add(Restrictions.eq("id", id));
            criteria.setFetchMode("paciente", FetchMode.JOIN);
            out = (Boca) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }
}