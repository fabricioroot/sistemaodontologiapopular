package dao;

import annotations.GrupoAcesso;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Fabricio P. Reis
 */
public class GrupoAcessoDAO {

    public GrupoAcessoDAO() {
    }

    public Short salvar(GrupoAcesso grupoAcesso) throws Exception {
        Short id = null;
        try{
            Session session = HibernateUtil.getSessao();
            id = (Short)session.save(grupoAcesso);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return id;
    }

    public void atualizar(GrupoAcesso grupoAcesso) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.update(grupoAcesso);
            //session.merge(grupoAcesso);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    public void apagar(GrupoAcesso grupoAcesso) throws Exception {
        try{
            Session session = HibernateUtil.getSessao();
            session.delete(grupoAcesso);
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
    }

    /*
     * Busca registro de grupo de acesso que tenha o id igual ao passado como parametro
     * Se existir retorna objeto GrupoAcesso
     * Senao retorna null
     */
    /*public GrupoAcesso consultarId(Short grupoAcessoId) throws Exception {
        GrupoAcesso out = null;
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(GrupoAcesso.class);
            criteria.add(Restrictions.eq("id", grupoAcessoId));
            criteria.setFetchMode("funcionarioSet", FetchMode.JOIN);
            out = (GrupoAcesso) criteria.uniqueResult();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }*/

    /*
     * Busca registros de grupo de acesso que tenha o id igual ao passado como parametro
     * Se parametro igual a zero, retorna todos
     */
    public List<GrupoAcesso> consultarGrupos(Short grupoAcessoId) throws Exception {
        List<GrupoAcesso> out = new ArrayList<GrupoAcesso>();
        try{
            Session session = HibernateUtil.getSessao();
            Criteria criteria = session.createCriteria(GrupoAcesso.class);
            if (!grupoAcessoId.equals(Short.parseShort("0"))) {
                criteria.add(Restrictions.eq("id", grupoAcessoId));
            }
            criteria.setFetchMode("funcionarioSet", FetchMode.JOIN);
            out = (List<GrupoAcesso>) criteria.list();
            HibernateUtil.confirma();
        } catch (Exception e) {
            HibernateUtil.aborta();
            throw new Exception(e);
        }
        return out;
    }
}