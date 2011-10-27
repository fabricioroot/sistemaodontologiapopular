package dao;

import annotations.Dente;
import annotations.HistoricoDente;
import annotations.Boca;
import java.util.ArrayList;
import java.util.Collection;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import service.StatusProcedimentoService;

/**
 *
 * @author Fabricio P. Reis
 */
public class HistoricoDenteDAO {

    public HistoricoDenteDAO() {
    }

    public Integer salvar(HistoricoDente historicoDente) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(historicoDente);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(HistoricoDente historicoDente) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(historicoDente);
            //session.merge(historicoBoca);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(HistoricoDente historicoDente) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(historicoDente);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base um historicoDente com o id passado como paramentro
     * Se existir retorna um objeto HistoricoDente
     * Senao retorna null
     */
    public HistoricoDente consultarId(Integer id) throws Exception {
        HistoricoDente out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(HistoricoDente.class);
            criteria.add(Restrictions.eq("id", id));
            out = (HistoricoDente) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca registros 'historicoDente' do dente passado como parametro,
     * ordenando de forma descendente pelo campo 'dataHora'
     * Retorna objeto Collection<HistoricoDente>
     */
    public Collection<HistoricoDente> consultarDenteOrdenadoDescData(Dente dente) throws Exception {
        Collection<HistoricoDente> resultado = new ArrayList<HistoricoDente>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(HistoricoDente.class);
            criteria.add(Restrictions.eq("dente", dente));
            criteria.setFetchMode("dentista", FetchMode.JOIN);
            criteria.addOrder(Order.asc("dataHora"));
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca o historico do dente passado como parametro que esteja orcado,
     * ordenando de forma descendente pelo campo 'dataHora'
     * Se encontrar retorna objeto Collection<HistoricoDente>
     * Senao retorna null
     */
    public Collection<HistoricoDente> consultarDenteOrcadoPagoTratandoOrdenadoDescData(Dente dente) throws Exception {
        Collection<HistoricoDente> resultado = new ArrayList<HistoricoDente>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(HistoricoDente.class);
            criteria.add(Restrictions.eq("dente", dente));
            Collection statusOrcadoPagoTratando = new ArrayList();
            statusOrcadoPagoTratando.add(StatusProcedimentoService.getStatusProcedimentoOrcado());
            statusOrcadoPagoTratando.add(StatusProcedimentoService.getStatusProcedimentoPago());
            statusOrcadoPagoTratando.add(StatusProcedimentoService.getStatusProcedimentoEmTratamento());
            criteria.add(Restrictions.in("statusProcedimento", statusOrcadoPagoTratando));
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
     * Busca o historico do dente passado como parametro que NAO esteja orcado,
     * ordenando de forma descendente pelo campo 'dataHora'
     * Retorna objeto Collection<HistoricoDente>
     */
    public Collection<HistoricoDente> consultarDenteDiferenteDeOrcadoOrdenadoDescData(Dente dente) throws Exception {
        Collection<HistoricoDente> resultado = new ArrayList<HistoricoDente>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(HistoricoDente.class);
            criteria.add(Restrictions.eq("dente", dente));
            criteria.add(Restrictions.ne("statusProcedimento", StatusProcedimentoService.getStatusProcedimentoOrcado()));
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
     * Busca registros de historicoDente com status 'liberado (pago)' da boca passada como parametro
     * Retorna objeto Collection<HistoricoDente>
     */
    public Collection<HistoricoDente> consultarHistoricosDentesLiberados(Boca boca) throws Exception {
        Collection<HistoricoDente> resultado = new ArrayList<HistoricoDente>();
        try {
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(HistoricoDente.class);
            criteria.setFetchMode("dente", FetchMode.JOIN);
            criteria.createAlias("dente.boca", "boca");
            criteria.add(Restrictions.eq("boca.id", boca.getId()));
            criteria.add(Restrictions.eq("statusProcedimento", StatusProcedimentoService.getStatusProcedimentoPago()));
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }
}