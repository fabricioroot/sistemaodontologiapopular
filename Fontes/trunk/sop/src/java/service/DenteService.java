package service;

import annotations.Boca;
import java.util.Set;
import annotations.Dente;
import annotations.HistoricoDente;
import dao.DenteDAO;
import java.util.HashSet;
import java.util.Iterator;

/**
 *
 * @author Fabricio P. Reis
 */
public class DenteService {

    public DenteService() {
    }

    /*
     * Atualiza registro de dente no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(Dente dente) {
        DenteDAO denteDAO = new DenteDAO();
        try {
            denteDAO.atualizar(dente);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de dente no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Salva registro de dente no banco se ele nao existir, ou atualiza se ele existir
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean salvarOuAtualizar(Dente dente) {
        DenteDAO denteDAO = new DenteDAO();
        try {
            denteDAO.salvarOuAtualizar(dente);
        } catch (Exception e) {
            System.out.println("Falha ao salvar/atualizar registro de dente no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base o dente com o ID passado como parametro
     * Se encontrar, retorna objeto Dente
     * Senao retorna null
     */
    public static Dente getDente(Integer id) {
        DenteDAO denteDAO = new DenteDAO();
        Dente dente = null;
        try {
            dente = denteDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Dente no banco. Metodo DenteService.getDente(id)! Exception: " + e.getMessage());
            return null;
        }
        return dente;
    }

    /*
     * Busca registro de dente para a boca e ID passados como parametros
     * Se encontrar, retorna objeto Dente
     * Senao retorna null
     */
    public static Dente getDente(Boca boca, Integer id) {
        DenteDAO denteDAO = new DenteDAO();
        Dente dente = null;
        try {
            dente = denteDAO.consultarDente(boca, id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Dente no banco. Metodo DenteService.getDente(boca, id)! Exception: " + e.getMessage());
            return null;
        }
        return dente;
    }

    /*
     * Busca registros de Dente da boca passada como parametro
     * Retorna objeto Set<Dente>
     */
    public static Set<Dente> getDentes(Boca boca) {
        DenteDAO denteDAO = new DenteDAO();
        Set<Dente> dente = new HashSet<Dente>();
        try {
            dente = denteDAO.consultarDentes(boca);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Dentes no banco. Metodo DenteService.getDentes(boca)! Exception: " + e.getMessage());
            return null;
        }
        return dente;
    }

    /*
     * Identifica o dente do Set<dente> passado como parametro na posicao passada como parametro
     * Se encontrar, retorna objeto Dente
     * Senao, retorna null
     */
    public static Dente getDente(Set<Dente> dentes, String posicao) {
        Dente out = null;
        Iterator iterator = dentes.iterator();
        Dente denteAux;
        while(iterator.hasNext()) {
            denteAux = (Dente) iterator.next();
            if (denteAux.getPosicao().equals(posicao)) {
                out = denteAux;
                break;
            }
        }
        return out;
    }

    /*
     * Busca registro de dente com seu historico
     * Se encontrar, retorna objeto Dente
     * Senao, retorna null
     */
    public static Dente getHistoricoDente(Dente dente) {
        DenteDAO denteDAO = new DenteDAO();
        Dente out = null;
        try {
            out = denteDAO.consultarHistoricoDente(dente);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar Dente no banco. Metodo DenteService.getDente(boca, id)! Exception: " + e.getMessage());
            return null;
        }
        return out;
    }

    /*
     * Atualiza as faces do dente de acordo com seu historico e retorna
     * objeto dente atualizado
     * O parametro de entrada 'flagControle' indica se a atualizacao
     * deve considerar possivel a volta do status 'liberado (pago)' para 'orcado'
     * ou ir do status 'orcado' para o 'finalizado'
     */
    public static Dente atualizarFaces(Dente dente, boolean flagControle) {
        Short faceDistal = dente.getFaceDistal();
        boolean distalMarcada = false;
        Short faceMesial = dente.getFaceMesial();
        boolean mesialMarcada = false;
        Short faceIncisal = dente.getFaceIncisal();
        boolean incisalMarcada = false;
        Short faceBucal = dente.getFaceBucal();
        boolean bucalMarcada = false;
        Short faceLingual = dente.getFaceLingual();
        boolean lingualMarcada = false;
        Short raiz = dente.getRaiz();
        boolean raizMarcada = false;

        // Variaveis usadas em tratativa para voltar de 'liberado (pago)' para 'orcado'
        boolean faceDistalVoltarLiberadoOrcado = false;
        boolean faceMesialVoltarLiberadoOrcado = false;
        boolean faceIncisalVoltarLiberadoOrcado = false;
        boolean faceBucalVoltarLiberadoOrcado = false;
        boolean faceLingualVoltarLiberadoOrcado = false;
        boolean raizVoltarLiberadoOrcado = false;

        // Variaveis usadas em tratativa para ir de 'orcado' para 'finalizado'
        boolean faceDistalIrOrcadoFinalizado = false;
        boolean faceMesialIrOrcadoFinalizado = false;
        boolean faceIncisalIrOrcadoFinalizado = false;
        boolean faceBucalIrOrcadoFinalizado = false;
        boolean faceLingualIrOrcadoFinalizado = false;
        boolean raizIrOrcadoFinalizado = false;

        Set<HistoricoDente> historicoDenteSet = dente.getHistoricoDenteSet();
        if (!historicoDenteSet.isEmpty()) {
            HistoricoDente historicoDenteAux;
            Iterator iterator = historicoDenteSet.iterator();

            while(iterator.hasNext()) {
                historicoDenteAux = (HistoricoDente) iterator.next();
                // Face distal marcada no historicoDenteAux
                if (historicoDenteAux.getFaceDistal()) {
                    distalMarcada = true;

                    // Tratativa para voltar de 'liberado (pago)' para 'orcado' (exemplos de casos: cheque irregular, comprovante pagamento cartao cancelado, "DES-liberar" um procedimento, ...)
                    if (flagControle && faceDistal.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
                        faceDistalVoltarLiberadoOrcado = true;
                    }

                    // Tratativa para ir de 'orcado' para 'finalizado' (exemplos de casos: excluir um historico orcado e os outros registros de historico estao finalizados...)
                    if (flagControle && faceDistal.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        faceDistalIrOrcadoFinalizado = true;
                    }

                    // Face estah virgem
                    if (faceDistal.equals(Short.parseShort("0"))) {
                        faceDistal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Orcado' e historicoDente com status diferente de 'Finalizado'
                    if (faceDistal.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && !historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        faceDistal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'liberado (pago)' e historicoDente com status igual a 'Executando'
                    if (faceDistal.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento())) {
                        faceDistal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Finalizado'
                    if (faceDistal.equals(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo())) {
                        faceDistal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                }
                // Face mesial marcada no historicoDenteAux
                if (historicoDenteAux.getFaceMesial()) {
                    mesialMarcada = true;

                    // Tratativa para voltar de 'liberado (pago)' para 'orcado' (exemplos de casos: cheque irregular, comprovante pagamento cartao cancelado, "DES-liberar" um procedimento, ...)
                    if (flagControle && faceMesial.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
                        faceMesialVoltarLiberadoOrcado = true;
                    }

                    // Tratativa para ir de 'orcado' para 'finalizado' (exemplos de casos: excluir um historico orcado e os outros registros de historico estao finalizados...)
                    if (flagControle && faceMesial.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        faceMesialIrOrcadoFinalizado = true;
                    }

                    // Face estah virgem
                    if (faceMesial.equals(Short.parseShort("0"))) {
                        faceMesial = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Orcado' e historicoDente com status diferente de 'Finalizado'
                    if (faceMesial.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && !historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        faceMesial = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Pago' e historicoDente com status igual a 'Executando'
                    if (faceMesial.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento())) {
                        faceMesial = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Finalizado'
                    if (faceMesial.equals(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo())) {
                        faceMesial = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                }
                // Face incisal marcada no historicoDenteAux
                if (historicoDenteAux.getFaceIncisal()) {
                    incisalMarcada = true;

                    // Tratativa para voltar de 'liberado (pago)' para 'orcado' (exemplos de casos: cheque irregular, comprovante pagamento cartao cancelado, "DES-liberar" um procedimento, ...)
                    if (flagControle && faceIncisal.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
                        faceIncisalVoltarLiberadoOrcado = true;
                    }

                    // Tratativa para ir de 'orcado' para 'finalizado' (exemplos de casos: excluir um historico orcado e os outros registros de historico estao finalizados...)
                    if (flagControle && faceIncisal.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        faceIncisalIrOrcadoFinalizado = true;
                    }

                    // Face estah virgem
                    if (faceIncisal.equals(Short.parseShort("0"))) {
                        faceIncisal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Orcado' e historicoDente com status diferente de 'Finalizado'
                    if (faceIncisal.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && !historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        faceIncisal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Pago' e historicoDente com status igual a 'Executando'
                    if (faceIncisal.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento())) {
                        faceIncisal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Finalizado'
                    if (faceIncisal.equals(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo())) {
                        faceIncisal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                }
                // Face bucal marcada no historicoDenteAux
                if (historicoDenteAux.getFaceBucal()) {
                    bucalMarcada = true;

                    // Tratativa para voltar de 'liberado (pago)' para 'orcado' (exemplos de casos: cheque irregular, comprovante pagamento cartao cancelado, "DES-liberar" um procedimento, ...)
                    if (flagControle && faceBucal.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
                        faceBucalVoltarLiberadoOrcado = true;
                    }

                    // Tratativa para ir de 'orcado' para 'finalizado' (exemplos de casos: excluir um historico orcado e os outros registros de historico estao finalizados...)
                    if (flagControle && faceBucal.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        faceBucalIrOrcadoFinalizado = true;
                    }

                    // Face estah virgem
                    if (faceBucal.equals(Short.parseShort("0"))) {
                        faceBucal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Orcado' e historicoDente com status diferente de 'Finalizado'
                    if (faceBucal.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && !historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        faceBucal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Pago' e historicoDente com status igual a 'Executando'
                    if (faceBucal.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento())) {
                        faceBucal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Finalizado'
                    if (faceBucal.equals(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo())) {
                        faceBucal = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                }
                // Face lingual marcada no historicoDenteAux
                if (historicoDenteAux.getFaceLingual()) {
                    lingualMarcada = true;

                    // Tratativa para voltar de 'liberado (pago)' para 'orcado' (exemplos de casos: cheque irregular, comprovante pagamento cartao cancelado, "DES-liberar" um procedimento, ...)
                    if (flagControle && faceLingual.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
                        faceLingualVoltarLiberadoOrcado = true;
                    }

                    // Tratativa para ir de 'orcado' para 'finalizado' (exemplos de casos: excluir um historico orcado e os outros registros de historico estao finalizados...)
                    if (flagControle && faceLingual.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        faceLingualIrOrcadoFinalizado = true;
                    }

                    // Face estah virgem
                    if (faceLingual.equals(Short.parseShort("0"))) {
                        faceLingual = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Orcado' e historicoDente com status diferente de 'Finalizado'
                    if (faceLingual.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && !historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        faceLingual = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Pago' e historicoDente com status igual a 'Executando'
                    if (faceLingual.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento())) {
                        faceLingual = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Face com status 'Finalizado'
                    if (faceLingual.equals(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo())) {
                        faceLingual = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                }
                // Raiz marcada no historicoDenteAux
                if (historicoDenteAux.getRaiz()) {
                    raizMarcada = true;

                    // Tratativa para voltar de 'liberado (pago)' para 'orcado' (exemplos de casos: cheque irregular, comprovante pagamento cartao cancelado, "DES-liberar" um procedimento, ...)
                    if (flagControle && raiz.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
                        raizVoltarLiberadoOrcado = true;
                    }

                    // Tratativa para ir de 'orcado' para 'finalizado' (exemplos de casos: excluir um historico orcado e os outros registros de historico estao finalizados...)
                    if (flagControle && raiz.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        raizIrOrcadoFinalizado = true;
                    }

                    // Raiz estah virgem
                    if (raiz.equals(Short.parseShort("0"))) {
                        raiz = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Raiz com status 'Orcado' e historicoDente com status diferente de 'Finalizado'
                    if (raiz.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo()) && !historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoFinalizado())) {
                        raiz = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Raiz com status 'Pago' e historicoDente com status igual a 'Em tratamento'
                    if (raiz.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo()) && historicoDenteAux.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoEmTratamento())) {
                        raiz = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                    else

                    // Raiz com status 'Finalizado'
                    if (raiz.equals(StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo())) {
                        raiz = historicoDenteAux.getStatusProcedimento().getCodigo();
                    }
                }
            } // while(iterator.hasNext())

            // Tratativas para voltar de 'liberado (pago)' para 'orcado'
            if (faceDistalVoltarLiberadoOrcado && faceDistal.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())) {
                faceDistal = StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo();
            }
            if (faceMesialVoltarLiberadoOrcado && faceMesial.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())) {
                faceMesial = StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo();
            }
            if (faceIncisalVoltarLiberadoOrcado && faceIncisal.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())) {
                faceIncisal = StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo();
            }
            if (faceBucalVoltarLiberadoOrcado && faceBucal.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())) {
                faceBucal = StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo();
            }
            if (faceLingualVoltarLiberadoOrcado && faceLingual.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())) {
                faceLingual = StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo();
            }
            if (raizVoltarLiberadoOrcado && raiz.equals(StatusProcedimentoService.getStatusProcedimentoPago().getCodigo())) {
                raiz = StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo();
            }
            // Fim das tratativas

            // Tratativas para ir de 'orcado' para 'finalizado'
            if (faceDistalIrOrcadoFinalizado && faceDistal.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())) {
                faceDistal = StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo();
            }
            if (faceMesialIrOrcadoFinalizado && faceMesial.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())) {
                faceMesial = StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo();
            }
            if (faceIncisalIrOrcadoFinalizado && faceIncisal.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())) {
                faceIncisal = StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo();
            }
            if (faceBucalIrOrcadoFinalizado && faceBucal.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())) {
                faceBucal = StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo();
            }
            if (faceLingualIrOrcadoFinalizado && faceLingual.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())) {
                faceLingual = StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo();
            }
            if (raizIrOrcadoFinalizado && raiz.equals(StatusProcedimentoService.getStatusProcedimentoOrcado().getCodigo())) {
                raiz = StatusProcedimentoService.getStatusProcedimentoFinalizado().getCodigo();
            }
            // Fim das tratativas

            // Caso alguma face nao estiver marcada, seu status eh 'virgem' (codigo = 0)
            if (!distalMarcada) {
                faceDistal = Short.parseShort("0");
            }
            if (!mesialMarcada) {
                faceMesial = Short.parseShort("0");
            }
            if (!incisalMarcada) {
                faceIncisal = Short.parseShort("0");
            }
            if (!bucalMarcada) {
                faceBucal = Short.parseShort("0");
            }
            if (!lingualMarcada) {
                faceLingual = Short.parseShort("0");
            }
            if (!raizMarcada) {
                raiz = Short.parseShort("0");
            }

        } // if (!historicoDenteSet.isEmpty())
        else {
            faceDistal = Short.parseShort("0");
            faceMesial = Short.parseShort("0");
            faceIncisal = Short.parseShort("0");
            faceBucal = Short.parseShort("0");
            faceLingual = Short.parseShort("0");
            raiz = Short.parseShort("0");
        }

        dente.setFaceDistal(faceDistal);
        dente.setFaceMesial(faceMesial);
        dente.setFaceIncisal(faceIncisal);
        dente.setFaceBucal(faceBucal);
        dente.setFaceLingual(faceLingual);
        dente.setRaiz(raiz);
        return dente;
    }
}