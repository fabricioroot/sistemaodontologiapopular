package dao;

import annotations.Procedimento;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class ProcedimentoDAO {

    public ProcedimentoDAO() {
    }

    public Short salvar(Procedimento procedimento) throws Exception {
        Short id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Short)session.save(procedimento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(Procedimento procedimento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(procedimento);
            //session.merge(procedimento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(Procedimento procedimento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(procedimento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base o procedimento com o id passado como parametro
     * Se encontrar, retorna objeto 'Procedimento'
     * Senao retorna null
     */
    public Procedimento consultarId(Short id) throws Exception {
        Procedimento procedimento = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Procedimento.class);
            criteria.add(Restrictions.eq("id", id));
            procedimento = (Procedimento)criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return procedimento;
    }

    /*
     * Busca todos procedimentos que possuam a parte inicial do nome ou o nome igual ao
     * passado no paramentro 'nome'
     */
    public List<Procedimento> consultarNome(String nome) throws Exception {
        List<Procedimento> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Procedimento.class);
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
     * Busca na base todos procedimentos de parte de dente e dente inteiro ativos
     * Retorna objeto Collection<Procedimento>
     */
    public Collection<Procedimento> consultarProcedimentosPDDIAtivos() throws Exception {
        Collection<String> condicoesTipo = new ArrayList<String>();
        condicoesTipo.add("PD");  // Parte dente
        condicoesTipo.add("DI");  // Dente inteiro
        Collection<Procedimento> resultado = new ArrayList<Procedimento>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Procedimento.class);
            criteria.add(Restrictions.eq("status", 'A'));
            criteria.add(Restrictions.in("tipo", condicoesTipo));
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca na base todos procedimentos de boca completa ativos
     * Retorna objeto Collection<Procedimento>
     */
    public Collection<Procedimento> consultarProcedimentosBCAtivos() throws Exception {
        Collection<Procedimento> resultado = new ArrayList<Procedimento>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Procedimento.class);
            criteria.add(Restrictions.eq("status", 'A'));
            criteria.add(Restrictions.eq("tipo", "BC"));
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
            Criteria criteria = session.createCriteria(Procedimento.class);
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
            Criteria criteria = session.createCriteria(Procedimento.class);
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
            Criteria criteria = session.createCriteria(Procedimento.class);
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
            Criteria criteria = session.createCriteria(Procedimento.class);
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
}