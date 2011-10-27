package service;

import annotations.Boca;
import annotations.HistoricoBoca;
import dao.HistoricoBocaDAO;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.Set;

/**
 *
 * @author Fabricio P. Reis
 */
public class HistoricoBocaService {

    public HistoricoBocaService() {
    }

    /*
     * Salva registro de historicoBoca no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Integer salvar(HistoricoBoca historicoBoca) {
        Integer id = null;
        HistoricoBocaDAO historicoBocaDAO = new HistoricoBocaDAO();
        try {
            id = historicoBocaDAO.salvar(historicoBoca);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro historicoBoca (ID = " + historicoBoca.getId() + ") no banco! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Atualiza registro de historicoBoca no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(HistoricoBoca historicoBoca) {
        HistoricoBocaDAO historicoBocaDAO = new HistoricoBocaDAO();
        try {
            historicoBocaDAO.atualizar(historicoBoca);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de historicoBoca (ID = " + historicoBoca.getId() + ") no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Apaga da base registro igual ao passado como parametro
     */
    public static boolean apagar(HistoricoBoca historicoBoca) {
        HistoricoBocaDAO historicoBocaDAO = new HistoricoBocaDAO();

        try {
            historicoBocaDAO.apagar(historicoBoca);
        }
        catch (Exception e) {
            System.out.println("Falha ao apagar registro de HistoricoBoca (ID = " + historicoBoca.getId() + ") no banco! Metodo HistoricoBocaService.apagar! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base registro 'historicoBoca' com o ID passado como parametro
     * Se encontrar, retorna objeto HistoricoBoca
     * Senao, retorna null
     */
    public static HistoricoBoca getHistoricoBoca(Integer id) {
        HistoricoBocaDAO historicoBocaDAO = new HistoricoBocaDAO();
        HistoricoBoca historicoBoca = null;
        try {
            historicoBoca = historicoBocaDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar HistoricoBoca (ID = " + id + ") no banco! Metodo HistoricoBocaService.getHistoricoBoca(id)! Exception: " + e.getMessage());
            return null;
        }
        return historicoBoca;
    }

    /*
     * Busca na base o historico (Collection<HistoricoBoca>) da boca passada como parametro,
     * ordenando de forma descendente pelo campo 'dataHora'
     * Retorna objeto Collection<HistoricoBoca>
     */
    public static Collection<HistoricoBoca> getHistoricoBocaOrdenadoDescData(Boca boca) {
        HistoricoBocaDAO historicoBocaDAO = new HistoricoBocaDAO();
        Collection<HistoricoBoca> historicoBocaCollection;
        try {
            historicoBocaCollection = historicoBocaDAO.consultarBocaOrdenadoDescData(boca);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar historico de boca (boca ID = " + boca.getId() + ") no banco! Metodo HistoricoBocaService.getHistoricoBocaOrdenadoDescData(Boca)! Exception: " + e.getMessage());
            return null;
        }
        return historicoBocaCollection;
    }

    /*
     * Busca na base os registros de historicoBoca da boca passada como parametro com status orcado,
     * ordenando de forma descendente pelo campo 'dataHora
     * Retorna objeto Collection<HistoricoBoca>
     */
    public static Collection<HistoricoBoca> getHistoricoBocaOrcadoDescData(Boca boca) {
        HistoricoBocaDAO historicoBocaDAO = new HistoricoBocaDAO();
        Collection<HistoricoBoca> historicoBocaCollection;
        try {
            historicoBocaCollection = historicoBocaDAO.consultarBocaOrcadoOrdenadoDescData(boca);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar historico de boca (boca ID = " + boca.getId() + ") no banco! Metodo HistoricoBocaService.getHistoricoBocaOrcadoDescData(Boca)! Exception: " + e.getMessage());
            return null;
        }
        return historicoBocaCollection;
    }

    /*
     * Busca na base registros de historicoBoca da boca passada como parametro com status diferente de orcado,
     * ordenando de forma descendente pelo campo 'dataHora'
     * Retorna objeto Collection<HistoricoBoca>
     */
    public static Collection<HistoricoBoca> getHistoricoBocaDiferenteDeOrcadoDescData(Boca boca) {
        HistoricoBocaDAO historicoBocaDAO = new HistoricoBocaDAO();
        Collection<HistoricoBoca> historicoBocaCollection;
        try {
            historicoBocaCollection = historicoBocaDAO.consultarBocaDiferenteDeOrcadoOrdenadoDescData(boca);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar historico de boca (boca ID = " + boca.getId() + ") no banco! Metodo HistoricoBocaService.getHistoricoBocaDiferenteDeOrcadoDescData(Boca)! Exception: " + e.getMessage());
            return null;
        }
        return historicoBocaCollection;
    }

    /*
     * Retorna o somatorio do valores cobrados do historicoBocaSet passado como parametro
     */
    public static Double getTotalValorCobradoOrcados(Set<HistoricoBoca> historicoBocaSet) {
        Double out = Double.parseDouble("0");

        Iterator iterator = historicoBocaSet.iterator();
        while (iterator.hasNext()) {
            out = out + ((HistoricoBoca) iterator.next()).getValorCobrado();
        }
        return out;
    }

    /*
     * Retorna o somatorio do valores cobrados do historicoBocaSet passado como parametro
     */
    public static Double getTotalValorCobrado(Set<HistoricoBoca> historicoBocaSet) {
        Double out = Double.parseDouble("0");
        Iterator iterator = historicoBocaSet.iterator();
        while (iterator.hasNext()) {
            out = out + ((HistoricoBoca) iterator.next()).getValorCobrado();
        }
        return out;
    }

    /*
     * Quando status de cheques sao alterados para 'irregular' ou comprovantes de pagamento com cartao sao 'cancelados',
     * alem de deduzir saldo da ficha do paciente, caso exista, eh preciso voltar o status do(s) registro(s) de 'historicoBoca'
     * e 'historicoDente' de 'liberado(pago)' para 'orcado'.
     * Este metodo faz este tipo de acerto.
     */
    public static Double acertoDevolucaoValor(Double valor, Boca boca) {
        Double valorAux = valor;
        HistoricoBocaDAO historicoBocaDAO = new HistoricoBocaDAO();
        Collection<HistoricoBoca> historicoBocaCollection = new ArrayList<HistoricoBoca>();
        try {
            historicoBocaCollection = historicoBocaDAO.consultarHistoricosBocaLiberados(boca);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar historicos de boca no banco! Metodo HistoricoBocaService.acertoDevolucaoChequeCancelamentoCartao(" + valor + "," + boca +")! Exception: " + e.getMessage());
        }

        HistoricoBoca historicoBoca;
        Iterator iterator = historicoBocaCollection.iterator();
        while (iterator.hasNext()) {
            historicoBoca = (HistoricoBoca) iterator.next();
            if (historicoBoca.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoPago()) && valorAux >= historicoBoca.getValorCobrado()) {
                historicoBoca.setStatusProcedimento(StatusProcedimentoService.getStatusProcedimentoOrcado());
                if (HistoricoBocaService.atualizar(historicoBoca)) {
                    System.out.println("Registro de HistoricoBoca atualizado com sucesso em acertoDevolucaoChequeCancelamentoCartao(" + valor + "," + boca +")");
                    valorAux -= historicoBoca.getValorCobrado();
                }
                else {
                    System.out.println("Falha ao atualizar registro de HistoricoBoca em acertoDevolucaoChequeCancelamentoCartao(" + valor + "," + boca +")");
                    return null;
                }
            }
        }
        return valorAux;
    }
}