package dao;

import annotations.ComprovantePagamentoCartao;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class ComprovantePagamentoCartaoDAO {

    public ComprovantePagamentoCartaoDAO() {
    }

    public Integer salvar(ComprovantePagamentoCartao comprovantePagamentoCartao) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(comprovantePagamentoCartao);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(ComprovantePagamentoCartao comprovantePagamentoCartao) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(comprovantePagamentoCartao);
            //session.merge(comprovantePagamentoCartao);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(ComprovantePagamentoCartao comprovantePagamentoCartao) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(comprovantePagamentoCartao);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base registro de ComprovantePagamentoCartao com o id passado como parametro
     * Se encontrar, retorna objeto ComprovantePagamentoCartao
     * Senao retorna null
     */
    public ComprovantePagamentoCartao consultarId(Integer id) throws Exception {
        ComprovantePagamentoCartao resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(ComprovantePagamentoCartao.class);
            criteria.add(Restrictions.eq("id", id));
            criteria.setFetchMode("pagamento", FetchMode.JOIN);
            resultado = (ComprovantePagamentoCartao)criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca todos comprovantes de pagamento de cartao que possuam o codigo de autorizacao passado como parametro
     */
    public List<ComprovantePagamentoCartao> consultarCodigoAutorizacao(String codigoAutorizacao) throws Exception {
        List<ComprovantePagamentoCartao> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(ComprovantePagamentoCartao.class);
            if (!codigoAutorizacao.isEmpty()) {
                criteria.add(Restrictions.eq("codigoAutorizacao", codigoAutorizacao));
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
     * Busca todos comprovantes de pagamento cartao que possuam dataPagamento
     * entre as datas passadas como parametros
     */
    public List<ComprovantePagamentoCartao> consultarPeriodoDataPagamento(Date dataInicio, Date dataFim) throws Exception {
        List<ComprovantePagamentoCartao> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(ComprovantePagamentoCartao.class);
            criteria.add(Restrictions.between("dataPagamento", dataInicio, dataFim) );
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }
}