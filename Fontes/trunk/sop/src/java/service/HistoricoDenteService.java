package service;

import annotations.Dente;
import annotations.HistoricoDente;
import annotations.Boca;
import dao.HistoricoDenteDAO;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

/**
 *
 * @author Fabricio P. Reis
 */
public class HistoricoDenteService {

    public HistoricoDenteService() {
    }

    /*
     * Salva registro de historicoDente no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Integer salvar(HistoricoDente historicoDente) {
        Integer id = null;
        HistoricoDenteDAO historicoDenteDAO = new HistoricoDenteDAO();
        try {
            id = historicoDenteDAO.salvar(historicoDente);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro historicoDente (ID = " + historicoDente.getId() + ") no banco! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Atualiza registro de historicoDente no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(HistoricoDente historicoDente) {
        HistoricoDenteDAO historicoDenteDAO = new HistoricoDenteDAO();
        try {
            historicoDenteDAO.atualizar(historicoDente);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de historicoDente (ID = " + historicoDente.getId() + ") no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Apaga da base registro igual ao passado como parametro
     */
    public static boolean apagar(HistoricoDente historicoDente) {
        HistoricoDenteDAO historicoDenteDAO = new HistoricoDenteDAO();

        try {
            historicoDenteDAO.apagar(historicoDente);
        }
        catch (Exception e) {
            System.out.println("Falha ao apagar registro de HistoricoDente (ID = " + historicoDente.getId() + ") no banco! Metodo HistoricoDenteService.apagar! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca registro de historicoDente com o ID passado como parametro
     * Se encontrar, retorna objeto HistoricoDente
     * Senao, retorna null
     */
    public static HistoricoDente getHistoricoDente(Integer id) {
        HistoricoDenteDAO historicoDenteDAO = new HistoricoDenteDAO();
        HistoricoDente historicoDente = null;

        try {
            historicoDente = historicoDenteDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar HistoricoDente (ID = " + id + ") no banco! Metodo HistoricoDenteService.getHistoricoDente(id)! Exception: " + e.getMessage());
            return null;
        }
        return historicoDente;
    }

    /*
     * Busca registro de 'historicoDente' do dente passado como parametro,
     * ordenando de forma descendente pelo campo 'dataHora'
     * Retorna objeto Collection<HistoricoDente>
     */
    public static Collection<HistoricoDente> getHistoricoDenteOrdenadoDescData(Dente dente) {
        HistoricoDenteDAO historicoDenteDAO = new HistoricoDenteDAO();
        Collection<HistoricoDente> historicoDenteCollection;
        try {
            historicoDenteCollection = historicoDenteDAO.consultarDenteOrdenadoDescData(dente);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar historico de dente (dente ID = " + dente.getId() + ") no banco! Metodo HistoricoDenteService.getHistoricoDenteOrdenadoDescData(dente)! Exception: " + e.getMessage());
            return null;
        }
        return historicoDenteCollection;
    }

    /*
     * Busca na base os registros de historicoDente com status orcado dos dentes passados como parametro,
     * ordenando de forma descendente pelo camop 'dataHora'
     * Retorna objeto Collection<HistoricoDente>
     */
    public static Collection<HistoricoDente> getHistoricoDenteOrcadoPagoTratandoDescData(Collection<Dente> dentes) {
        HistoricoDenteDAO historicoDenteDAO = new HistoricoDenteDAO();
        Collection<HistoricoDente> historicoDenteCollectionAux;
        Collection<HistoricoDente> historicosDentesOrcados = new ArrayList<HistoricoDente>();
        Iterator iterator = dentes.iterator();
        while (iterator.hasNext()) {
            Dente denteAux = (Dente) iterator.next();
            // wtf!?
            // Se pelo menos uma das faces do dente estiver com status orcado, pago ou tratando entao busca historicoDente com status orcado, pago ou tratando
            if (denteAux.getFaceBucal().equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())
            || denteAux.getFaceDistal().equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())
            || denteAux.getFaceIncisal().equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())
            || denteAux.getFaceLingual().equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())
            || denteAux.getFaceMesial().equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())
            || denteAux.getRaiz().equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())
            || denteAux.getFaceBucal().equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())
            || denteAux.getFaceDistal().equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())
            || denteAux.getFaceIncisal().equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())
            || denteAux.getFaceLingual().equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())
            || denteAux.getFaceMesial().equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())
            || denteAux.getRaiz().equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())
            || denteAux.getFaceBucal().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento().getCodigo())
            || denteAux.getFaceDistal().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento().getCodigo())
            || denteAux.getFaceIncisal().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento().getCodigo())
            || denteAux.getFaceLingual().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento().getCodigo())
            || denteAux.getFaceMesial().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento().getCodigo())
            || denteAux.getRaiz().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento().getCodigo())){
                try {
                    historicoDenteCollectionAux = historicoDenteDAO.consultarDenteOrcadoPagoTratandoOrdenadoDescData(denteAux);
                }
                catch (Exception e) {
                    System.out.println("Falha ao consultar historico de dente no banco! Metodo HistoricoDenteService.getHistoricoDenteOrcadoDesData(dente)! Exception: " + e.getMessage());
                    return null;
                }
                if (!historicoDenteCollectionAux.isEmpty()) {
                    historicosDentesOrcados.addAll(historicoDenteCollectionAux);
                }
            }
        }
        return historicosDentesOrcados;
    }

    /*
     * Busca na base registros de historicoDente com status diferente de orcado dos dentes passados como parametro,
     * ordenando de forma descendente pelo campo 'dataHora'
     * Retorna objeto Collection<HistoricoDente>
     */
    public static Collection<HistoricoDente> getHistoricoDenteDiferenteDeOrcadoDescData(Collection<Dente> dentes) {
        HistoricoDenteDAO historicoDenteDAO = new HistoricoDenteDAO();
        Collection<HistoricoDente> historicoDenteCollectionAux;
        Collection<HistoricoDente> historicosDentesDiferenteDeOrcados = new ArrayList<HistoricoDente>();
        Iterator iterator = dentes.iterator();
        while (iterator.hasNext()) {
            Dente denteAux = (Dente) iterator.next();
            try {
                historicoDenteCollectionAux = historicoDenteDAO.consultarDenteDiferenteDeOrcadoOrdenadoDescData(denteAux);
            }
            catch (Exception e) {
                System.out.println("Falha ao consultar historico de dente no banco! Metodo HistoricoDenteService.getHistoricoDenteDiferenteDeOrcadoDescData(dente)! Exception: " + e.getMessage());
                return null;
            }
            if (!historicoDenteCollectionAux.isEmpty()) {
                historicosDentesDiferenteDeOrcados.addAll(historicoDenteCollectionAux);
            }
        }
        return historicosDentesDiferenteDeOrcados;
    }

    /*
     * Seleciona e retorna objeto Set<HistoricoDente> contendo somente registros de 'HistoricoDente'
     * que pertencem ao paciente passado como parametro
     */
    public static Set<HistoricoDente> getHistoricoDenteXPaciente(Set<HistoricoDente> historicoDenteSet, Integer idPaciente) {
        HistoricoDente historicoDenteAux;
        Set<HistoricoDente> out = new HashSet<HistoricoDente>();
        Iterator iterator = historicoDenteSet.iterator();
        while (iterator.hasNext()) {
            historicoDenteAux = (HistoricoDente) iterator.next();
            if (historicoDenteAux.getDente().getBoca().getPaciente().getId().equals(idPaciente)) {
                out.add(historicoDenteAux);
            }
        }
        return out;
    }

    /*
     * Retorna o somatorio do valores cobrados do historicoDenteSet passado como parametro
     */
    public static Double getTotalValorCobradoOrcados(Set<HistoricoDente> historicoDenteSet) {
        Double out = Double.parseDouble("0");
        Iterator iterator = historicoDenteSet.iterator();
        while (iterator.hasNext()) {
            out = out + ((HistoricoDente) iterator.next()).getValorCobrado();
        }

        return out;
    }

    /*
     * Retorna o somatorio do valores cobrados do historicoDenteCollection passado como parametro
     */
    public static Double getTotalValorCobrado(Collection<HistoricoDente> historicoDenteColletcion) {
        Double out = Double.parseDouble("0");
        Iterator iterator = historicoDenteColletcion.iterator();
        while (iterator.hasNext()) {
            out = out + ((HistoricoDente) iterator.next()).getValorCobrado();
        }
        return out;
    }

    /*
     * Quando status de cheques sao alterados para 'irregular' ou comprovantes de pagamento com cartao sao 'cancelados',
     * alem de deduzir saldo da ficha do paciente, caso exista, eh preciso voltar o status do(s) registro(s) de 'historicoDente'
     * e 'historicoBoca' de 'liberado(pago)' para 'orcado'
     * Este metodo faz este tipo de acerto.
     */
    public static Double acertoDevolucaoValor(Double valor, Boca boca) {
        Double valorAux = valor;
        HistoricoDenteDAO historicoDenteDAO = new HistoricoDenteDAO();
        Collection<HistoricoDente> historicoDenteCollection = new ArrayList<HistoricoDente>();
        try {
            historicoDenteCollection = historicoDenteDAO.consultarHistoricosDentesLiberados(boca);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar historicos de dentes no banco! Metodo HistoricoDenteService.acertoDevolucaoChequeCancelamentoCartao(" + valor + "," + boca +")! Exception: " + e.getMessage());
        }

        HistoricoDente historicoDente;
        Iterator iterator = historicoDenteCollection.iterator();
        while (iterator.hasNext()) {
            historicoDente = (HistoricoDente) iterator.next();
            if (historicoDente.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoPago()) && valorAux >= historicoDente.getValorCobrado()) {
                historicoDente.setStatusProcedimento(StatusProcedimentoService.getStatusProcedimentoOrcado());
                if (HistoricoDenteService.atualizar(historicoDente)) {
                    System.out.println("Registro de HistoricoDente (ID = " + historicoDente.getId() + ") atualizado com sucesso em acertoDevolucaoChequeCancelamentoCartao(" + valor + "," + boca +")");
                    valorAux -= historicoDente.getValorCobrado();
                    // Busca objeto dente com seu historico, atualiza suas faces e atualiza a base de dados
                    Dente denteAux = DenteService.getHistoricoDente(historicoDente.getDente());
                    Dente denteAux2 = DenteService.atualizarFaces(denteAux, true);
                    if (DenteService.atualizar(denteAux2)) {
                        System.out.println("Registro de dente (ID = " + denteAux2.getId() + ") atualizado com sucesso em acertoDevolucaoChequeCancelamentoCartao(" + valor + "," + boca +")");
                    }
                    else {
                        System.out.println("Falha ao atualizar dente (ID = " + denteAux2.getId() + ") em acertoDevolucaoChequeCancelamentoCartao(" + valor + "," + boca +")");
                        return null;
                    }
                }
                else {
                    System.out.println("Falha ao atualizar registro de HistoricoDente (ID = " + historicoDente.getId() + ") em acertoDevolucaoChequeCancelamentoCartao(" + valor + "," + boca +")");
                    return null;
                }
            }
        }
        return valorAux;
    }
}