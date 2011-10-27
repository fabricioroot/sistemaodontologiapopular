package service;

import annotations.AtendimentoOrcamento;
import annotations.Ficha;
import annotations.FilaAtendimentoOrcamento;
import dao.AtendimentoOrcamentoDAO;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

/**
 *
 * @author Fabricio P. Reis
 */
public class AtendimentoOrcamentoService {

    public AtendimentoOrcamentoService() {
    }

    /*
     * Salva registro de atendimento orcamento no banco
     * Se sucesso, retorna o ID do objeto salvo
     * Senao retorna null
     */
    public static Integer salvar(AtendimentoOrcamento atendimentoOrcamento) {
        Integer id = null;
        AtendimentoOrcamentoDAO atendimentoOrcamentoDAO = new AtendimentoOrcamentoDAO();
        try {
            id =atendimentoOrcamentoDAO.salvar(atendimentoOrcamento);
        } catch (Exception e) {
            System.out.println("Falha ao salvar registro de atendimento orcamento no banco! Falha ao incluir atendimento orcamento na fila! Exception: " + e.getMessage());
        }
        return id;
    }

    /*
     * Atualiza registro de atendimento orcamento no banco
     * Se sucesso, retorna true
     * Senao retorna false
     */
    public static boolean atualizar(AtendimentoOrcamento atendimentoOrcamento) {
        AtendimentoOrcamentoDAO atendimentoOrcamentoDAO = new AtendimentoOrcamentoDAO();
        try {
            atendimentoOrcamentoDAO.atualizar(atendimentoOrcamento);
        } catch (Exception e) {
            System.out.println("Falha ao atualizar registro de atendimento orcamento no banco! Exception: " + e.getMessage());
            return false;
        }
        return true;
    }

    /*
     * Busca na base registro de atendimentoOrcamento com o ID passado como parametro
     * Se encontrar, retorna objeto AtendimentoOrcamento
     * Senao retorna null
     */
    public static AtendimentoOrcamento getAtendimentoOrcamento(Integer id) {
        AtendimentoOrcamentoDAO atendimentoOrcamentoDAO = new AtendimentoOrcamentoDAO();
        AtendimentoOrcamento atendimentoOrcamento = null;
        try {
            atendimentoOrcamento = atendimentoOrcamentoDAO.consultarId(id);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar AtendimentoOrcamento no banco! Metodo AtendimentoOrcamentoService.getAtendimentoOrcamento(id)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return atendimentoOrcamento;
    }

    /*
     * Instancia objeto AtendimentoOrcamento e marca Id = 1 (Atendimeto-Orcamento-Sistema)
     */
    public static AtendimentoOrcamento getAtendimentoOrcamentoSistema() {
        AtendimentoOrcamento atendimentoOrcamento = new AtendimentoOrcamento();
        atendimentoOrcamento.setId(1);
        return atendimentoOrcamento;
    }

    /*
     * Cria um objeto AtendimentoOrcamento associado ah ficha passada como parametro
     * onde o dentista marcado eh o dentista-sistema
     */
    public static AtendimentoOrcamento getNovoAtendimentoOrcamento(Ficha ficha, FilaAtendimentoOrcamento filaAtendimentoOrcamento) {
        AtendimentoOrcamento atendimentoOrcamento = new AtendimentoOrcamento();
        atendimentoOrcamento.setDataCriacao(new Date());
        atendimentoOrcamento.setPrioridade(Boolean.FALSE);
        atendimentoOrcamento.setComissaoDentista(Double.parseDouble("0")); // Dentista-sistema -> comissao = 0
        atendimentoOrcamento.setFicha(ficha);
        atendimentoOrcamento.setDentista(DentistaService.getDentistaSistema());
        atendimentoOrcamento.setFilaAtendimentoOrcamento(filaAtendimentoOrcamento);
        return atendimentoOrcamento;
    }

    /*
     * Busca na base os registros de atendimentos de orcamentos que estao na fila de espera
     * Retorna Collection<AtendimentoOrcamento>
     */
    public static Collection<AtendimentoOrcamento> getAtendimentosFilaAtendimentoOrcamento() {
        Collection<AtendimentoOrcamento> atendimentoOrcamentoCollection = new ArrayList<AtendimentoOrcamento>();
        AtendimentoOrcamentoDAO atendimentoOrcamentoDAO = new AtendimentoOrcamentoDAO();
        try {
            atendimentoOrcamentoCollection = atendimentoOrcamentoDAO.consultarFilaAtendimentoOrcamento(FilaAtendimentoOrcamentoService.getFilaAtendimentoOrcamento());
        } catch (Exception e) {
            System.out.println("Falha ao buscar todos registros de atendimento orcamento da fila de atendimento orcamento! Metodo AtendimentoOrcamentoService.getAtendimentosFilaAtendimentoOrcamento. Exception: " + e.getMessage());
            return null;
        }
        return atendimentoOrcamentoCollection;
    }

    /*
     * Busca na base os registros de atendimentos de orcamentos que estao em atendimento
     * Retorna ArrayList<AtendimentoOrcamento>
     */
    public static Collection<AtendimentoOrcamento> getAtendimentosFilaAtendimentoOrcamentoEmAtendimento() {
        Collection<AtendimentoOrcamento> atendimentoOrcamentoCollection = new ArrayList<AtendimentoOrcamento>();
        AtendimentoOrcamentoDAO atendimentoOrcamentoDAO = new AtendimentoOrcamentoDAO();
        try {
            atendimentoOrcamentoCollection = atendimentoOrcamentoDAO.consultarFilaAtendimentoOrcamentoEmAtendimento(FilaAtendimentoOrcamentoService.getFilaAtendimentoOrcamentoEmAtendimento());
        } catch (Exception e) {
            System.out.println("Falha ao buscar todos registros de atendimento orcamento em atendimento! Metodo AtendimentoOrcamentoService.getAtendimentosFilaAtendimentoOrcamentoEmAtendimento. Exception: " + e.getMessage());
            return null;
        }
        return atendimentoOrcamentoCollection;
    }

    /*
     * Busca registro de atendimentoOrcamento para a ficha passada como parametro, que nao foi iniciado nem priorizado.
     * Se encontrar, retorna objeto AtendimentoOrcamento
     * Senao, retorna null
     */
    public static AtendimentoOrcamento getAtendimentoOrcamentoNaoIniciadoNaoPriorizado(Ficha ficha) {
        AtendimentoOrcamentoDAO atendimentoOrcamentoDAO = new AtendimentoOrcamentoDAO();
        AtendimentoOrcamento atendimentoOrcamento = null;

        try {
            atendimentoOrcamento = atendimentoOrcamentoDAO.consultarAtendimentoOrcamentoNaoIniciadoNaoPriorizado(ficha);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar AtendimentoOrcamento no banco! Metodo AtendimentoOrcamentoService.getAtendimentoOrcamentoNaoIniciadoNaoPriorizado(ficha)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return atendimentoOrcamento;
    }

    /*
     * Busca registro de atendimentoOrcamento para a ficha passada como parametro, que nao foi iniciado.
     * Se encontrar, retorna objeto AtendimentoOrcamento
     * Senao retorna null
     */
    public static AtendimentoOrcamento getAtendimentoOrcamentoNaoIniciado(Ficha ficha) {
        AtendimentoOrcamentoDAO atendimentoOrcamentoDAO = new AtendimentoOrcamentoDAO();
        AtendimentoOrcamento atendimentoOrcamento = null;

        try {
            atendimentoOrcamento = atendimentoOrcamentoDAO.consultarAtendimentoOrcamentoNaoIniciado(ficha);
        }
        catch (Exception e) {
            System.out.println("Falha ao consultar AtendimentoOrcamento no banco! Metodo AtendimentoOrcamentoService.getAtendimentoOrcamentoNaoIniciado(ficha)! Exception: " + e.getMessage() + e.getCause());
            return null;
        }
        return atendimentoOrcamento;
    }
}