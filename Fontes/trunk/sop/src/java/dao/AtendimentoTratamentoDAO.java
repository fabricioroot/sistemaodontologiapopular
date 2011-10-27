package dao;

import annotations.AtendimentoTratamento;
import annotations.Ficha;
import annotations.FilaAtendimentoTratamento;
import java.util.ArrayList;
import java.util.Collection;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import service.DentistaService;

/**
 *
 * @author Fabricio P. Reis
 */
public class AtendimentoTratamentoDAO {

    public AtendimentoTratamentoDAO() {
    }

    public Integer salvar(AtendimentoTratamento atendimentoTratamento) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(atendimentoTratamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(AtendimentoTratamento atendimentoTratamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(atendimentoTratamento);
            //session.merge(atendimentoTratamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(AtendimentoTratamento atendimentoTratamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(atendimentoTratamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base um atendimentoTratamento com o id passado como paramentro
     * Se existir retorna um objeto AtendimentoTratamento
     * Senao retorna null
     */
    public AtendimentoTratamento consultarId(Integer id) throws Exception {
        AtendimentoTratamento resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(AtendimentoTratamento.class);
            criteria.add(Restrictions.eq("id", id));
            resultado = (AtendimentoTratamento)criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca todos registros de atendimento tratamento que estao na fila passada como parametro
     * ordenados por prioridade e data
     */
    public Collection<AtendimentoTratamento> consultarFilaAtendimentoTratamento(FilaAtendimentoTratamento filaAtendimentoTratamento) throws Exception {
        Collection<AtendimentoTratamento> resultado = new ArrayList<AtendimentoTratamento>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(AtendimentoTratamento.class);
            // Busca todos registros de atendimentoTratamento presentes na fila de atendimento, que foram priorizados
            // e os ordena de forma crescente pela data de criacao
            criteria.add(Restrictions.eq("filaAtendimentoTratamento", filaAtendimentoTratamento));
            criteria.add(Restrictions.eq("prioridade", Boolean.TRUE));
            criteria.add(Restrictions.eq("dentista", DentistaService.getDentistaSistema()));
            criteria.add(Restrictions.isNull("dataInicio"));
            criteria.add(Restrictions.isNull("dataFim"));
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            criteria.setFetchMode("ficha.paciente", FetchMode.JOIN);
            criteria.addOrder(Order.asc("dataCriacao"));
            Collection<AtendimentoTratamento> parcial1 = new ArrayList<AtendimentoTratamento>();
            parcial1 = criteria.list();

            Criteria criteria2 = session.createCriteria(AtendimentoTratamento.class);
            // Busca todos registros de atendimentoTratamento presentes na fila de atendimento, que nao foram priorizados
            // e os ordena de forma crescente pela data de criacao
            criteria2.add(Restrictions.eq("filaAtendimentoTratamento", filaAtendimentoTratamento));
            criteria2.add(Restrictions.eq("prioridade", Boolean.FALSE));
            criteria2.add(Restrictions.eq("dentista", DentistaService.getDentistaSistema()));
            criteria2.add(Restrictions.isNull("dataInicio"));
            criteria2.add(Restrictions.isNull("dataFim"));
            criteria2.setFetchMode("ficha", FetchMode.JOIN);
            criteria2.setFetchMode("ficha.paciente", FetchMode.JOIN);
            criteria2.addOrder(Order.asc("dataCriacao"));
            Collection<AtendimentoTratamento> parcial2 = new ArrayList<AtendimentoTratamento>();
            parcial2 = criteria2.list();

            // Monta Collection<AtendimentoTratamento> contendo os dados buscados anteriormente
            // onde os priorizados sao os primeiros a serem inseridos na fila
            if (!parcial1.isEmpty()) {
                resultado.addAll(parcial1);
            }
            if (!parcial2.isEmpty()) {
                resultado.addAll(parcial2);
            }
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca todos registros de atendimento de tratamento que estao em atendimento
     * ordenados pela data de inicio
     */
    public Collection<AtendimentoTratamento> consultarFilaAtendimentoTratamentoEmAtendimento(FilaAtendimentoTratamento filaAtendimentoTratamentoEmAtendimento) throws Exception {
        Collection<AtendimentoTratamento> resultado = new ArrayList<AtendimentoTratamento>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(AtendimentoTratamento.class);
            criteria.add(Restrictions.eq("filaAtendimentoTratamento", filaAtendimentoTratamentoEmAtendimento));
            criteria.add(Restrictions.isNull("dataFim"));
            criteria.add(Restrictions.isNotNull("dataInicio"));
            criteria.addOrder(Order.asc("dataInicio"));
            criteria.setFetchMode("dentista", FetchMode.JOIN);
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            criteria.setFetchMode("ficha.paciente", FetchMode.JOIN);
            resultado.addAll(criteria.list());
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca registro de atendimentoTratamento para a ficha passada como parametro, que nao foi iniciado.
     * Se encontrar, retorna objeto AtendimentoTratamento
     * Senao, retorna null
     */
    public AtendimentoTratamento consultarAtendimentoTratamentoNaoIniciado(Ficha ficha) throws Exception {
        AtendimentoTratamento resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(AtendimentoTratamento.class);
            criteria.add(Restrictions.isNull("dataInicio"));
            criteria.add(Restrictions.isNull("dataFim"));
            criteria.add(Restrictions.eq("ficha", ficha));
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            resultado = (AtendimentoTratamento) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca registro de atendimentoTratamento para a ficha passada como parametro, que nao foi iniciado nem priorizado.
     * Se encontrar, retorna objeto AtendimentoTratamento
     * Senao, retorna null
     */
    public AtendimentoTratamento consultarAtendimentoTratamentoNaoIniciadoNaoPriorizado(Ficha ficha) throws Exception {
        AtendimentoTratamento resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(AtendimentoTratamento.class);
            criteria.add(Restrictions.isNull("dataInicio"));
            criteria.add(Restrictions.isNull("dataFim"));
            criteria.add(Restrictions.eq("prioridade", false));
            criteria.add(Restrictions.eq("ficha", ficha));
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            resultado = (AtendimentoTratamento) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }
}