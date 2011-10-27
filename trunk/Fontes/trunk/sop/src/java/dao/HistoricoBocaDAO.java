package dao;

import annotations.Boca;
import annotations.HistoricoBoca;
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
public class HistoricoBocaDAO {

    public HistoricoBocaDAO() {
    }

    public Integer salvar(HistoricoBoca historicoBoca) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(historicoBoca);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(HistoricoBoca historicoBoca) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(historicoBoca);
            //session.merge(historicoBoca);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(HistoricoBoca historicoBoca) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(historicoBoca);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base registro de historicoBoca com o id passado como paramentro
     * Se encontrar, retorna objeto HistoricoBoca
     * Senao, retorna null
     */
    public HistoricoBoca consultarId(Integer id) throws Exception {
        HistoricoBoca out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(HistoricoBoca.class);
            criteria.add(Restrictions.eq("id", id));
            out = (HistoricoBoca) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }

    /*
     * Busca registros 'historicoBoca' associados a boca passada como parametro,
     * ordenando de forma descendente pelo campo 'dataHora'
     * Se encontrar retorna objeto Collection<HistoricoBoca>
     */
    public Collection<HistoricoBoca> consultarBocaOrdenadoDescData(Boca boca) throws Exception {
        Collection<HistoricoBoca> resultado = new ArrayList<HistoricoBoca>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(HistoricoBoca.class);
            criteria.add(Restrictions.eq("boca", boca));
            criteria.setFetchMode("dentista", FetchMode.JOIN);
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
     * Busca o historico da boca passada como parametro que esteja orcado,
     * ordenando de forma descendente pelo campo 'dataHora'
     * Se encontrar retorna objeto List<HistoricoBoca>
     * Senao retorna null
     */
    public Collection<HistoricoBoca> consultarBocaOrcadoOrdenadoDescData(Boca boca) throws Exception {
        Collection<HistoricoBoca> resultado = new ArrayList<HistoricoBoca>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(HistoricoBoca.class);
            criteria.add(Restrictions.eq("boca", boca));
            criteria.add(Restrictions.eq("statusProcedimento", StatusProcedimentoService.getStatusProcedimentoOrcado()));
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
     * Busca o historico da boca passada como parametro que NAO esteja orcado,
     * ordenando de forma descendente pelo campo 'dataHora'
     * Retorna objeto Collection<HistoricoBoca>
     */
    public Collection<HistoricoBoca> consultarBocaDiferenteDeOrcadoOrdenadoDescData(Boca boca) throws Exception {
        Collection<HistoricoBoca> resultado = new ArrayList<HistoricoBoca>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(HistoricoBoca.class);
            criteria.add(Restrictions.eq("boca", boca));
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
     * Busca registros de historicoBoca com status 'liberado (pago)'
     * da boca passada como parametro
     * Retorna objeto Collection<HistoricoBoca>
     */
    public Collection<HistoricoBoca> consultarHistoricosBocaLiberados(Boca boca) throws Exception {
        Collection<HistoricoBoca> resultado = new ArrayList<HistoricoBoca>();
        try {
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(HistoricoBoca.class);
            criteria.add(Restrictions.eq("boca", boca));
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