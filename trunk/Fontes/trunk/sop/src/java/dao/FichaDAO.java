package dao;

import annotations.Ficha;
import annotations.Paciente;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class FichaDAO {

    public FichaDAO() {
    }

    public Integer salvar(Ficha ficha) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(ficha);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(Ficha ficha) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(ficha);
            //session.merge(ficha);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(Ficha ficha) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(ficha);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base registro de ficha com o id passado como parametro
     * Se encontrar, retorna objeto Ficha
     * Senao retorna null
     */
    public Ficha consultarId(Integer id) throws Exception {
        Ficha out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Ficha.class);
            criteria.add(Restrictions.eq("id", id));
            out = (Ficha) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca na base a ficha associada ao paciente passado como parametro
     * Se encontrar retorna um objeto Ficha
     * Senao retorna null
     */
    public Ficha consultarPaciente(Paciente paciente) throws Exception {
        Ficha out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Ficha.class);
            criteria.add(Restrictions.eq("paciente", paciente));
            criteria.setFetchMode("paciente", FetchMode.JOIN);
            out = (Ficha) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }
}