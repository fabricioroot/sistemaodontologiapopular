package dao;

import annotations.FormaPagamento;
import java.util.Collection;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class FormaPagamentoDAO {

    public FormaPagamentoDAO() {
    }

    public Short salvar(FormaPagamento formaPagamento) throws Exception {
        Short id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Short)session.save(formaPagamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(FormaPagamento formaPagamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(formaPagamento);
            //session.merge(formaPagamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(FormaPagamento formaPagamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(formaPagamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base uma forma de pagamento com o id passado como parametro
     * Se existir retorna um objeto FormaPagamento
     * Senao retorna null
     */
    public FormaPagamento consultarId(Short id) throws Exception {
        FormaPagamento out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(FormaPagamento.class);
            criteria.add(Restrictions.eq("id", id));
            out = (FormaPagamento) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca todas formas de pagamento que possuam a parte inicial do nome ou o nome igual ao
     * passado no paramentro 'nome'
     */
    public List<FormaPagamento> consultarNome(String nome) throws Exception {
        List<FormaPagamento> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(FormaPagamento.class);
            criteria.add(Restrictions.like("nome", nome, MatchMode.START));
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca todas formas de pagamento que tenha o tipo passado como parametro
     * Se o parametro for vazio retorna todos
     */
    public List<FormaPagamento> consultarTipo(char tipo) throws Exception {
        List<FormaPagamento> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(FormaPagamento.class);
            if (!String.valueOf(tipo).trim().isEmpty()) {
                criteria.add(Restrictions.eq("tipo", tipo));
            }
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Retorna true se NAO existir registro igual ao parametro 'nome'
     * senao retorna false
     */
    public boolean validarNome(String nome) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(FormaPagamento.class);
            criteria.add(Restrictions.eq("nome", nome));
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
     * Retorna true se existir registro igual aos parametros 'nome' e 'id'
     * senao retorna false
     */
    public boolean validarEditarNome(String nome, Short id) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(FormaPagamento.class);
            criteria.add(Restrictions.eq("nome", nome));
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
     * Retorna true se NAO existir registro igual ao parametro 'descricao'
     * senao retorna false
     */
    public boolean validarDescricao(String descricao) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(FormaPagamento.class);
            criteria.add(Restrictions.eq("descricao", descricao));
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
     * Retorna true se existir registro igual aos parametros 'descricao' e 'id'
     * senao retorna false
     */
    public boolean validarEditarDescricao(String descricao, Short id) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(FormaPagamento.class);
            criteria.add(Restrictions.eq("descricao", descricao));
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
     * Busca na base todas Formas de Pagamento ativas ordenando pelo campo 'tipo'
     * Dessa forma, sao ordenadas primeiro as do tipo 'a vista' e sem seguida as do
     * tipo 'a prazo'
     * Retorna objeto Collection<FormaPagamento>
     */
    public Collection<FormaPagamento> consultarFormasDePagamentoAtivas() throws Exception {
        Collection<FormaPagamento> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(FormaPagamento.class);
            criteria.add(Restrictions.eq("status", 'A'));
            criteria.addOrder(Order.asc("tipo"));
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }
}