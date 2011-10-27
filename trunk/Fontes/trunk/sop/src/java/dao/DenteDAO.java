package dao;

import annotations.Boca;
import annotations.Dente;
import java.util.HashSet;
import java.util.Set;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class DenteDAO {

    public DenteDAO() {
    }

    public void salvarOuAtualizar(Dente dente) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.saveOrUpdate(dente);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void atualizar(Dente dente) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(dente);
            //session.merge(dente);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(Dente dente) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(dente);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base registro de Dente com o id passado como parametro
     * Se existir retorna objeto Dente
     * Senao retorna null
     */
    public Dente consultarId(Integer id) throws Exception {
        Dente out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Dente.class);
            criteria.add(Restrictions.eq("id", id));
            out = (Dente) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca na base registro de Dente para a boca e id passados como parametros
     * Se encontrar, retorna objeto Dente
     * Senao retorna null
     */
    public Dente consultarDente(Boca boca, Integer id) throws Exception {
        Dente out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Dente.class);
            criteria.add(Restrictions.eq("id", id));
            criteria.setFetchMode("boca", FetchMode.JOIN);
            criteria.setFetchMode("boca.paciente", FetchMode.JOIN);
            out = (Dente) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca registros de 'Dente' da boca passada como parametro
     * Retorna objeto Set<Dente>
     */
    public Set<Dente> consultarDentes(Boca boca) throws Exception {
        Set<Dente> out = new HashSet<Dente>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Dente.class);
            criteria.add(Restrictions.eq("boca", boca));
            criteria.setFetchMode("boca", FetchMode.JOIN);
            out.addAll(criteria.list());
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca registro no banco do Dente passado como parametro, fazendo join com HistoricoDente
     * Se encontrar, retorna objeto Dente
     * Senao retorna null
     */
    public Dente consultarHistoricoDente(Dente dente) throws Exception {
        Dente out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Dente.class);
            criteria.add(Restrictions.eq("id", dente.getId()));
            criteria.setFetchMode("historicoDenteSet", FetchMode.JOIN);
            out = (Dente) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }
}