package dao;

import annotations.AtendimentoOrcamento;
import annotations.Ficha;
import annotations.FilaAtendimentoOrcamento;
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
public class AtendimentoOrcamentoDAO {

    public AtendimentoOrcamentoDAO() {
    }

    public Integer salvar(AtendimentoOrcamento atendimentoOrcamento) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(atendimentoOrcamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(AtendimentoOrcamento atendimentoOrcamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(atendimentoOrcamento);
            //session.merge(atendimentoOrcamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(AtendimentoOrcamento atendimentoOrcamento) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(atendimentoOrcamento);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base um atendimentoOrcamento com o id passado como paramentro
     * Se existir retorna um objeto AtendimentoOrcamento
     * Senao retorna null
     */
    public AtendimentoOrcamento consultarId(Integer id) throws Exception {
        AtendimentoOrcamento resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(AtendimentoOrcamento.class);
            criteria.add(Restrictions.eq("id", id));
            resultado = (AtendimentoOrcamento)criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca todos registros de atendimento de orcamentos que estao na fila passada como parametro
     * ordenando por prioridade e data
     */
    public Collection<AtendimentoOrcamento> consultarFilaAtendimentoOrcamento(FilaAtendimentoOrcamento filaAtendimentoOrcamento) throws Exception {
        Collection<AtendimentoOrcamento> resultado = new ArrayList<AtendimentoOrcamento>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(AtendimentoOrcamento.class);
            // Busca todos registros de atendimentoOrcamento presentes na fila de atendimento, que foram priorizados
            // e os ordena de forma crescente pela data de criacao
            criteria.add(Restrictions.eq("filaAtendimentoOrcamento", filaAtendimentoOrcamento));
            criteria.add(Restrictions.eq("prioridade", Boolean.TRUE));
            criteria.add(Restrictions.eq("dentista", DentistaService.getDentistaSistema()));
            criteria.add(Restrictions.isNull("dataInicio"));
            criteria.add(Restrictions.isNull("dataFim"));
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            criteria.setFetchMode("ficha.paciente", FetchMode.JOIN);
            criteria.addOrder(Order.asc("dataCriacao"));
            Collection<AtendimentoOrcamento> parcial1 = new ArrayList<AtendimentoOrcamento>();
            parcial1 = criteria.list();

            Criteria criteria2 = session.createCriteria(AtendimentoOrcamento.class);
            // Busca todos registros de atendimentoOrcamento presentes na fila de atendimento, que nao foram priorizados
            // e os ordena de forma crescente pela data de criacao
            criteria2.add(Restrictions.eq("filaAtendimentoOrcamento", filaAtendimentoOrcamento));
            criteria2.add(Restrictions.eq("prioridade", Boolean.FALSE));
            criteria2.add(Restrictions.eq("dentista", DentistaService.getDentistaSistema()));
            criteria2.add(Restrictions.isNull("dataInicio"));
            criteria2.add(Restrictions.isNull("dataFim"));
            criteria2.setFetchMode("ficha", FetchMode.JOIN);
            criteria2.setFetchMode("ficha.paciente", FetchMode.JOIN);
            criteria2.addOrder(Order.asc("dataCriacao"));
            Collection<AtendimentoOrcamento> parcial2 = new ArrayList<AtendimentoOrcamento>();
            parcial2 = criteria2.list();

            // Monta Collection<AtendimentoOrcamento> contendo os dados buscados anteriormente
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
     * Busca todos registros de atendimento de orcamentos que estao em atendimento
     * ordenados pela data de inicio
     */
    public Collection<AtendimentoOrcamento> consultarFilaAtendimentoOrcamentoEmAtendimento(FilaAtendimentoOrcamento filaAtendimentoOrcamentoEmAtendimento) throws Exception {
        Collection<AtendimentoOrcamento> resultado = new ArrayList<AtendimentoOrcamento>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(AtendimentoOrcamento.class);
            criteria.add(Restrictions.eq("filaAtendimentoOrcamento", filaAtendimentoOrcamentoEmAtendimento));
            criteria.add(Restrictions.isNotNull("dataInicio"));
            criteria.add(Restrictions.isNull("dataFim"));
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            criteria.setFetchMode("ficha.paciente", FetchMode.JOIN);
            criteria.setFetchMode("dentista", FetchMode.JOIN);
            criteria.addOrder(Order.asc("dataInicio"));
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca registro de atendimentoOrcamento para a ficha passada como parametro, que nao foi iniciado.
     * Se encontrar, retorna objeto AtendimentoOrcamento
     * Senao, retorna null
     */
    public AtendimentoOrcamento consultarAtendimentoOrcamentoNaoIniciado(Ficha ficha) throws Exception {
        AtendimentoOrcamento resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(AtendimentoOrcamento.class);
            criteria.add(Restrictions.isNull("dataInicio"));
            criteria.add(Restrictions.isNull("dataFim"));
            criteria.add(Restrictions.eq("ficha", ficha));
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            resultado = (AtendimentoOrcamento) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca registro de atendimentoOrcamento para a ficha passada como parametro, que nao foi iniciado nem priorizado.
     * Se encontrar, retorna objeto AtendimentoOrcamento
     * Senao, retorna null
     */
    public AtendimentoOrcamento consultarAtendimentoOrcamentoNaoIniciadoNaoPriorizado(Ficha ficha) throws Exception {
        AtendimentoOrcamento resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(AtendimentoOrcamento.class);
            criteria.add(Restrictions.isNull("dataInicio"));
            criteria.add(Restrictions.isNull("dataFim"));
            criteria.add(Restrictions.eq("prioridade", false));
            criteria.add(Restrictions.eq("ficha", ficha));
            criteria.setFetchMode("ficha", FetchMode.JOIN);
            resultado = (AtendimentoOrcamento) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }
}