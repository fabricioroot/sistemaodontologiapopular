package web.login;

/**
 *
 * @author Fabricio P. Reis
 */
import annotations.GrupoAcesso;
import java.util.Set;
import java.util.Iterator;

public class ValidaGrupos {

    public static boolean validaGrupo(Set<GrupoAcesso> gruposDeAcesso, String grupo){
        GrupoAcesso aux;
        boolean out = false;

        if(gruposDeAcesso != null && !gruposDeAcesso.isEmpty()){
            Iterator it = gruposDeAcesso.iterator();
            while(it.hasNext()){
                aux = (GrupoAcesso)it.next();
                if(aux.getNome().equalsIgnoreCase(grupo.trim()))
                    out = true;
            }
        }
        return out;
    }
}