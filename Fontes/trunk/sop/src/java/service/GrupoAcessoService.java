package service;

import annotations.GrupoAcesso;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author Fabricio P. Reis
 */
public class GrupoAcessoService {

    public GrupoAcessoService() {
    }

    /*
     * Instancia objetos GrupoAcesso de acordo com os ids passados como paramentro e os
     * adiciona no set de retorno do metodo.
     * Retorna Set<AtendimentoOrcamento>
     */
    public static Set<GrupoAcesso> getGruposAcesso(String[] grupoAcesso) {
        Set<GrupoAcesso> grupoAcessoSet = new HashSet<GrupoAcesso>();
        GrupoAcesso grupoAcessoAux;
        for (int i = 0; i < grupoAcesso.length; i++) {
            grupoAcessoAux = new GrupoAcesso();
            grupoAcessoAux.setId(Short.parseShort(grupoAcesso[i]));
            grupoAcessoSet.add(grupoAcessoAux);
        }
        return grupoAcessoSet;
    }
}