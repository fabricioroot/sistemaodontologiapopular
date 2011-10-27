package dao;

import annotations.Pessoa;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class PessoaDAO {

    public PessoaDAO() {
    }

    public Integer salvar(Pessoa pessoa) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(pessoa);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(Pessoa pessoa) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(pessoa);
            //session.merge(pessoa);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(Pessoa pessoa) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(pessoa);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Retorna true se NAO existir registro igual ao parametro 'cpf'
     * senao retorna false
     */
    public boolean validarCpf(String cpf) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Pessoa.class);
            criteria.add(Restrictions.eq("cpf", cpf));
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
     * Retorna true se existir registro igual aos parametros 'cpf' e 'id'
     * senao retorna false
     */
    public boolean validarEditarCpf(String cpf, Integer id) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Pessoa.class);
            criteria.add(Restrictions.eq("cpf", cpf));
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
     * Retorna true se NAO existir registro igual ao parametro 'rg'
     * senao retorna false
     */
    public boolean validarRg(String rg) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Pessoa.class);
            criteria.add(Restrictions.eq("rg", rg));
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
     * Retorna true se existir registro igual aos parametros 'rg' e 'id'
     * senao retorna false
     */
    public boolean validarEditarRg(String rg, Integer id) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Pessoa.class);
            criteria.add(Restrictions.eq("rg", rg));
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
}