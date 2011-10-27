package web.chequeBancario;

import annotations.ChequeBancario;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import service.ChequeBancarioService;
import service.StatusChequeBancarioService;

/**
 *
 * @author Fabricio Reis
 */
public class CadastrarChequeBancarioAction extends org.apache.struts.action.Action {

    private static final String SUCESSO = "sucesso";
    private static final String FALHAFORMATARDATA = "falhaFormatarData";
    private static final String OBRIGATORIOSEMBRANCO = "obrigatoriosEmBranco";
    private static final String SESSAOINVALIDA = "sessaoInvalida";

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // Controle de sessao
        if (request.getSession(false).getAttribute("status") == null) {
            return mapping.findForward(SESSAOINVALIDA);
        }
        else {
            if(!(Boolean)request.getSession(false).getAttribute("status")) {
                return mapping.findForward(SESSAOINVALIDA);
            }
        }

        CadastrarChequeBancarioActionForm formChequeBancario = (CadastrarChequeBancarioActionForm) form;

        if ((formChequeBancario.getNomeTitular().trim().isEmpty()) || (formChequeBancario.getCpfTitular().trim().isEmpty())
            || (formChequeBancario.getBanco().equals("selected") && formChequeBancario.getOutroBanco().trim().isEmpty())
            || (formChequeBancario.getNumero().trim().isEmpty()) || (formChequeBancario.getValor().toString().trim().isEmpty())
            || (formChequeBancario.getValor() <= Double.parseDouble("0")) || (formChequeBancario.getDataParaDepositar().toString().trim().isEmpty()) ) {
            return mapping.findForward(OBRIGATORIOSEMBRANCO);
        }

        // Captura o Collection<ChequeBancario> da sessao
        Collection<ChequeBancario> chequeBancarioCollection = new ArrayList<ChequeBancario>();
        if (request.getSession(false).getAttribute("chequeBancarioCollectionPagar") != null) {
            chequeBancarioCollection = (Collection<ChequeBancario>)request.getSession(false).getAttribute("chequeBancarioCollectionPagar");
        }

        // Verifica se o registro ja nao foi incluido
        if (!chequeBancarioCollection.isEmpty()) {
            ChequeBancario chequeBancarioAux;
            Iterator iterator = chequeBancarioCollection.iterator();
            while (iterator.hasNext()) {
                chequeBancarioAux = (ChequeBancario) iterator.next();
                if (chequeBancarioAux.getNumero().equals(formChequeBancario.getNumero().trim()) && (chequeBancarioAux.getBanco().equals(formChequeBancario.getBanco().trim())
                || chequeBancarioAux.getBanco().equals(formChequeBancario.getOutroBanco().trim()))) {
                    System.out.println("Registro de cheque ja incluido na sessao! Excecao mapeada em CadastrarChequeBancarioAction.");
                    return mapping.findForward(SUCESSO);
                }
            }
        }

        ChequeBancario chequeBancario = new ChequeBancario();
        chequeBancario.setNomeTitular(formChequeBancario.getNomeTitular().trim());
        chequeBancario.setCpfTitular(formChequeBancario.getCpfTitular().trim());
        chequeBancario.setRgTitular(formChequeBancario.getRgTitular().trim());
        if (formChequeBancario.getBanco().equals("selected")) {
            chequeBancario.setBanco(formChequeBancario.getOutroBanco().trim());
        }
        else {
            chequeBancario.setBanco(formChequeBancario.getBanco().trim());
        }
        chequeBancario.setNumero(formChequeBancario.getNumero().trim());
        chequeBancario.setValor(formChequeBancario.getValor());
        
        Date dataParaDepositar = new Date();
        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
        try {
            dataParaDepositar = formatador.parse(formChequeBancario.getDataParaDepositar().trim());
        } catch (Exception e) {
            System.out.println("Falha ao formatar a data para depositar de cheque bancario em cadastro! Exception: " + e.getMessage());
            return mapping.findForward(FALHAFORMATARDATA);
        }

        chequeBancario.setDataParaDepositar(dataParaDepositar);
        chequeBancario.setStatus(StatusChequeBancarioService.getStatusChequeBancarioNaoDepositado());

        // Adiciona registro no Collection<ChequeBancario> criado / capturado
        chequeBancarioCollection.add(chequeBancario);

        // Atualiza / Coloca chequeBancarioCollection na sessao
        request.getSession(false).setAttribute("chequeBancarioCollectionPagar", chequeBancarioCollection);

        // Calcula o total dos cheques cadastrados e coloca o valor no request
        request.getSession(false).setAttribute("totalCheques", ChequeBancarioService.calcularTotal(chequeBancarioCollection));

        return mapping.findForward(SUCESSO);
    }
}