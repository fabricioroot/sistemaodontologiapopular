package dao;

import annotations.Ficha;
import annotations.Pagamento;
import java.util.ArrayList;
import java.util.Collection;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class PagamentoDAO {

    public PagamentoDAO() {
    }

    public Integer salvar(Pagamento pagamento) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(pagamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(Pagamento pagamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(pagamento);
            //session.merge(pagamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(Pagamento pagamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(pagamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base registro de pagamento com o id passado como parametro
     * Se encontrar, retorna objeto Pagamento
     * Senao retorna null
     */
    public Pagamento consultarId(Integer id) throws Exception {
        Pagamento out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Pagamento.class);
            criteria.add(Restrictions.eq("id", id));
            out = (Pagamento) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca na base registros de pagamentos associados a ficha passada como parametro
     * Se encontrar, retorna objeto Collection<Pagamento>
     * Senao retorna null
     */
    public Collection<Pagamento> consultarPagamentos(Ficha ficha) throws Exception {
        Collection<Pagamento> resultado = new ArrayList<Pagamento>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Pagamento.class);
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            criteria.add(Restrictions.eq("ficha", ficha));
            criteria.addOrder(Order.desc("dataHora"));
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca na base registro de pagamento com o id passado como parametro
     * fazendo join com a tabela Ficha
     * Se encontrar, retorna objeto Pagamento
     * Senao retorna null
     */
    public Pagamento consultarFicha(Integer id) throws Exception {
        Pagamento resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Pagamento.class);
            criteria.add(Restrictions.eq("id", id));
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            resultado = (Pagamento)criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca na base registros de pagamentos da ficha passada como parametro,
     * ordenando de forma descendente pelo campo dataHora
     * Se encontrar, retorna objeto Collection<Pagamento>
     * Senao, retorna null
     */
    public Collection<Pagamento> consultarPagamentosOrdenadoDescData(Ficha ficha) throws Exception {
        Collection<Pagamento> resultado = new ArrayList<Pagamento>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Pagamento.class);
            criteria.add(Restrictions.eq("ficha", ficha));
            criteria.add(Restrictions.ne("valorFinal", Double.parseDouble("0")));
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            criteria.addOrder(Order.desc("dataHora"));
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca na base registro de pagamento com o id passado como parametro
     * fazendo join com as tabelas: Ficha e Paciente
     * Se encontrar, retorna objeto Pagamento
     * Senao retorna null
     */
    public Pagamento consultarFichaPaciente(Integer id) throws Exception {
        Pagamento resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Pagamento.class);
            criteria.add(Restrictions.eq("id", id));
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            criteria.setFetchMode("ficha.paciente", FetchMode.JOIN);
            resultado = (Pagamento)criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }
}