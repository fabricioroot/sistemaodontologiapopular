package service;

import java.util.Collection;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.proxy.dwr.Util;

/**
 *
 * @author Fabricio P. Reis
 */
public class DwrUtil {

    public static Util getUtil() {
        WebContext webcontext = WebContextFactory.get();
        String paginaCorrente = webcontext.getCurrentPage();
        Collection sessions = webcontext.getScriptSessionsByPage(paginaCorrente);
        Util util = new Util(sessions);
        return util;
    }
}