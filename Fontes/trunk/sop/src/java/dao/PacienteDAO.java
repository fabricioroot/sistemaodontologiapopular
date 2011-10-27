package dao;

import annotations.Paciente;
import java.util.ArrayList;
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
public class PacienteDAO {

    public PacienteDAO() {
    }

    public Integer salvar(Paciente paciente) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(paciente);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(Paciente paciente) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(paciente);
            //session.merge(paciente);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(Paciente paciente) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(paciente);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base o paciente com o id passado como parametro
     * Se existir retorna o objeto encontrado
     * Senao, retorna null
     */
    public List<Paciente> consultarId(Integer id) throws Exception {
        List<Paciente> pacientes = new ArrayList<Paciente>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Paciente.class);
            if (id != null) {
                criteria.add(Restrictions.eq("id", id));
                criteria.add(Restrictions.ne("id", 3));  // Usado para nao retornar o usuario 'Paciente-Sistema' (ID = 3)
            }
            else {
                criteria.add(Restrictions.ne("id", 3));  // Usado para nao retornar o usuario 'Paciente-Sistema' (ID = 3)
            }
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            pacientes = (List<Paciente>)criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return pacientes;
    }

    /*
     * Busca todos pacientes que possuam a parte inicial do nome ou o nome igual ao
     * passado como paramentro
     */
    public List<Paciente> consultarNome(String nome) throws Exception {
        List<Paciente> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Paciente.class);
            criteria.add(Restrictions.like("nome", nome, MatchMode.START));
            criteria.add(Restrictions.ne("id", 3));  // Usado para nao buscar o usuario 'Paciente-Sistema' (ID = 3)
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca paciente que tenha o cpf passado como parametro
     * Se o paramentro for vazio retorna List<Paciente> com todos pacientes
     * Este metodo retorna todos objetos quando passado null, pois ele eh
     * usado na tela consultarPaciente
     */
    public List<Paciente> consultarCpf(String cpf) throws Exception {
        List<Paciente> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Paciente.class);
            if (!cpf.isEmpty()) {
                criteria.add(Restrictions.eq("cpf", cpf));
                criteria.add(Restrictions.ne("id", 3));  // Usado para nao buscar o usuario 'Paciente-Sistema' (ID = 3)
            }
            else {
                criteria.add(Restrictions.ne("id", 3));  // Usado para nao buscar o usuario 'Paciente-Sistema' (ID = 3)
            }
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca todos pacientes que tem a parte inicial do logradouro ou o logradouro igual ao
     * passado no paramentro 'logradouro'
     */
    public List<Paciente> consultarLogradouro(String logradouro) throws Exception {
        List<Paciente> resultado = new ArrayList<Paciente>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(Paciente.class);
            if (!logradouro.isEmpty()) {
                criteria.setFetchMode("endereco", FetchMode.JOIN);
                criteria.createAlias("endereco", "e");
                criteria.add(Restrictions.like("e.logradouro", logradouro, MatchMode.START));
            }
            else {
                criteria.add(Restrictions.ne("id", 3));  // Usado para nao buscar o usuario 'Paciente-Sistema' (ID = 3)
            }
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }
}