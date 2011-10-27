package dao;

import annotations.Endereco;
import annotations.Pessoa;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class EnderecoDAO {

    public EnderecoDAO() {
    }

    public Integer salvar(Endereco endereco) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(endereco);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(Endereco endereco) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(endereco);
            //session.merge(endereco);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(Endereco endereco) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(endereco);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }
    
    /*
     * Busca na base o endereco associado ao objeto pessoa passado como parametro
     * Se existir retorna objeto Endereco
     * Senao retorna null
     */
    public Endereco consultarPessoa(Pessoa pessoa) throws Exception {
        Endereco out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Endereco.class);
            criteria.add(Restrictions.eq("pessoa", pessoa));
            out = (Endereco) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca todos enderecos que possuam a parte inicial do logradouro ou o logradouro igual ao
     * passado no paramentro 'logradouro'
     */
    public List<Endereco> consultarLogradouro(String logradouro) throws Exception {
        List<Endereco> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Endereco.class);
            criteria.add(Restrictions.like("logradouro", logradouro, MatchMode.START));
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }
}