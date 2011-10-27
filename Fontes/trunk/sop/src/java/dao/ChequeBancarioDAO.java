package dao;

import annotations.ChequeBancario;
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
public class ChequeBancarioDAO {

    public ChequeBancarioDAO() {
    }

    public Integer salvar(ChequeBancario chequeBancario) throws Exception {
        Integer id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Integer)session.save(chequeBancario);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(ChequeBancario chequeBancario) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(chequeBancario);
            //session.merge(chequeBancario);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(ChequeBancario chequeBancario) throws Exception {
         try{
            Session session = HibernateUtil.getSessao();
            session.delete(chequeBancario);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca na base registro de cheque bancario com o id passado como parametro
     * Se encontrar, retorna objeto ChequeBancario
     * Senao retorna null
     */
    public ChequeBancario consultarId(Integer id) throws Exception {
        ChequeBancario resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(ChequeBancario.class);
            criteria.add(Restrictions.eq("id", id));
            criteria.setFetchMode("pagamento", FetchMode.JOIN);
            resultado = (ChequeBancario)criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }

    /*
     * Busca todos cheques bancarios que possuam o numero passado como parametro
     */
    public List<ChequeBancario> consultarNumero(String numero) throws Exception {
        List<ChequeBancario> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(ChequeBancario.class);
            if (!numero.isEmpty()) {
                criteria.add(Restrictions.eq("numero", numero));
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
     * Busca todos cheques bancarios que possuam a dataParaDepositar
     * entre as datas passadas como parametro
     */
    public List<ChequeBancario> consultarPeriodoDataParaDepositar(Date dataInicio, Date dataFim) throws Exception {
        List<ChequeBancario> resultado = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(ChequeBancario.class);
            criteria.add(Restrictions.between("dataParaDepositar", dataInicio, dataFim) );
            resultado = criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return resultado;
    }
}