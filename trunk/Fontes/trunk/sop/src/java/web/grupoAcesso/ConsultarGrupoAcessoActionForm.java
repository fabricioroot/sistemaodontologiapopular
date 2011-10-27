package web.grupoAcesso;

/**
 *
 * @author Fabricio Reis
 */
public class ConsultarGrupoAcessoActionForm extends org.apache.struts.action.ActionForm {

    private Short grupoAcessoId;

    public ConsultarGrupoAcessoActionForm() {
    }

    public Short getGrupoAcessoId() {
        return grupoAcessoId;
    }

    public void setGrupoAcessoId(Short grupoAcessoId) {
        this.grupoAcessoId = grupoAcessoId;
    }
}
