package dao;

import annotations.Funcionario;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class FuncionarioDAO {

    public FuncionarioDAO() {
    }

    public Integer salvar(Funcionario funcionario) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(funcionario);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(Funcionario funcionario) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(funcionario);
            //session.merge(funcionario);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(Funcionario funcionario) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(funcionario);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base um funcionario com o id passado como parametro
     * Se existir retorna um objeto Funcionario
     * Senao retorna null
     */
    public Funcionario consultarId(Integer id) throws Exception {
        Funcionario out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Funcionario.class);
            criteria.add(Restrictions.eq("id", id));
            criteria.setFetchMode("grupoAcessoSet", FetchMode.JOIN);
            out = (Funcionario) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca todos funcionarios que possuam a parte inicial do nome ou o nome igual ao
     * passado no paramentro 'nome'
     * Com excecao do usuario de ID: 2 - dentista-sistema
     */
    public List<Funcionario> consultarNome(String nome) throws Exception {
        List<Funcionario> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Funcionario.class);
            criteria.add(Restrictions.like("nome", nome, MatchMode.START));
            criteria.add(Restrictions.ne("id", 2));  // Usado para nao buscar o usuario 'dentista-sistema' (ID = 2)
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca registro de funcionario com o nomeDeUsuario igual ao
     * passado no paramentro 'nomeDeUsuario'
     * Com excecao do usuario de ID: 2 - dentista-sistema
     */
    public Funcionario consultarNomeDeUsuario(String nomeDeUsuario) throws Exception {
        Funcionario resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Funcionario.class);
            criteria.add(Restrictions.eq("nomeDeUsuario", nomeDeUsuario));
            criteria.add(Restrictions.ne("id", 2));  // Usado para nao buscar o usuario 'dentista-sistema' (ID = 2)
            resultado = (Funcionario) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Verifica o cadastro de um funcionario a partir de um nome de usuario e senha
     * Se o funcionario passado como parametro existir na base, retorna um objeto do TAD Funcionario
     * Senao retorna null
     */
    public Funcionario validarLogin(Funcionario funcionario) throws Exception {
        Funcionario out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Funcionario.class);
            criteria.add(Restrictions.eq("nomeDeUsuario", funcionario.getNomeDeUsuario()));
            criteria.add(Restrictions.eq("senha", funcionario.getSenha()));
            criteria.add(Restrictions.eq("status", "A"));
            criteria.setFetchMode("grupoAcessoSet", FetchMode.JOIN);
            out = (Funcionario) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Retorna true se NAO existir registro igual ao parametro 'nomeDeUsuario'
     * senao retorna false
     */
    public boolean validarNomeDeUsuario(String nomeDeUsuario) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Funcionario.class);
            criteria.add(Restrictions.eq("nomeDeUsuario", nomeDeUsuario));
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
     * Retorna true se existir registro igual aos parametros 'nomeDeUsuario' e 'id'
     * senao retorna false
     */
    public boolean validarEditarNomeDeUsuario(String nomeDeUsuario, Integer id) throws Exception {
        boolean out = false;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Funcionario.class);
            criteria.add(Restrictions.eq("nomeDeUsuario", nomeDeUsuario));
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