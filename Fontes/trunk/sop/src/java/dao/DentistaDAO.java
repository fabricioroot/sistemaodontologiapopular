package dao;

import annotations.Dentista;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class DentistaDAO {

    final static String INSERT = "INSERT INTO dentista (id, cro, especialidade, comissaoOrcamento, comissaoTratamento) VALUES ( ?, ?, ?, ?, ?)";

    public DentistaDAO() {
    }

    public Integer salvar(Dentista dentista) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(dentista);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(Dentista dentista) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(dentista);
            //session.merge(dentista);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(Dentista dentista) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(dentista);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base um dentista com o id passado como paramentro
     * Se existir retorna um objeto Dentista
     * Senao retorna null
     */
    public Dentista consultarId(Integer id) throws Exception {
        Dentista out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Dentista.class);
            criteria.add(Restrictions.eq("id", id));
            criteria.setFetchMode("grupoAcessoSet", FetchMode.JOIN);
            out = (Dentista) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Retorna true se NAO existir registro igual ao parametro 'cro'
     * senao retorna false
     */
    public boolean validarCro(String cro) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Dentista.class);
            criteria.add(Restrictions.eq("cro", cro));
            List resultado = criteria.list();
            out = resultado.size() > 0 ? false : true;
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Retorna true se existir registro igual aos parametros 'cro' e 'id'
     * senao retorna false
     */
    public boolean validarEditarCro(String cro, Integer id) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Dentista.class);
            criteria.add(Restrictions.eq("cro", cro));
            criteria.add(Restrictions.eq("id", id));
            List resultado = criteria.list();
            out = resultado.size() > 0 ? true : false;
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Retorna false se existir registro igual ao parametro 'id'
     * senao retorna true
     */
    public boolean validarId(Integer id) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Dentista.class);
            criteria.add(Restrictions.eq("id", id));
            List resultado = criteria.list();
            out = resultado.size() > 0 ? true : false;
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Insere registro na tabela de dentista
     * O parametro 'id' deve ser igual a um registro da tabela pessoa
     */
    public boolean inserirRegistroDentista(Integer id, String cro, String especialidade, Double comissaoOrcamento, Double comissaoTratamento) throws Exception {
        Integer out = 0;
        try{
            Session session = HibernateUtil.getSessao();
            SQLQuery sqlQuery = session.createSQLQuery(INSERT);
            sqlQuery.setParameter(0, id);
            sqlQuery.setParameter(1, cro);
            sqlQuery.setParameter(2, especialidade);
            sqlQuery.setParameter(3, comissaoOrcamento);
            sqlQuery.setParameter(4, comissaoTratamento);
            out = sqlQuery.executeUpdate();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out == 0 ? false : true;
    }
}